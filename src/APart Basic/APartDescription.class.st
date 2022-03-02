Class {
	#name : #APartDescription,
	#superclass : #Object,
	#instVars : [
		'part',
		'actions',
		'aspects',
		'eventHandlers'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'instance creation' }
APartDescription class >> for: aPart [

	^self basicNew initOn: aPart
]

{ #category : #'API actions' }
APartDescription >> actionAt: anActionKey ifAbsent: absentBlock [
	"An action from anActionKey that is a path, could be created if not found in the actionsFromPaths dictionary"

	^actions
		at: anActionKey
		ifAbsent: absentBlock
]

{ #category : #'API actions' }
APartDescription >> actionAt: anActionKey ifPresent: presentBlock [

	self flag: #todo. "handle actions from path"
	
"	(anActionKey includes: Character space) ifTrue: [  self halt ].
"		
	^ actions at: anActionKey ifPresent: presentBlock
]

{ #category : #'API actions' }
APartDescription >> actionNamesForEventType: anEventType ifAbsent: aBlock [

	^ self actionNamesForEventType: anEventType subtype: nil ifAbsent: aBlock
]

{ #category : #'API actions' }
APartDescription >> actionNamesForEventType: anEventType subtype: anEventSubtype ifAbsent: aBlock [

	^ eventHandlers 
		ifNil: aBlock
		ifNotNil: [ :handlers | 
			handlers at: anEventType 
				ifPresent: [ :subtypes |
					subtypes at: anEventSubtype 
						ifPresent: [ :names | names ]
						ifAbsent: aBlock ]
				ifAbsent: aBlock]
]

{ #category : #'API actions' }
APartDescription >> actionsRaw [

	<ignoreForCoverage>
	^ actions select: #isRawAction
]

{ #category : #'API actions' }
APartDescription >> actionsRedirected [

	^ actions select: #isRedirected
]

{ #category : #private }
APartDescription >> addAction: anAction [ 

	self checkForActionRedefinition: anAction key.
	^ self addActionWithoutRedefinitionCheck: anAction
]

{ #category : #private }
APartDescription >> addActionWithoutRedefinitionCheck: anAction [ 

	^ actions at: anAction key put: anAction
]

{ #category : #private }
APartDescription >> addAspectWithoutRedefinitionCheck: anAspect as: aKey [

	^aspects at: aKey put: anAspect
]

{ #category : #'API actions' }
APartDescription >> allActionKeys [

	^actions keys asSortedCollection
]

{ #category : #'API aspects' }
APartDescription >> allAspectKeysDo: aBlock [

	<ignoreForCoverage>

	aspects keysDo: aBlock.
]

{ #category : #'API aspects' }
APartDescription >> allAspectKeysInclude: aKey [

	^ aspects includesKey: aKey
]

{ #category : #'API aspects' }
APartDescription >> aspectFor: aKey ifAbsent: absentBlock [ 

	^ self aspectFor: aKey ifAbsent: absentBlock ignoreAutoAspects: false
]

{ #category : #'API aspects' }
APartDescription >> aspectFor: aKey ifAbsent: absentBlock ignoreAutoAspects: aBoolean [
	| result |
	result := aspects
		at: aKey
		ifPresent: [ :anAspect | anAspect targetAspectIfAbsent: absentBlock ]
		ifAbsent: [ (aBoolean not and: self autoAspectDefinition) 
				ifTrue: [ self privDefineAutoAspect: aKey ]
				ifFalse: absentBlock ].
	^ result ifNil: absentBlock
]

{ #category : #'API aspects' }
APartDescription >> aspectKeysAndValuesDo: aBlock [ 

	^ aspects keysAndValuesDo: aBlock
]

{ #category : #'API aspects' }
APartDescription >> aspects [

	<ignoreForCoverage>

	^ aspects
]

{ #category : #'API aspects' }
APartDescription >> aspectsAt: aKey ifAbsent: aBlock [

	^ aspects at: aKey ifAbsent: aBlock
]

{ #category : #'API aspects' }
APartDescription >> aspectsAt: aKey ifAbsentPut: putBlock [

	^ aspects at: aKey ifAbsentPut: putBlock
]

{ #category : #'API aspects' }
APartDescription >> aspectsRedirected [

	<ignoreForCoverage>

	^ aspects select: #isRedirected
]

{ #category : #'API aspects' }
APartDescription >> autoAspectDefinition [

	^part autoAspectDefinition
]

{ #category : #'API aspects' }
APartDescription >> autoDefineAspect: aKey [

	^(self part respondsTo: aKey)
		ifTrue: 
			[self createAspectNamed: aKey.
			aspects at: aKey]
		ifFalse: [nil]
]

{ #category : #'API actions' }
APartDescription >> checkForActionExistence: aKey [

	(actions includesKey: aKey)
		ifFalse: [ APMissingActionError signalKey: aKey ]
]

{ #category : #'API actions' }
APartDescription >> checkForActionRedefinition: aKey [

	(actions includesKey: aKey)
		ifTrue: [ APActionRedefinitionError signalKey: aKey ]
]

{ #category : #'API aspects' }
APartDescription >> checkForAspectExistence: aKey [

	(aspects includesKey: aKey)
		ifFalse: [ APMissingAspectKeyError signalKey: aKey]
]

{ #category : #'API aspects' }
APartDescription >> checkForAspectRedefinition: aKey [

	(aspects includesKey: aKey)
		ifTrue: [ APAspectRedefinitionError signalKey: aKey]
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey do: anActionBlock [

	^self createAction: aKey do: anActionBlock if: APCondition true helpText: nil
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey do: anActionBlock if: aCondition [

	^self createAction: aKey do: anActionBlock if: aCondition helpText: nil
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey do: anActionBlock if: aCondition addEnumEntryTo: anEnumeration [

	anEnumeration addEntryForKey: aKey.
	^self createAction: aKey do: anActionBlock if: aCondition
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey do: anActionBlock if: aCondition helpText: aHelpText [

	^ self addAction: (APPublicAction
		key: aKey
		do: anActionBlock
		if: aCondition
		helpText: aHelpText)
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey forUseCase: aUseCase [

	^ self addAction: (APUseCaseAction
		key: aKey
		useCase: aUseCase)
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey redirectTo: aPartPath [

	^ self addAction: (APRedirectedAction on: part key: aKey path: aPartPath)
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey withArgumentDo: anActionBlock [

	^self
		createAction: aKey
		withArgumentDo: anActionBlock
		if: APCondition true
		helpText: nil
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey withArgumentDo: anActionBlock if: aCondition [

	^self
		createAction: aKey
		withArgumentDo: anActionBlock
		if: aCondition
		helpText: nil
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey withArgumentDo: anActionBlock if: aCondition addEnumEntryTo: anEnumeration [

	anEnumeration addEntryForKey: aKey.
	^self
		createAction: aKey
		withArgumentDo: anActionBlock
		if: aCondition
		helpText: nil
]

{ #category : #'API actions' }
APartDescription >> createAction: aKey withArgumentDo: anActionBlock if: aCondition helpText: aHelpText [

	| anAction | 
	
	anAction := APPublicAction
				key: aKey
				do: anActionBlock
				if: aCondition
				helpText: aHelpText.
	anAction expectArgument.
	anAction checkConsistencyForPart: part
		ifNotDo: [:msg | self aPartError: #inconsistentAction text: msg].

	^ self addAction: anAction
]

{ #category : #'API aspects' }
APartDescription >> createAllAspectsNamed: someAspectNames [

	^ someAspectNames collect: [:e | self createAspectNamed: e]
]

{ #category : #'API aspects' }
APartDescription >> createAspectNamed: aKey [

	self checkForAspectRedefinition: aKey.
	self createRedirectionAspectForSubpartAt: aKey.
	self interface aspectCreated: aKey. 
	^self aspectsAt: aKey
		ifAbsentPut: [self interface aspectBuilder createModelForAspect: aKey subject: part]
]

{ #category : #'API aspects' }
APartDescription >> createAspectNamed: aKey redirectTo: aPartPath [

	self checkForAspectRedefinition: aKey.
	^self addAspectWithoutRedefinitionCheck: (self interface aspectBuilder
				createModelForAspect: aKey
				subject: part
				redirectTo: aPartPath) as: aKey
]

{ #category : #'API aspects' }
APartDescription >> createAspectNamed: aKey use: anAdaptor [

	self checkForAspectRedefinition: aKey.
	^aspects at: aKey put: (APAspect named: aKey for: anAdaptor)
]

{ #category : #'API aspects' }
APartDescription >> createRedirectionAspectForSubpartAt: aKey [
	"if a subpart at given aspect defines a redirection key, create the aspect as redirection"

	^ (part subPartAt: aKey ifNone: [  ])
		ifNotNil: [ :aspectTarget | 
			aspectTarget partInterface aspectBuildRedirectionKey
				ifNotNil:
					[ :k | self createAspectNamed: aKey redirectTo: (Array with: aKey with: k) ] ]
]

{ #category : #'API aspects' }
APartDescription >> definesAspect: aKey [

	^(aspects includesKey: aKey)
		or: [self autoAspectDefinition and: [self part respondsTo: aKey]]
]

{ #category : #'API aspects' }
APartDescription >> ensureAspectNamed: aspectKey [

	aspects at: aspectKey ifPresent: [:model | ^model].
	^self createAspectNamed: aspectKey
]

{ #category : #'API aspects' }
APartDescription >> ensureUndefineMember: aSymbol [ 

	(self hasActionNamed: aSymbol) ifTrue: [ 
		self undefineAction: aSymbol.
		(self part hasConditionNamed: aSymbol)
			ifTrue: [ self part removeNamedCondition: aSymbol ] ].
	
	(self hasAspectNamed: aSymbol) ifTrue: [ 
		self undefineAspectNamed: aSymbol. 
		(self part hasConditionNamed: aSymbol)
			ifTrue: [ self part removeNamedCondition: aSymbol ] ].


]

{ #category : #'API actions' }
APartDescription >> hasActionNamed: aName [

	^ (self actionAt: aName ifAbsent: [ nil ]) notNil
]

{ #category : #'API aspects' }
APartDescription >> hasAspectNamed: aName [

	^ (self aspectFor: aName ifAbsent: [ nil ]) notNil
]

{ #category : #initialization }
APartDescription >> initOn: aPart [

	part := aPart.
	self initialize
]

{ #category : #initialization }
APartDescription >> initialize [

	super initialize.
	actions := Dictionary new.
	aspects := Dictionary new.
]

{ #category : #accessing }
APartDescription >> interface [ 

	^ part partInterface
]

{ #category : #'API aspects' }
APartDescription >> knows: anAspect [

	(self hasAspectNamed: anAspect) ifTrue: [ ^ true ].	
	(actions includesKey: anAspect) ifTrue: [ ^ true ].
	
	^ false
	
]

{ #category : #'API aspects' }
APartDescription >> localAspectKeys [

	<ignoreForCoverage>

	^SortedCollection withAll: aspects keys
]

{ #category : #'API aspects' }
APartDescription >> localAspectKeysDo: aBlock [

	<ignoreForCoverage>

	aspects keysDo: aBlock
]

{ #category : #accessing }
APartDescription >> memberNamed: aMemberName [

	^ self memberNamed: aMemberName ifAbsent: [ self aPartError: #missingAMember attribute: aMemberName ]
]

{ #category : #accessing }
APartDescription >> memberNamed: aMemberName ifAbsent: aBlock [

	^ self aspectFor: aMemberName ifAbsent: [
		self actionAt: aMemberName ifAbsent: aBlock]
]

{ #category : #'API aspects' }
APartDescription >> nonredirectedAspects [

	<ignoreForCoverage>
	^ aspects reject: #isRedirected
]

{ #category : #'API actions' }
APartDescription >> onEvent: eventType doActionNamed: actionName [
	
	^ self onEvent: eventType subtype: nil doActionNamed: actionName

]

{ #category : #'API actions' }
APartDescription >> onEvent: eventType subtype: eventSubtype doActionNamed: actionName [

	| types subTypes |
	self checkForActionExistence: actionName.

	eventHandlers ifNil: [ eventHandlers := Dictionary new ].
	types := eventHandlers at: eventType ifAbsentPut: Dictionary new.
	subTypes := types at: eventSubtype ifAbsentPut: OrderedCollection new.
	^ subTypes add: actionName.
]

{ #category : #accessing }
APartDescription >> part [

	^part
]

{ #category : #private }
APartDescription >> privActions [ 

	<ignoreForCoverage>

	^ actions
]

{ #category : #'API aspects' }
APartDescription >> privCreateAutoAspectNamed: aKey [

	self checkForAspectRedefinition: aKey.
	self createRedirectionAspectForSubpartAt: aKey.
	self interface aspectCreated: aKey. 
	^self aspectsAt: aKey
		ifAbsentPut: [self interface aspectBuilder createModelForAutoAspect: aKey subject: part]
]

{ #category : #'API aspects' }
APartDescription >> privDefineAutoAspect: aKey [

	^(self part respondsTo: aKey)
		ifTrue: 
			[self privCreateAutoAspectNamed: aKey.
			aspects at: aKey]
		ifFalse: [nil]
]

{ #category : #'API actions' }
APartDescription >> putTrigger: aTriggerActionWithKey [

	aTriggerActionWithKey checkConsistencyForPart: part
		ifNotDo: [:msg | self aPartError: #inconsistentTrigger text: msg].
	^actions at: aTriggerActionWithKey key put: aTriggerActionWithKey
]

{ #category : #enumerating }
APartDescription >> release [

	super release.
	actions := Dictionary new.
	aspects := Dictionary new.
]

{ #category : #'API actions' }
APartDescription >> setExpectArgumentForActionKey: anActionKey [

	self actionAt: anActionKey ifPresent: [:a | a expectArgument ].

]

{ #category : #'API actions' }
APartDescription >> triggerActions [

	^ actions select: #isTrigger
]

{ #category : #'API actions' }
APartDescription >> undefineAction: aKey [

	actions removeKey: aKey ifAbsent: [  ].
]

{ #category : #'API aspects' }
APartDescription >> undefineAspectNamed: aKey [

	aspects removeKey: aKey ifAbsent: [  ].

]
