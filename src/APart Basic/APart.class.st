"
APart is the abstract base class for all application-specific subclasses.

"
Class {
	#name : #APart,
	#superclass : #Object,
	#instVars : [
		'clientRegistry',
		'key',
		'parentPart',
		'statefulCondition',
		'subParts',
		'description',
		'partInterface',
		'namedConditions',
		'isClosing',
		'clientConfiguration',
		'isScopeRoot',
		'isOpenAsPrompt',
		'isInitializing',
		'dependenciesRegistry',
		'exposedMemberGroups'
	],
	#classVars : [
		'SettersDict'
	],
	#category : #'APart Basic-Core'
}

{ #category : #localization }
APart class >> aPartTranslateDynamic: aString [

	"the parts themselves do not manage translations, it should be responsibility of the clients.
	However, we need to use special message to be able to register the translation."
	^ aString 
]

{ #category : #'instance creation' }
APart class >> createWithClientRegistry [

	| inst |
	inst := self new.
	inst useClientRegistry: (APartClientRegistry on: inst).
	inst initialize.
	^inst
]

{ #category : #'instance creation' }
APart class >> createWithClientRegistryPreInit: preInitBlock [

	^self onPart: nil key: self name preInit: [ :inst |
			inst useClientRegistry: (APartClientRegistry on: inst).
			preInitBlock value: inst
		]	
		postInit: nil

]

{ #category : #private }
APart class >> descriptionClass [

	^APartDescription
]

{ #category : #private }
APart class >> interfaceClass [

	^APartInterface
]

{ #category : #'API testing' }
APart class >> isPromptable [

	^false
]

{ #category : #'instance creation' }
APart class >> onPart: aPart [

	^self onPart: aPart key: self name
]

{ #category : #'instance creation' }
APart class >> onPart: aPart key: aKey [

	^self
		onPart: aPart
		key: aKey
		preInit: nil
		postInit: nil
]

{ #category : #'instance creation' }
APart class >> onPart: aPart key: aKey condition: aCondition [

	| inst |
	inst := self onPart: aPart key: aKey.
	aPart at: aKey putCondition: aCondition.
	^inst
]

{ #category : #'instance creation' }
APart class >> onPart: aPart key: aKey postInit: anInitBlock [

	^self
		onPart: aPart
		key: aKey
		preInit: nil
		postInit: anInitBlock
]

{ #category : #'instance creation' }
APart class >> onPart: aPart key: aKey preInit: anInitBlock [

	^self onPart: aPart key: aKey preInit: anInitBlock postInit: nil
]

{ #category : #'instance creation' }
APart class >> onPart: aPart key: aKey preInit: aPreInitBlock postInit: aPostInitBlock [

	| inst |
	inst := self new.
	aPreInitBlock ifNotNil: [aPreInitBlock value: inst].
	aPart notNil
		ifTrue: [inst initOn: aPart key: aKey]
		ifFalse: 
			[inst clientRegistry
				ifNil: [inst useClientRegistry: (APartClientRegistry on: inst)].
			inst initialize].
	inst applyPostInitBlock: aPostInitBlock.
	^inst
]

{ #category : #'instance creation' }
APart class >> onPart: aParentPart key: aKey whenClosingDo: aOneArgBlock [

	^(self onPart: aParentPart key: aKey)
		whenClosingDo: aOneArgBlock;
		yourself
]

{ #category : #API }
APart class >> partRibbonId [

	^nil
]

{ #category : #'instance creation' }
APart class >> postInit: aPostInitBlock [

	^self
		onPart: nil
		key: nil
		preInit: nil
		postInit: aPostInitBlock
]

{ #category : #'instance creation' }
APart class >> preInit: aPreInitBlock [

	^self preInit: aPreInitBlock postInit: nil
]

{ #category : #'instance creation' }
APart class >> preInit: aPreInitBlock postInit: aPostInitBlock [

	^self
		onPart: nil
		key: nil
		preInit: aPreInitBlock
		postInit: aPostInitBlock
]

{ #category : #API }
APart class >> promptClosingTriggerKey [

	^#complexPromptClosed
]

{ #category : #API }
APart class >> reasonInactive [

	^#PartIsInactive
]

{ #category : #API }
APart class >> setterFor: aSymbol [

	aSymbol last = $: ifTrue: [^aSymbol].
	SettersDict isNil ifTrue: [SettersDict := Dictionary new].
	^SettersDict at: aSymbol ifAbsentPut: [(aSymbol , ':') asSymbol]
]

{ #category : #'apart pragmas' }
APart class >> usedActionPragmas [
	<pragmas: #instance>

	^#(#aPartDefineAction #aPartAction #aPartActionIf: #aPartActionIf:help: #aPartActionCondition )
]

{ #category : #'apart pragmas' }
APart class >> usedAspectPragmas [
	<pragmas: #instance>

	^#(#aPartAspect #aPartAspectEnabled: #aPartDefineAspect #aPartDefineMenu #aPartAspectCondition)
]

{ #category : #'apart pragmas' }
APart class >> usedIconPragmas [
	<pragmas: #class>

	^#(#file:)
]

{ #category : #API }
APart >> aPartPerform: aKey with: aValue [
	
	self partInterface logPerform: aKey.

	self partInterface holdClientUpdatesWhile: 
			[self perform: (self class setterFor: aKey) with: aValue]
]

{ #category : #translation }
APart >> aPartTranslateDynamic: aString [

	"the parts themselves do not manage translations, it should be responsibility of the clients.
	However, we need to use special message to be able to register the translation."
	^ aString 
]

{ #category : #'API member groups' }
APart >> acceptMemberGroup: aMemberGroup [
	
	
]

{ #category : #'API member groups' }
APart >> acceptedMemberGroupTypes [

	"Define member group types that this part is able to accept. It servers only for resolution 
	depending on the type name and in the end, the part can reject the concrete member group via
	canAcceptMemberGroup: message "

	^ Array new
]

{ #category : #API }
APart >> activeFocus [ 

	^ true
]

{ #category : #'initialize-release' }
APart >> addNamedCondition: aNamedCond [

	^self at: aNamedCond name putCondition: aNamedCond
]

{ #category : #'initialize-release' }
APart >> addNamedConditions: aNamedConditionColl [

	aNamedConditionColl
		do: [:eachNamedCond | self addNamedCondition: eachNamedCond]
]

{ #category : #'API paths' }
APart >> addPathFromRootSegmentTo: path [

	self parentPart ifNil: [ ^ path ].
	path addFirst: self key.	
	^ self parentPart addPathFromRootSegmentTo: path.	

]

{ #category : #'initialize-release' }
APart >> addSubPart: aSubPart key: aKey [

	subParts at: aKey
		ifPresent: 
			[:alreadyExisting |
			APSubpartAlreadyExistsError signalKey: aKey alreadyExisting: alreadyExisting ].
	subParts at: aKey put: aSubPart
]

{ #category : #localization }
APart >> announce: anAnnouncement [

	self partInterface announcer announce: anAnnouncement
]

{ #category : #localization }
APart >> announceLocaleChangeTo: newLocale [

	self partInterface announcer announce: ((APInterfaceLocaleChangedAnnouncement interface: self)
		locale: newLocale).
]

{ #category : #private }
APart >> announcer [

	^partInterface
]

{ #category : #'initialize-release' }
APart >> applyPostInitBlock: aPostInitBlock [

	aPostInitBlock notNil
		ifTrue: 
			[isInitializing := true.
			aPostInitBlock value: self.
			isInitializing := false].
	parentPart isNil ifTrue: [partInterface scopeUpdateAndAnnounce]
]

{ #category : #'API member groups' }
APart >> askForMemberGroups [

	| existingGroups |
	
	existingGroups := self rootPart memberGroupsRegistry askForMemberGroups: self acceptedMemberGroupTypes from: self.
	
	existingGroups do: [ :each | self acceptMemberGroup: each ].
]

{ #category : #API }
APart >> aspectBuilderClass [

	^APInterfaceAspectBuilder
]

{ #category : #'initialize-release' }
APart >> at: aName putCondition: aCondition [

	(namedConditions includesKey: aName)
		ifTrue: 
			[ APConditionRedefinitionError signalForConditionNamed: aName printString].
	aCondition setNameIfUndefined: aName.
	namedConditions at: aName put: aCondition.
	partInterface description ensureAspectNamed: aName
]

{ #category : #'initialize-release' }
APart >> at: aspectName validate: oneArgBlock [

	(partInterface description ensureAspectNamed: aspectName) subAdaptor
		validationBlock: oneArgBlock
]

{ #category : #'initialize-release' }
APart >> atAll: aNameColl putCondition: aCondition [

	| composedName |
	
	composedName := (aNameColl collect: #asString) joinUsing: ' '.
	aCondition name: composedName.

	aNameColl do: [:eachName | self at: eachName putCondition: aCondition]
]

{ #category : #'API testing' }
APart >> autoAspectDefinition [

	^false
]

{ #category : #API }
APart >> backendToUse [
	^#Morphic
	
]

{ #category : #'initialize-release' }
APart >> basicInitialize [

	partInterface := self interfaceClass for: self.
	description := self descriptionClass for: self.
	subParts := Dictionary new.
	namedConditions := Dictionary new.
	isClosing := false.
	isScopeRoot := false.
	isOpenAsPrompt := false.
	exposedMemberGroups := SmallIdentityDictionary new.

]

{ #category : #focus }
APart >> canAcceptFocus [

	^ false
]

{ #category : #'API member groups' }
APart >> canAcceptMemberGroup: anAPMemberRefGroup [

	"re-define me in subclasses"

	^ false
]

{ #category : #updating }
APart >> changedAllAspectValues [

	self changedAspectValues: #()
]

{ #category : #updating }
APart >> changedAspectValue: aspectKey [

	partInterface changedAspectValue: aspectKey
]

{ #category : #updating }
APart >> changedAspectValue: aspectKey suppressListeners: shallSuppressListeners [

	partInterface changedAspectValue: aspectKey
		suppressListeners: shallSuppressListeners
]

{ #category : #updating }
APart >> changedAspectValues: aspectKeyColl [

	partInterface changedAspectValues: aspectKeyColl
]

{ #category : #updating }
APart >> changedAspectValues: aspectKeyColl suppressListeners: shallSuppressListeners [
	"If the passed collection is empty, not all aspects are considered changed on this call"
	"DE:Falls die übergebene Collection leer ist, werden bei diesem Aufruf nicht alle Aspekte als geändert betrachtet"

	aspectKeyColl do: 
			[:aspectKey |
				self  changedAspectValue: aspectKey suppressListeners: shallSuppressListeners]
		
]

{ #category : #API }
APart >> changedPartOrParentRecursively [

	self isChanged ifTrue: [^self].
	^parentPart ifNotNil: [parentPart changedPartOrParentRecursively]
]

{ #category : #'GUI registry callbacks' }
APart >> chooseClientClassForOpeningType: clientType among: possibleClasses [

	^possibleClasses last
]

{ #category : #accessing }
APart >> clientConfiguration [

	^clientConfiguration
]

{ #category : #accessing }
APart >> clientConfiguration: anObject [

	"This message is prepared for use as an Aspect, but is not defined as an Aspect. Subclasses that use a clientConfiguration must define this aspect."
	"DE:Dieser Aufruf ist für die Verwendung als Aspect vorbereitet, wird jedoch nicht als Aspect definiert. Subklassen, die eine clientConfiguration verwenden, müssen diesen Aspect definieren."

	clientConfiguration := anObject.
	self changedAspectValue: #clientConfiguration
]

{ #category : #'initialize-release' }
APart >> clientRegistered: aClient [ 

	"do some additional initialization that requires the clients to exists"
]

{ #category : #accessing }
APart >> clientRegistry [

	^clientRegistry
]

{ #category : #'API member groups' }
APart >> collectAcceptedMemberGroupsTo: aDictionary [ 

	self acceptedMemberGroupTypes do: [ :type |
		(aDictionary at: type ifAbsentPut: Set new) 
			add: self ].
		
	self subPartsDo: [ :subPart | 
		subPart collectAcceptedMemberGroupsTo: aDictionary ].
]

{ #category : #private }
APart >> conditionChainFromSelectorOrArray: aSelectorOrArray [


	^ aSelectorOrArray class = Array
		ifTrue: [ self conditionChainFromSelectors: aSelectorOrArray ]
		ifFalse: [ self conditionFromSelector: aSelectorOrArray]
]

{ #category : #private }
APart >> conditionChainFromSelectors: aSelectorArray [

	| result |
	aSelectorArray size = 1
		ifTrue: [^self conditionFromSelector: aSelectorArray first].
	result := APConditionChain create.
	aSelectorArray do: [:sel | result add: (self conditionFromSelector: sel)].
	^result
]

{ #category : #private }
APart >> conditionFromSelector: sel [

	| cond |
	cond := self perform: sel.
	(cond isKindOf: APConditionBase)
		ifFalse: [ APConditionExpectedError signalFor: cond class name ].
	^cond
]

{ #category : #API }
APart >> createMenuForKey: aMenuKey exposingRedirectionToItemsListAs: aListRedirectionKey [

	| rp path |
	partInterface createMenuForKey: aMenuKey.
	rp := self rootPart.
	path := self pathFromRootPart: rp.
	rp partInterface description createAspectNamed: aListRedirectionKey
		redirectTo: path , (Array with: aMenuKey with: #enumerationTextList)
]

{ #category : #focus }
APart >> defaultKeyboardFocus [ 

	"return a subpart that has a default focus or nil"
	^ nil
]

{ #category : #'initialize-release' }
APart >> defaultPromptSelector [

	^#openModal:
]

{ #category : #'initialize-release' }
APart >> defineAspects [
	"Required by subclasses, or as an alternative, aspects can be defined in pragma methods, see #defineAspectsByPragma."
	"Wird von Subklassen benötigt. Alternativ dazu können Aspekte auch in Pragma-Methoden definiert werden, siehe #defineAspectsByPragma."
]

{ #category : #'initialize-release' }
APart >> defineAspectsByPragma [
	"Wurzel der Suche nach Aspekt-/Action-definierende Pragmas (initializeActionsByPragma/defineAspectsByPragma) ist pragmaRoot, d.h. i.A. die Klasse selbst und keinerlei Definitionen aus Oberklassen"

	(self pragmasNamed: #aPartNamedConditions)
		do: [:pragma | self addNamedConditions: (self perform: pragma methodSelector)].
	(self pragmasNamed: #aPartAspectDefinition)
		do: [:pragma | self perform: pragma methodSelector].
	(self pragmasNamed: #aPartDefineMenu)
		do: [:pragma | partInterface createMenuForKey: pragma methodSelector].
	(self pragmasNamed: #aPartAspect)
		do: [:pragma | partInterface description createAspectNamed: pragma methodSelector].
	(self pragmasNamed: #aPartAspectEnabled:) do: 
			[:pragma |
			| conditionSelector |
			conditionSelector := pragma arguments first.
			#true == conditionSelector
				ifTrue: [partInterface description createAspectNamed: pragma methodSelector]
				ifFalse: 
					[self at: pragma methodSelector putCondition: (self perform: conditionSelector)]]
]

{ #category : #API }
APart >> dependenciesRegistry [

	^parentPart 
		ifNotNil: [:theParent | theParent dependenciesRegistry] 
		ifNil: [
			dependenciesRegistry
				ifNil: [dependenciesRegistry := APDependenciesRegistry new]]
]

{ #category : #private }
APart >> description [ 

	^ description 
]

{ #category : #private }
APart >> descriptionClass [

	^self class descriptionClass
]

{ #category : #API }
APart >> disableAllAspects: aspectKeyColl [

	aspectKeyColl
		do: [:aspectKey | self at: aspectKey putCondition: APCondition false]
]

{ #category : #'initialize-release' }
APart >> disconnectFromParent [

	partInterface isNil
		ifTrue: [partInterface := APartDisconnectedInterface for: self].
	parentPart isNil ifTrue: [^nil].
	parentPart removeSubPartForKey: key.
	parentPart := nil
]

{ #category : #API }
APart >> execute: actionKey ifDisabled: disabledBlock [

	^partInterface execute: actionKey ifDisabled: disabledBlock
]

{ #category : #API }
APart >> execute: actionKey with: anArgument [

	^self
		execute: actionKey
		with: anArgument
		ifDisabled: []
]

{ #category : #API }
APart >> execute: actionKey with: anArgument ifDisabled: disabledBlock [

	^partInterface
		execute: actionKey
		with: anArgument
		ifDisabled: disabledBlock
]

{ #category : #'API trigger' }
APart >> executeTrigger: triggerKey [

	^partInterface executeTrigger: triggerKey with: nil
]

{ #category : #'API trigger' }
APart >> executeTrigger: triggerKey ifAbsent: absentBlock [

	^partInterface executeTrigger: triggerKey ifAbsent: absentBlock
]

{ #category : #'API trigger' }
APart >> executeTrigger: triggerKey with: arg [

	^partInterface executeTrigger: triggerKey with: arg
]

{ #category : #private }
APart >> exposeGroupType: groupTypeKey forActions: actionKeys [
	| group |
	
	group := APMemberGroup onPart: self.
	group type: groupTypeKey.
	actionKeys
		do: [ :eachActionKey | group addAction: (self description memberNamed: eachActionKey) ].
	
	self exposeMemberGroup: group
]

{ #category : #private }
APart >> exposeGroupType: groupTypeKey subId: groupSubId forActions: actionKeys [
	| group |
	
	group := APMemberGroup onPart: self.
	group type: groupTypeKey.
	group subId: groupSubId.
	actionKeys
		do: [ :eachActionKey | group addAction: (self description memberNamed: eachActionKey) ].
	
	self exposeMemberGroup: group
]

{ #category : #'API member groups' }
APart >> exposeMemberGroup: aGroup [
	
	self rootPart memberGroupsRegistry exposeMemberGroup: aGroup from: self.
	exposedMemberGroups at: aGroup id put: aGroup.

]

{ #category : #'API member groups' }
APart >> exposedMemberGroupFor: aSymbol [
	
	self isReleased ifTrue: [ ^ nil ].
	
	^ exposedMemberGroups at: aSymbol ifAbsent: [ nil ]
]

{ #category : #'API member groups' }
APart >> exposedMemberGroupsFor: aSymbol [
	
	self isReleased ifTrue: [ ^ OrderedCollection new ].
	
	^ { exposedMemberGroups at: aSymbol ifAbsent: [ ^ OrderedCollection new ]}
]

{ #category : #API }
APart >> extraAnnouncements [

	^#()
]

{ #category : #'GUI registry callbacks' }
APart >> findClientClassForOpening [
	"Can be redefined in subclasses to implement special solutions.
	Can occur for usually called parts or for prompt parts as callback if the client registry does not find a client."

	APCouldNotFindClientForOpeningError signal: self
]

{ #category : #'API open/close' }
APart >> finishClosing [

	isClosing ifFalse: [^false].
	self release.
	^true
]

{ #category : #'API member groups' }
APart >> forgetMemberGroupNamed: aSymbol [
	
	exposedMemberGroups removeKey: aSymbol ifAbsent: [ ]

]

{ #category : #events }
APart >> handleEvent: anEvent [
]

{ #category : #'API notifications' }
APart >> hasConditionNamed: aName [ 

	^ namedConditions includesKey: aName
]

{ #category : #focus }
APart >> hasFocus [ 
	
	^ false
]

{ #category : #API }
APart >> inactivePartOrParentRecursively [

	self isActive ifFalse: [^self].
	^parentPart ifNotNil: [parentPart inactivePartOrParentRecursively]
]

{ #category : #translation }
APart >> inheritsLocale [

	^ true
]

{ #category : #'initialize-release' }
APart >> initKey: aKey [

	(aKey includes: Character space)
		ifTrue: [self error: 'Part key must not include space character'].
	key := aKey
]

{ #category : #'initialize-release' }
APart >> initOn: aPart key: aKey [

	parentPart := aPart.
	self initKey: aKey.
	parentPart addSubPart: self key: aKey.
	self useClientRegistry: parentPart clientRegistry.
	self initialize
]

{ #category : #'initialize-release' }
APart >> initialize [

	isInitializing := true.
	self basicInitialize.
	self initializeValues.
	self initializeActions.
	self initializeActionsByPragma.
	self initializeAspects.
	isInitializing := false
]

{ #category : #'initialize-release' }
APart >> initializeActions [
]

{ #category : #'initialize-release' }
APart >> initializeActionsByPragma [
	"Wurzel der Suche nach Aspekt-/Action-definierende Pragmas (initializeActionsByPragma/defineAspectsByPragma) ist pragmaRoot, d.h. i.A. die Klasse selbst und keinerlei Definitionen aus Oberklassen"

	(self pragmasNamed: #aPartDefineAction)
		do: [:pragma | self perform: pragma methodSelector].
	(self pragmasNamed: #aPartAction) do: 
			[:pragma |
			pragma methodSelector numArgs > 0
				ifTrue: 
					[partInterface createAction: pragma methodSelector
						withArgumentDo: [:arg | self perform: pragma methodSelector with: arg]]
				ifFalse: 
					[partInterface description
						createAction: pragma methodSelector
						do: [self perform: pragma methodSelector]
						if: APCondition true]].
	(self pragmasNamed: #aPartActionIf:) do: 
			[:pragma |
			pragma methodSelector numArgs > 0
				ifTrue: 
					[partInterface description
						createAction: pragma methodSelector
						withArgumentDo: [:arg | self perform: pragma methodSelector with: arg]
						if: (self conditionChainFromSelectorOrArray: pragma arguments first)]
				ifFalse: 
					[partInterface description
						createAction: pragma methodSelector
						do: [self perform: pragma methodSelector]
						if: (self conditionChainFromSelectorOrArray: pragma arguments first)]].
	(self pragmasNamed: #aPartActionIf:help:) do: 
			[:pragma |
			partInterface description
				createAction: pragma methodSelector
				do: [self perform: pragma methodSelector]
				if: (self conditionChainFromSelectorOrArray: pragma arguments first)
				helpText: pragma arguments last]
]

{ #category : #'initialize-release' }
APart >> initializeAspects [

	self defineAspectsByPragma.
	self defineAspects.
	partInterface initializeAspects
]

{ #category : #'initialize-release' }
APart >> initializeValues [
]

{ #category : #private }
APart >> interfaceClass [

	^self class interfaceClass
]

{ #category : #API }
APart >> isActionExecutable: actionKey [ 

	^ partInterface isActionExecutable: actionKey ifAbsent: [ false ]
]

{ #category : #'API testing' }
APart >> isActive [

	^statefulCondition isNil or: [statefulCondition isActive]
]

{ #category : #'API testing' }
APart >> isChanged [

	^statefulCondition notNil and: [statefulCondition isChanged].
]

{ #category : #private }
APart >> isChildPartOf: anotherPart [

	^parentPart == anotherPart
]

{ #category : #'API testing' }
APart >> isClosing [

	^partInterface isClosing
]

{ #category : #focus }
APart >> isInFocusChain [ 
	
	^ self hasFocus 
		or: [ self someParentHasFocus
		or: [ self someSubPartHasFocus ]]
]

{ #category : #'API testing' }
APart >> isInitialized [

	^partInterface notNil and: [subParts notNil]
]

{ #category : #API }
APart >> isInitializing [

	^isInitializing ifNil: [true]
]

{ #category : #'API testing' }
APart >> isOpenAsPrompt [

	^isOpenAsPrompt
]

{ #category : #'API testing' }
APart >> isPart [ 

	^ true
]

{ #category : #'API testing' }
APart >> isPromptable [

	^self class isPromptable
]

{ #category : #'API testing' }
APart >> isReleased [

	^partInterface isNil or: [partInterface isDisconnected]
]

{ #category : #'API testing' }
APart >> isRibbonPage [

	^ false
]

{ #category : #API }
APart >> isScopeInitializing [
	"Question: Is the currently covered part scope in initializing phase?"

	self isInitializing ifTrue: [^true].
	isScopeRoot ifTrue: [^false].
	^parentPart ifNotNil: [parentPart isScopeInitializing] ifNil: [false]
]

{ #category : #'API testing' }
APart >> isScopeRoot [

	^isScopeRoot or: [parentPart isNil]
]

{ #category : #'API testing' }
APart >> isSimplePrompt [

	^false
]

{ #category : #accessing }
APart >> key [

	^key
]

{ #category : #API }
APart >> localeIDToUse [
	^ nil
	
]

{ #category : #logging }
APart >> logException: ex [

	parentPart ifNotNil: [parentPart logException: ex] ifNil: [ex signal]
]

{ #category : #focus }
APart >> loseFocus [ 

	"just for compatibility"
	^ true
]

{ #category : #API }
APart >> matchingPresenterClass [ 

	^ (self clientRegistry findClientClassesForPart: self) anyOne
	
]

{ #category : #'API testing' }
APart >> mayCallSetterFor: aKey [

	^(self setterConditionFor: aKey)
		"Block"	 value 
		"Condition" booleanValue
]

{ #category : #accessing }
APart >> mayChangeSelection [

	^ true
]

{ #category : #'API member groups' }
APart >> memberGroup: aMemberGroup acceptedBy: aPart [ 

	"re-define me in subclasses"

]

{ #category : #'API member groups' }
APart >> memberGroupUnexposed: aSymbol [ 

	"The part that exposed a member group named aSymbol stopped to do that."
]

{ #category : #private }
APart >> modelForAspect: aspectKey [

	^(partInterface description aspectFor: aspectKey
		ifAbsent: [ APMissingAspectKeyError signalKey: aspectKey]) subAdaptor
]

{ #category : #API }
APart >> namedConditions [

	^ namedConditions
]

{ #category : #updating }
APart >> noticeInvalidValueForAspect: anAspectKey [

	<ignoreForCoverage>
	"Typically results from a failed validation method in the GUI with mismatched type (e.g., not allowed character number input).
Generally, a part does nothing here. Subclasses can reset the value in the Aspect slot to avoid getting a last valid value in the slot even though the GUI displays an invalid value. "

	"DE:Entsteht aus einer fehlgeschlagenen Validierungsmethode im GUI typischerweise bei nicht übereinstimmendem Typ (z.B. nicht als Zahl erlaubte Zeicheneingabe).
	Generell unternimmt ein Part hier nichts. Subklassen können den Wert im Aspect-Slot zurücksetzen, um zu vermeiden, dass ein zuletzt gültiger Wert im Slot erhalten bleibt, obwohl im GUI ein ungültiger Wert angezeigt wird."
]

{ #category : #updating }
APart >> noticeRemovedFromParent [

	subParts ifNotNil: [ :aCollection | 
		aCollection do: [ :aSubPart | aSubPart noticeRemovedFromParent ] ].
	partInterface ifNotNil: [partInterface noticeRemovedFromParent]
]

{ #category : #API }
APart >> objectsForAnnouncement [
	"Normally, a part has no special objects (i.e., those that are not a sub-part) for which notifications are to be sent."

	^#()
]

{ #category : #'API open/close' }
APart >> openClient [

	^ self platform openClientFor: self
]

{ #category : #'API open/close' }
APart >> openClientForSubAppKey: aSubAppKey [

	| parentClients |
	parentClients := (clientRegistry findClientsForInterface: partInterface) ifNil: [^self].
	parentClients do: [:c |
		aSubAppKey ifNotNil: [
			c
				updateConfigurationsFromPart;
				setActiveSubAppForKey: aSubAppKey.
		] ifNil: [
			c closeActiveSubApp
		]
	]
]

{ #category : #'API open/close' }
APart >> openClientPrompt [

	^self openClientPromptClosingPartAtEnd: true
]

{ #category : #'API open/close' }
APart >> openClientPromptClosingPartAtEnd: shallClose [

	| existingClient |
	
	existingClient := self partInterface clientRegistry clientsForInterface: self partInterface ifPresent: [: c | c ] ifAbsent: [nil].

	 ^ self openClientPromptClosingPartAtEnd: shallClose client: existingClient
]

{ #category : #'API open/close' }
APart >> openClientPromptClosingPartAtEnd: shallClose client: aClientOrNil [

	"If the client is nil, detect it automatically"

	| recordingClients result |
	
	[| promptExecutors bestMatch |
	recordingClients := parentPart notNil
				ifTrue: [parentPart partInterface cloneInteractionListenersOn: partInterface]
				ifFalse: [OrderedCollection new].
	isOpenAsPrompt := true.
	isScopeRoot := true.
	aClientOrNil 
		ifNil: [ 
			promptExecutors := ((partInterface findParentClientsForPrompt: self)
						collect: [:eachClient | eachClient promptExecutor]) asSortedCollection: 
								[:a :b |
								(a weightForExecutingPrompt: self) >= (b weightForExecutingPrompt: self)] ]
		ifNotNil: [ 
			promptExecutors := { aClientOrNil promptExecutor } asOrderedCollection ].
	bestMatch := promptExecutors removeFirst.
	clientRegistry startExclusivePart: self.
	result := bestMatch executePromptForPart: self synchronize: promptExecutors]
			ensure: 
				[recordingClients do: 
						[:c |
						parentPart notNil
							ifTrue: [c finishRecordingPromptUnder: parentPart partInterface]].
				clientRegistry endExclusivePart: self.
				shallClose
					ifTrue: 
						[self setClosing.
						partInterface checkForClosingPart].
				isOpenAsPrompt := false.
				isScopeRoot := false].
	^result
]

{ #category : #'API open/close' }
APart >> openClientPromptOnSelf [

	^self openClientPromptClosingPartAtEnd: false
]

{ #category : #API }
APart >> parentInterface [

	^parentPart partInterface
]

{ #category : #accessing }
APart >> parentPart [

	^parentPart
]

{ #category : #API }
APart >> partConditionReasonAlong: aPath [

	self reasonForInactivity ifNotNil: [:r | ^r].
	^(self
		subPartsAlongPath: aPath
		detect: [:part | part reasonForInactivity notNil]
		ifNone: []) ifNotNil: [:p | p reasonForInactivity]
]

{ #category : #accessing }
APart >> partInterface [

	^partInterface
]

{ #category : #API }
APart >> partRibbonId [

	^self class partRibbonId
]

{ #category : #focus }
APart >> partWithFocus [

	^ self partWithFocusIgnoring: Set new
]

{ #category : #focus }
APart >> partWithFocusIgnoring: partsToIgnore [

	(partsToIgnore includes: self) 
		ifTrue: [ ^ nil ].
		
	(self subPartOrSelfWithFocusIgnoring: partsToIgnore) ifNotNil: [ :aPart | ^ aPart ].
	^ self parentPart 
		ifNotNil: [ :aParent | 
			partsToIgnore add: self.
			aParent partWithFocusIgnoring: partsToIgnore ]
		ifNil: [ nil ]
]

{ #category : #'API paths' }
APart >> pathFromRoot [
	| path |
	path := OrderedCollection new.
	self addPathFromRootSegmentTo: path.
	path addFirst: '/'.
	^ path
]

{ #category : #private }
APart >> pathFromRootPart: aRootPart [
	"Calculation of the rootPart path, taking into account the GlorpPart structures."
	"DE:Berechnung des Pfades vom rootPart, mit Berücksichtigung der GlorpPart-Strukturen."

	| path |
	path := (self partInterface partPathUpTo: aRootPart) reverse asOrderedCollection
				yourself.
	path := path
				collect: [:sym | sym isNumber ifTrue: [#selectedObjectPart] ifFalse: [sym]].
	^path
]

{ #category : #API }
APart >> platform [ 

	^ APartPlatform current
]

{ #category : #'API popups' }
APart >> popup: aPart at: aPoint [

	self sendNotification: #popup with: aPart with: aPoint

]

{ #category : #'initialize-release' }
APart >> pragmaRoot [
	"Wurzel der Suche nach Aspekt-/Action-definierende Pragmas (initializeActionsByPragma/defineAspectsByPragma)"

	^self class
]

{ #category : #'initialize-release' }
APart >> pragmasNamed: pName [

	^Pragma
		allNamed: pName
		from: self class
		to: self pragmaRoot
]

{ #category : #API }
APart >> prepareForLocaleSwitchTo: newAPartLocale [

	"Adapt all model values to the new locale to be prepared when the view will be notified later (not from inside here)"

	self subPartsDo: [ :aPart | aPart prepareForLocaleSwitchTo: newAPartLocale ].

]

{ #category : #'initialize-release' }
APart >> prepareForRemoval [


]

{ #category : #events }
APart >> presenterBuilt: aPresenter [ 

	"aPresenter is created and initialized"
]

{ #category : #private }
APart >> privSubPartsAt: aKey put: aSubPart [

	subParts at: aKey put: aSubPart
]

{ #category : #'API member groups' }
APart >> processMemberGroup: aMemberGroup [

	self isReleased ifTrue: [ ^ self ].

	(self canAcceptMemberGroup: aMemberGroup) 
		ifFalse: [ ^ self ].
	
	self acceptMemberGroup: aMemberGroup.
	aMemberGroup acceptedBy: self
]

{ #category : #'API trigger' }
APart >> promptClosingTriggerKey [

	^self class promptClosingTriggerKey
]

{ #category : #API }
APart >> promptSelector [

	^self defaultPromptSelector
]

{ #category : #API }
APart >> reasonForInactivity [

	^statefulCondition
		ifNotNil: [statefulCondition isActive ifFalse: [statefulCondition reason]]
]

{ #category : #'API member groups' }
APart >> reexpose [ 

	exposedMemberGroups valuesDo: [ :each | self exposeMemberGroup: each ]	
]

{ #category : #'API paths' }
APart >> relativePathToRoot [

	^ self pathFromRoot collect: [ :each | '..' ]
]

{ #category : #'initialize-release' }
APart >> release [

	self releaseExposedMemberGroups.

	super release.
	subParts
		ifNotNil: 
			[subParts copy do: #release.
			subParts := nil].
	self disconnectFromParent.
	partInterface := nil.
	description := nil.
	clientRegistry := nil.
	statefulCondition := nil.
	namedConditions := nil.

]

{ #category : #'API member groups' }
APart >> releaseExposedMemberGroups [

	exposedMemberGroups do: [ :each |
		self rootPart memberGroupsRegistry unexposeMemberGroupNamed: each id from: self]
]

{ #category : #'API member groups' }
APart >> removeNamedCondition: aName [ 

	namedConditions removeKey: aName
]

{ #category : #API }
APart >> removeSubPartForKey: aKey [

	subParts ifNil: [^self].
	^(subParts removeKey: aKey ifAbsent: [])
		ifNotNil: [:removed | removed noticeRemovedFromParent]
]

{ #category : #API }
APart >> result [
	
	<ignoreForCoverage>
	"Default for subclasses that are promptable"
	"DE:Default für Subklassen, die promptable sind"

	^nil
]

{ #category : #API }
APart >> reworkAspectAdaptor: anAspectAdaptor [

	<ignoreForCoverage>
	"default implementation has no effect"
	
	^anAspectAdaptor
]

{ #category : #API }
APart >> rootPart [

	^parentPart ifNotNil: [:pc | pc rootPart] ifNil: [self]
]

{ #category : #updating }
APart >> rootUpdate [

	^partInterface rootUpdateAndAnnounce
]

{ #category : #updating }
APart >> rootUpdateAll [

	^partInterface updateAndAnnounceAll
]

{ #category : #API }
APart >> scopeRootPart [

	self isScopeRoot ifTrue: [^self].
	^parentPart scopeRootPart
]

{ #category : #updating }
APart >> scopeUpdate [

	^partInterface scopeUpdateAndAnnounce
]

{ #category : #'API notifications' }
APart >> sendNotification: aName [

	self sendNotification: aName withArguments: Array new

]

{ #category : #'API notifications' }
APart >> sendNotification: aName with: argument1 [

	self sendNotification: aName withArguments: { argument1 }

]

{ #category : #'API notifications' }
APart >> sendNotification: aName with: argument1 with: argument2 [

	self sendNotification: aName withArguments: { argument1. argument2 }

]

{ #category : #'API notifications' }
APart >> sendNotification: aName withArguments: argumentsArray [

	| aNotification |
	
	self isReleased ifTrue: [ ^ self ].
	
	aNotification := (APInterfaceNotificationAnnouncement interface: self partInterface)
		notificationName: aName;
		arguments: argumentsArray;
		yourself.
	
	self partInterface announcer announce: aNotification
]

{ #category : #'API open/close' }
APart >> setClosing [
	"Closing a part involves calling #release, so that the #release does not start too soon, if #requestForPartClose is confirmed, only one flag will be set first.
This will only be evaluated after the end of the extreme call of all actions in #finishClosing."
	"DE:Das Schließen eines Parts beinhaltet den Aufruf von #release. Damit der #release nicht zu früh erfolgt, wird bei bestätigem #requestForPartClose zuerst nur eine Markierung gesetzt.
	Diese wird erst nach dem Ende des äußersten Aufrufs aller Aktionen in #finishClosing ausgewertet."

	isClosing := true
]

{ #category : #'initialize-release' }
APart >> setStatefulConditionOn: aCondition [

	statefulCondition := APStatefulCondition on: aCondition
]

{ #category : #API }
APart >> setterConditionFor: aKey [

	self isActive ifFalse: [^APConditionFinal on: self class reasonInactive].
	^namedConditions at: aKey ifAbsent: [APCondition true]
]

{ #category : #'API testing' }
APart >> shallLiveWithoutClients [
	"Called to decide if a part remains active without clients (for example, as a service). Can be over-defined by subclasses."
	"DE:Wird aufgerufen, um zu entscheiden, ob ein Part auch ohne Clients aktiv bleibt (z.B. als Service). Kann von Subklassen überdefiniert werden."

	^false
]

{ #category : #reflectivity }
APart >> shapePartChildren [

	| aCollection |
	
	aCollection := OrderedCollection new: subParts size.
	self subPartsDo: [ :aSubpart | aCollection add: aSubpart ].
	^aCollection
]

{ #category : #focus }
APart >> someParentHasFocus [
	
	parentPart ifNil: [ ^ false ].
	parentPart hasFocus ifTrue: [ ^ true ].
	^ parentPart someParentHasFocus 
]

{ #category : #focus }
APart >> someSubPartHasFocus [
	
	self subPartsDo: [ :aSubPart | aSubPart hasFocus ifTrue: [ ^ true ] ].
	self subPartsDo: [ :aSubPart | aSubPart someSubPartHasFocus ifTrue: [ ^ true ] ].
	
	^ false
]

{ #category : #accessing }
APart >> statefulCondition [

	^statefulCondition
]

{ #category : #API }
APart >> subAppConfiguration [
	"Subclasses can return an object of class APartSubAppConfiguration."
	"DE:Subklassen können ein Objekt der Klasse APartSubAppConfiguration zurückgeben."

	^nil
]

{ #category : #API }
APart >> subInterfaces [

	| interfaces |
	interfaces := OrderedCollection new.
	subParts
		keysAndValuesDo: [:k :sc | sc partInterface ifNotNil: [:pi | interfaces add: pi]].
	^interfaces
]

{ #category : #private }
APart >> subPartAt: aKey ifNone: aBlock [

	^subParts at: aKey ifAbsent: aBlock
]

{ #category : #API }
APart >> subPartCount [

	^subParts size
]

{ #category : #private }
APart >> subPartOrAspectAt: aKey ifNone: aBlock [
	
	| anAspect |

	"auto-ascpects can cause aspects creation in an infinite recurion loop. We need to ignore them"
	anAspect := self description aspectFor: aKey ifAbsent: [ nil ] ignoreAutoAspects: true.
	anAspect value supportsAPartRedirection ifTrue: [ ^ anAspect value ].
	
	^ subParts at: aKey ifAbsent: aBlock
]

{ #category : #focus }
APart >> subPartOrSelfWithFocusIgnoring: partToIgnore [

	(partToIgnore includes: self) ifTrue: [ ^ nil ].
	self hasFocus ifTrue: [ ^ self ].
	self subPartsDo: [ :aSubPart | 
		| foundPart |
		((partToIgnore includes: self) not 
			and: [ (foundPart := aSubPart subPartOrSelfWithFocusIgnoring: partToIgnore) notNil])
				ifTrue: [ ^ foundPart ] ].
	^ nil
]

{ #category : #API }
APart >> subPartsAlongPath: aPath detect: aBlock ifNone: aNoneBlock [

	| nextPart |
	nextPart := self.
	aPath do: 
			[:p |
			nextPart := nextPart subPartAt: p ifNone: [].
			nextPart ifNil: [^aNoneBlock value].
			(aBlock value: nextPart) ifTrue: [^nextPart]].
	^aNoneBlock value
]

{ #category : #API }
APart >> subPartsAnySatisfy: aBlock [

	subParts keysAndValuesDo: [:k :sc | (aBlock value: sc) ifTrue: [^true]].
	^false
]

{ #category : #API }
APart >> subPartsCopyDo: aBlock [

	"iterate over subParts on a shallow copy of the subparts collection. Use this method if you
	need to modify the subParts collection during iteration"
	
	subParts copy keysAndValuesDo: [:k :sc | aBlock value: sc]
]

{ #category : #API }
APart >> subPartsDo: aBlock [

	subParts keysAndValuesDo: [:k :sc | aBlock value: sc]
]

{ #category : #API }
APart >> subPartsForRibbonConfiguration [
	"Definiert den Maximalumfang derjenigen SubParts, deren Actions bzw. Aspekte in das logische Interface des Parts selbst integriert werden sollen.
	Wird derzeit nur für die Eingrenzung der Suche nach Ribbon-Pragmas verwendet. Generische Part-Klassen enthalten keine solchen Pragmas.
	Spezielle Anwendungsklassen können abhängig von bestimmten Szenarien die exponierten SubParts einschränken oder auf weitere Subebenen erweitern."

	^subParts values
]

{ #category : #API }
APart >> subPartsOfKind: aPartClass [

	| result |
	result := OrderedCollection new.
	subParts
		keysAndValuesDo: [:aKey :aSubpart | (aSubpart isKindOf: aPartClass) ifTrue: [result add: aSubpart]].
	^result
]

{ #category : #API }
APart >> subPartsOfKind: aPartClass do: aBlock [

	subParts
		keysAndValuesDo: [:k :sp | (sp isKindOf: aPartClass) ifTrue: [aBlock value: sp]]
]

{ #category : #API }
APart >> subPartsRecursivelyDo: aBlock [

	"note: do not depend on processing order"

	^self subPartsDo: 
			[:sp |
			sp subPartsRecursivelyDo: aBlock.
			aBlock value: sp]
]

{ #category : #'API testing' }
APart >> subpartsHierarchyIncludes: aPart [

	self subPartsDo: [ :subpart | aPart = subpart ifTrue: [ ^ true ] ].
	
	self subPartsDo: [ :subpart | (subpart subpartsHierarchyIncludes: aPart) ifTrue: [ ^ true ] ].
	
	^ false

]

{ #category : #'API testing' }
APart >> supportsAPartRedirection [ 

	^ true
]

{ #category : #events }
APart >> switchedAway [

	"the switching part owning this part was switched to some other one"
]

{ #category : #API }
APart >> switchedAwayFrom: aKey [

	subParts ifNil: [^self].
	subParts at: aKey ifPresent: [ :aPart | aPart switchedAway ].
]

{ #category : #focus }
APart >> takeFocus [ 
	
	"focus not accepted"
	^ false
]

{ #category : #'tasks management' }
APart >> taskCreated: aTask [ 

	"do nothing here. You can register aTask to know what tasks to interrupt if needed."

]

{ #category : #'API trigger' }
APart >> trigger: aKey do: aZeroArgsBlock [

	^partInterface putTrigger: (APTriggerAction key: aKey do: aZeroArgsBlock)
]

{ #category : #'API trigger' }
APart >> trigger: aKey withArgumentDo: aOneArgBlock [

	^partInterface
		putTrigger: (APTriggerAction key: aKey do: aOneArgBlock) expectArgument
]

{ #category : #'API trigger' }
APart >> trigger: aKey withPartAndArgumentDo: aTwoArgsBlock [
	"This call is probably never needed in practice, because there should be no use case for providing a trigger in the SubPart with an argument."
	"DE:Dieser Call wird in der Praxis vermutlich nie benötigt, weil es keinen Anwendungsfall dafür geben dürfte, einen Trigger im SubPart noch mit einem Argument zu versehen."

	^partInterface
		putTrigger: (APTriggerAction key: aKey do: aTwoArgsBlock) runInParentPart
				expectArgument
]

{ #category : #'API trigger' }
APart >> trigger: aKey withPartDo: aZeroOrOneArgBlock [
	"In any case, this variant causes the ParentPart to execute the trigger call, as long as the ActionBlock expects an argument, it will later be assigned the sub-part.
This serves to be able to address a prompt already closed in the GUI via the block in order to determine the result of the prompts. "
	"DE:Diese Variante führt in jedem Fall dazu, dass der ParentPart den Trigger-Call ausführt. Sofern der ActionBlock ein Argument erwartet, wird dieses später mit dem Sub-Part belegt.
	Das dient dazu, einen im GUI bereits geschlossenen Prompt noch über den Block adressieren zu können, um das Resultat des Prompts zu ermitteln."

	^partInterface
		putTrigger: (APTriggerAction key: aKey do: aZeroOrOneArgBlock)
				runInParentPart
]

{ #category : #API }
APart >> tryHandlingException: ex onAction: anAction with: anArgument [

	ex pass
]

{ #category : #focus }
APart >> unfocus [ 

	"just for compatibility"
	^ true
]

{ #category : #API }
APart >> uniqueSubPartKeyStartingWith: aSubPartKey [

	| uniqueKey index |
	uniqueKey := aSubPartKey asSymbol.
	index := 0.
	[subParts includesKey: uniqueKey] whileTrue: 
			[index := index + 1.
			uniqueKey := (aSubPartKey , index printString) asSymbol].
	^uniqueKey
]

{ #category : #updating }
APart >> updateCondition [

	statefulCondition notNil ifTrue: [statefulCondition updateCondition]
]

{ #category : #updating }
APart >> updateConditionUsingCache: conditionCache [

	statefulCondition notNil
		ifTrue: [statefulCondition updateConditionUsingCache: conditionCache]
]

{ #category : #'initialize-release' }
APart >> useClientRegistry: aClientRegistry [

	clientRegistry isNil ifFalse: [self error: 'Trying to reassign ClientRegistry'].
	clientRegistry := aClientRegistry.
]

{ #category : #API }
APart >> walkPath: aPath [

	| nextPart |
		
	nextPart := self.
	
	aPath size = 1 ifTrue: [ 
		(#('..' '/') includes: aPath first )
			ifTrue: [ self aPartError: #invalidPath ].
		
		nextPart -> { aPath last} ].
	
	aPath allButLast doWithIndex: [:p :i |
			nextPart :=  (p = '..') 
				ifTrue: [ nextPart parentPart ifNil: [ self aPartError: #pathOverLimit ] ]
				ifFalse: [ 
					(p = '/')
						ifTrue: [ nextPart rootPart ]
						ifFalse: [ 
							nextPart subPartOrAspectAt: p ifNone: [
								^nextPart -> (aPath copyFrom: i to: aPath size)]]] ].
	^nextPart -> { aPath last}
]

{ #category : #API }
APart >> walkPathToTheLastAspect: aPath [

	"walk the path but stop before the last aspect."

	| shortedPathResult lastObject  |
	
	shortedPathResult := self walkPath: aPath allButLast.
	lastObject := shortedPathResult key subPartOrAspectAt: aPath last ifNone: [ ].
	
	lastObject supportsAPartRedirection ifTrue: [ ^ shortedPathResult ].
	^ lastObject -> #()
	
]

{ #category : #'API open/close' }
APart >> whenClosingDo: aBlock [
	"Even non-random blocks are allowed, but in any case the trigger will be executed later with the #runInParentPart option."
	"DE:Auch argumentlose Blöcke sind erlaubt. In jedem Fall wird der Trigger später mit der Option #runInParentPart ausgeführt."

	aBlock numArgs = 2
		ifTrue: 
			[self trigger: self promptClosingTriggerKey withPartAndArgumentDo: aBlock]
		ifFalse: [self trigger: self promptClosingTriggerKey withPartDo: aBlock]
]

{ #category : #API }
APart >> windowTitle [ 
	"Overwrite in subclasses if needed"
	
	^nil
]

{ #category : #reflectivity }
APart >> withAllSubparts [

	| aCollection |
	
	aCollection := IdentitySet new.
	self subPartsDo: [ :aSubpart | aCollection addAll: aSubpart withAllSubparts ].
	^ (IdentitySet with: self), aCollection
]
