"
APRecordedInteraction steht für eine Interaktion, die als Schritt in einem Unit-Test verwendbar ist. Aus einem solchen Objekt wird schließlich Source-Code für Unit-Tests erzeugt.
"
Class {
	#name : #APRecordedInteraction,
	#superclass : #Object,
	#instVars : [
		'type',
		'key',
		'value',
		'isOpenForSubs',
		'subInteractions',
		'expectedStates'
	],
	#category : #'APart Recording'
}

{ #category : #'instance creation' }
APRecordedInteraction class >> action [

	^(self new)
		type: #action;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> complexPrompt [

	^(self new)
		type: #complexPrompt;
		isOpenForSubs: true;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> simplePrompt [

	^(self new)
		type: #simplePrompt;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> special [

	^(self new)
		type: #special;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> special: aKey [

	^(self special)
		key: aKey;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> special: aKey value: aValue [

	^(self special)
		key: aKey;
		value: aValue;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> trigger [

	^(self new)
		type: #trigger;
		yourself
]

{ #category : #'instance creation' }
APRecordedInteraction class >> valueChange [

	^(self new)
		type: #valueChange;
		yourself
]

{ #category : #API }
APRecordedInteraction >> addSubInteraction: anInteraction [

	self isOpenForSubs ifFalse: [^nil].
	self subInteractions notEmpty
		ifTrue: 
			[(self subInteractions last addSubInteraction: anInteraction) notNil
				ifTrue: [^anInteraction]].
	self subInteractions add: anInteraction.
	^anInteraction
]

{ #category : #API }
APRecordedInteraction >> allLastInteractions [

	| result |
	result := Array with: self.
	subInteractions size = 0 ifTrue: [^result].
	^result , subInteractions last allLastInteractions
]

{ #category : #API }
APRecordedInteraction >> assignEndAction: anAction value: aValue [

	(self findOpenInteractionFor: anAction)
		ifNotNil: 
			[:ia |
			ia value: aValue.
			ia isOpenForSubs: false.
			^ia].

	"Dieser Zweig sollte nie erreicht werden, da er eine nicht geöffnete Action beenden will"
	^self subInteractions add: anAction createRecordedInteraction
]

{ #category : #API }
APRecordedInteraction >> expectedStates [

	^expectedStates
]

{ #category : #private }
APRecordedInteraction >> findOpenInteractionFor: anAction [

	self isOpenForSubs ifFalse: [^nil].
	value == anAction ifTrue: [^self].
	subInteractions isEmpty ifTrue: [^nil].
	^subInteractions last findOpenInteractionFor: anAction
]

{ #category : #API }
APRecordedInteraction >> isComment [

	^type = #special and: [key = #comment or: [key = #printString]]
]

{ #category : #API }
APRecordedInteraction >> isOpenForSubs [

	^isOpenForSubs == true
]

{ #category : #API }
APRecordedInteraction >> isOpenForSubs: aBoolean [

	isOpenForSubs := aBoolean
]

{ #category : #API }
APRecordedInteraction >> isPromptCall [

	^type = #simplePrompt or: [type = #complexPrompt]
]

{ #category : #API }
APRecordedInteraction >> isSpecial: aKey [

	^type = #special and: [key = aKey]
]

{ #category : #API }
APRecordedInteraction >> key [

	^key
]

{ #category : #'initialize-release' }
APRecordedInteraction >> key: anObject [

	key := anObject
]

{ #category : #API }
APRecordedInteraction >> lastOpenInteraction [

	subInteractions size = 0 ifTrue: [^self].
	^subInteractions last isOpenForSubs
		ifTrue: [subInteractions last lastOpenInteraction]
		ifFalse: [self]
]

{ #category : #API }
APRecordedInteraction >> matchYourselfOrSubInteractions: matchBlock [

	(matchBlock value: self) ifTrue: [^self].
	subInteractions size > 0
		ifTrue: 
			[subInteractions do: 
					[:si |
					(si matchYourselfOrSubInteractions: matchBlock)
						ifNotNil: [:matchingSI | ^matchingSI]]].
	^nil
]

{ #category : #printing }
APRecordedInteraction >> printOn: s [

	super printOn: s.
	type isNil ifTrue: [^self].
	s
		nextPutAll: ' (';
		nextPutAll: type printString;
		space;
		nextPutAll: key printString;
		nextPut: $).
	subInteractions notNil
		ifTrue: 
			[s
				nextPut: ${;
				nextPutAll: subInteractions size printString;
				nextPutAll: ' subInteractions}']
		ifFalse: 
			[value notNil
				ifTrue: 
					[s
						nextPut: ${;
						nextPutAll: value printString;
						nextPutAll: '}']]
]

{ #category : #API }
APRecordedInteraction >> recordCalledSubInteractions: subClientInteractions [

	"type = #complexPrompt ifFalse: [self halt]."
	self subInteractions addAll: subClientInteractions
]

{ #category : #'as yet unclassified' }
APRecordedInteraction >> setExpectedStatesIfUndefinedFrom: aDictionary logger: aLogger [

	| interactionString keysToLog isKeepingStates |
	expectedStates isNil
		ifTrue: 
			[isKeepingStates := false.
			expectedStates := APExpectedStates onStates: aDictionary]
		ifFalse: [isKeepingStates := true].
	keysToLog := aLogger loggedKeysFrom: aDictionary.
	keysToLog isEmpty ifTrue: [^self].
	interactionString := 'Interaction ' , type printString , '/'
				, key printString.
	isKeepingStates
		ifFalse: 
			[keysToLog do: 
					[:k |
					aLogger
						logLine: interactionString , ' is setting'
						key: k
						isActive: (aDictionary at: k
								ifAbsent: 
									[aLogger logLine: 'Missing key' key: k isActive: false.
									false])].
			^self].
	aLogger logLine: interactionString , ' is keeping states'.
	keysToLog do: 
			[:k |
			expectedStates at: k
				ifPresent: 
					[:v |
					v = (aDictionary at: k ifAbsent: [v])
						ifFalse: 
							[aLogger
								logLine: 'Mismatch for'
								key: k
								isActive: (aDictionary at: k)]]]
]

{ #category : #API }
APRecordedInteraction >> subInteractions [

	subInteractions isNil ifTrue: [subInteractions := OrderedCollection new].
	^subInteractions
]

{ #category : #API }
APRecordedInteraction >> subInteractionsOrNil [

	^subInteractions
]

{ #category : #API }
APRecordedInteraction >> type [

	^type
]

{ #category : #'initialize-release' }
APRecordedInteraction >> type: anObject [

	type := anObject
]

{ #category : #API }
APRecordedInteraction >> value [

	^value
]

{ #category : #'initialize-release' }
APRecordedInteraction >> value: anObject [

	value := anObject
]
