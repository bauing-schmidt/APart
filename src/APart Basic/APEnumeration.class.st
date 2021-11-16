"
APEnumeration serves as a container for a semantically related list of enumerated values.

--

DE:APEnumeration dient als Container für eine semantisch zusammengehörige Liste enumerierter Werte.
"
Class {
	#name : #APEnumeration,
	#superclass : #Object,
	#instVars : [
		'id',
		'statefulCondition',
		'isNilAllowed',
		'textFromKeyBlock',
		'actionFromKeyBlock',
		'actionEnablementFromKeyBlock',
		'enumDict',
		'enumKeys',
		'tagsRoot',
		'iconFromKeyBlock'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #'instance creation' }
APEnumeration class >> create [

	^self named: #unnamed
]

{ #category : #'instance creation' }
APEnumeration class >> named: anId [

	^self new initOn: anId
]

{ #category : #'instance creation' }
APEnumeration class >> named: anId withKeyValuePairs: aCollection [
	"Hier wird eine Enumeration mit Keys und Values aufgebaut, die aus den übergebenen Paaren abgeleitet werden. Die Labels sind die Keys als Strings."
	"APEnumeration named: #test withKeyValuePairs: #(#apple 10 #banana 20)"

	| enum |
	enum := self new initOn: anId.
	enum textFromKeyBlock: [:k | k asString].
	1 to: aCollection size
		by: 2
		do: 
			[:i |
			enum addEntry: ((APEnumEntry on: enum key: (aCollection at: i))
						value: (aCollection at: i + 1);
						yourself)].
	^enum
]

{ #category : #'instance creation' }
APEnumeration class >> named: anId withValueEntries: aCollection [
	"Hier wird eine Enumeration mit Values aufgebaut, die aus den übergebenen Keys abgeleitet werden. Die Labels sind die Keys als Strings."
	"APEnumeration named: #test withValueEntries: #(#apple #banana)"

	| enum |
	enum := self new initOn: anId.
	enum textFromKeyBlock: [:k | k asString].
	aCollection do: 
			[:v |
			enum addEntry: ((APEnumEntry on: enum key: v)
						value: v;
						yourself)].
	^enum
]

{ #category : #API }
APEnumeration class >> reasonInactive [

	^#EnumerationGroupInactive
]

{ #category : #accessing }
APEnumeration >> actionEnablementFromKeyBlock [

	<ignoreForCoverage>
	^actionEnablementFromKeyBlock
]

{ #category : #accessing }
APEnumeration >> actionEnablementFromKeyBlock: anObject [

	actionEnablementFromKeyBlock := anObject
]

{ #category : #API }
APEnumeration >> actionForKey: k [

	^(enumDict at: k) action
		ifNil: [actionFromKeyBlock notNil ifTrue: [actionFromKeyBlock value: k]]
]

{ #category : #accessing }
APEnumeration >> actionFromKeyBlock [

	<ignoreForCoverage>
	^actionFromKeyBlock
]

{ #category : #accessing }
APEnumeration >> actionFromKeyBlock: anObject [

	actionFromKeyBlock := anObject
]

{ #category : #API }
APEnumeration >> actions [

	^enumKeys collect: [:k | self actionForKey: k]
]

{ #category : #'initialize-release' }
APEnumeration >> addAllEntriesForKeys: aKeyColl [

	aKeyColl do: [:k | self addEntryForKey: k]
]

{ #category : #'initialize-release' }
APEnumeration >> addEntry: aAPEnumerationEntry [

	| k |
	k := aAPEnumerationEntry key.
	(self hasKey: k)
		ifTrue: [self aPartError: #enumerationKeyRedefinition text: 'Redefinition of enumeration key ' , k printString].
	enumKeys add: k.
	enumDict at: k put: aAPEnumerationEntry.
	^aAPEnumerationEntry
]

{ #category : #'initialize-release' }
APEnumeration >> addEntryForKey: aKey [

	^self addEntry: (APEnumEntry on: self key: aKey)
]

{ #category : #'initialize-release' }
APEnumeration >> addEntryForKey: aKey text: aText [

	APEnumEntry addUnder: self key: aKey text: aText
]

{ #category : #'initialize-release' }
APEnumeration >> addEntryForKey: aKey value: aValue [

	^self addEntry: (APEnumEntry on: self key: aKey value: aValue)
]

{ #category : #'initialize-release' }
APEnumeration >> addEntryForKey: aKey value: aValue text: aText [

	APEnumEntry
		addUnder: self
		key: aKey
		value: aValue
		text: aText
]

{ #category : #API }
APEnumeration >> computeStatesForAnnounceCollectAll: collectAll use: anInterface [

	| result |
	result := OrderedCollection new.
	enumDict keysAndValuesDo: 
			[:enumKey :enumEntry |
			(collectAll or: [enumEntry isChanged])
				ifTrue: 
					[result add: (anInterface
								createAnnouncedStateOn: enumEntry
								key: enumKey)]].
	^result
]

{ #category : #'initialize-release' }
APEnumeration >> ensureRemoveEntryAt: aKey [

	(self hasKey: aKey)
		ifTrue: [ self removeEntryAt: aKey ]
	
]

{ #category : #'initialize-release' }
APEnumeration >> entryAt: aKey [

	^ enumDict at: aKey
]

{ #category : #API }
APEnumeration >> generateKey [

	^(#generatedKey , (self size + 1) printString) asSymbol
]

{ #category : #'initialize-release' }
APEnumeration >> hasKey: aKey [ 

	^ enumDict includesKey: aKey
]

{ #category : #API }
APEnumeration >> iconForKey: k [

	^(enumDict at: k) icon
		ifNil: [iconFromKeyBlock ifNotNil: [iconFromKeyBlock value: k]]
]

{ #category : #accessing }
APEnumeration >> iconFromKeyBlock [
	^ iconFromKeyBlock
]

{ #category : #accessing }
APEnumeration >> iconFromKeyBlock: anObject [

	iconFromKeyBlock := anObject
]

{ #category : #accessing }
APEnumeration >> id [

	^id
]

{ #category : #'initialize-release' }
APEnumeration >> initOn: anId [

	id := anId.
	isNilAllowed := true.
	enumDict := Dictionary new.
	enumKeys := OrderedCollection new.
	statefulCondition := APStatefulCondition on: APCondition true.
]

{ #category : #updating }
APEnumeration >> isActive [

	^statefulCondition isActive
]

{ #category : #API }
APEnumeration >> isActiveAt: k [

	^(enumDict at: k) statefulCondition
		ifNotNil: [:sfc | sfc isActive]
		ifNil: 
			[actionEnablementFromKeyBlock ifNotNil: [:aeb | aeb value: k] ifNil: [true]]
]

{ #category : #API }
APEnumeration >> isIndicatedOnAt: k [

	^(enumDict at: k) indicationStatefulCondition
		ifNotNil: [:indCondition | indCondition isActive]
		ifNil: [false]
]

{ #category : #API }
APEnumeration >> isRecursive [

	enumDict keysAndValuesDo: [:k :v | v isEnumeration ifTrue: [^true]].
	^false
]

{ #category : #accessing }
APEnumeration >> key: aKey indicationStatefulConditionOn: aCondition [

	(enumDict at: aKey) indicationStatefulConditionOn: aCondition
]

{ #category : #API }
APEnumeration >> keyForText: text [

	enumDict keysAndValuesDo: 
			[:k :v |
			v text notNil
				ifTrue: [v text asString = text asString ifTrue: [^k]]
				ifFalse: 
					[textFromKeyBlock notNil
						ifTrue: [(textFromKeyBlock value: k) asString = text asString ifTrue: [^k]]]].
	^nil
]

{ #category : #API }
APEnumeration >> keyForValue: value [

	enumDict keysAndValuesDo: [:k :v | v value = value ifTrue: [^k]].
	^nil
]

{ #category : #API }
APEnumeration >> keys [

	^enumKeys
]

{ #category : #API }
APEnumeration >> keysAndValuesDo: aTwoArgsBlock [

	enumKeys do: [:k | aTwoArgsBlock value: k value: (enumDict at: k)]
]

{ #category : #printing }
APEnumeration >> printOn: s [

	<ignoreForCoverage>
	super printOn: s.
	id notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: id printString;
				nextPut: $)]
]

{ #category : #'initialize-release' }
APEnumeration >> release [

	statefulCondition := textFromKeyBlock := actionFromKeyBlock := enumDict := enumKeys := tagsRoot := iconFromKeyBlock := nil
]

{ #category : #'initialize-release' }
APEnumeration >> removeEntryAt: aKey [

	| oldEntry |
	oldEntry := enumDict at: aKey.
	enumDict removeKey: aKey.
	enumKeys remove: aKey.
	^ oldEntry
	
]

{ #category : #'initialize-release' }
APEnumeration >> setDefaultActionBlocksForInterface: aPartInterface [

	actionFromKeyBlock := [:k | [aPartInterface execute: k ifDisabled: []]].
	actionEnablementFromKeyBlock :=
			[:k |
			aPartInterface isActionExecutable: k ifAbsent: [false]]
]

{ #category : #accessing }
APEnumeration >> size [

	^enumKeys size
]

{ #category : #accessing }
APEnumeration >> statefulCondition [

	^statefulCondition
]

{ #category : #accessing }
APEnumeration >> statefulCondition: anObject [

	statefulCondition := anObject
]

{ #category : #API }
APEnumeration >> tagsTreeRoot [

	tagsRoot
		ifNil: 
			[tagsRoot := APEnumerationTagNode on: nil tag: #root.
			enumKeys do: [:k | tagsRoot addKey: k toTagPath: (enumDict at: k) tags]].
	^tagsRoot
]

{ #category : #API }
APEnumeration >> textForKey: k [

	self flag: #todo. "dependency on PDM, we need to assign a translation domain during creation"

	^((enumDict at: k) text
		ifNil: 
			[textFromKeyBlock notNil
				ifTrue: [textFromKeyBlock value: k]
				ifFalse: [k asString]])
]

{ #category : #accessing }
APEnumeration >> textFromKeyBlock [

	<ignoreForCoverage>
	^textFromKeyBlock
]

{ #category : #accessing }
APEnumeration >> textFromKeyBlock: anObject [

	textFromKeyBlock := anObject
]

{ #category : #API }
APEnumeration >> texts [

	^enumKeys collect: [:k | self textForKey: k]
]

{ #category : #updating }
APEnumeration >> updateCondition [

	statefulCondition ifNotNil: [statefulCondition updateCondition].
	self isActive
		ifTrue: [enumDict keysAndValuesDo: [:k :v | v updateCondition]]
		ifFalse: 
			[enumDict
				keysAndValuesDo: [:k :v | v updateOnFinalReason: APEnumeration reasonInactive]]
]

{ #category : #updating }
APEnumeration >> updateOnFinalReason: reason [

	statefulCondition
		ifNotNil: [statefulCondition updateOnCondition: (APConditionFinal on: reason)].
	enumDict keysAndValuesDo: [:k :v | v updateOnFinalReason: reason]
]

{ #category : #API }
APEnumeration >> valueForKey: k [

	^(enumDict at: k) value
]

{ #category : #API }
APEnumeration >> values [

	^enumKeys collect: [:k | self valueForKey: k]
]
