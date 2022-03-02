"
APartInterface is the delegate of an APart object with the following tasks:
- manage the actions defined by the associated part;
- Build all AspectModel objects used by external interested parties (e.g., GUI, UnitTest) to access values of the associated Part

--

DE:APartInterface ist der Delegate eines APart-Objekts mit folgenden Aufgaben:
- Verwalten der Actions, die der zugehörige Part definiert;
- Aufbau aller AspectModel-Objekte, die von externen Interessenten (z.B. GUI, UnitTest) verwendet werden, um auf Werte des zugehörigen Parts zuzugreifen
"
Class {
	#name : #APartInterface,
	#superclass : #APartAbstractInterface,
	#instVars : [
		'aspectBuilder',
		'aspectConditionChanges',
		'menus',
		'utilityObjects',
		'shallAcceptActionPaths'
	],
	#category : #'APart Basic-Core'
}

{ #category : #API }
APartInterface class >> pathFromKey: aKey [

	^aKey substrings collect: #asSymbol
]

{ #category : #'API Action' }
APartInterface >> actionAdaptorFor: aKey client: aClient  ifAbsent: absentBlock [

	| action |
	action := self description actionAt: aKey
				ifAbsent: 
					[part subInterfaces do: 
							[:sc |
							| pa |
							pa := sc
										actionAdaptorFor: aKey
										client: aClient
										ifAbsent: [].
							pa notNil ifTrue: [^pa]].
					^absentBlock value].
	^(APAdaptor on: self)
		getBlock: [:m | m];
		setBlock: [:m :v |
				m
					executeAction: action
					with: v
					ifDisabled: [aClient notifyCalledDisabledAction: action]];
			updateBlock: [:m :a :p | m];
		yourself
]

{ #category : #updating }
APartInterface >> addAnnouncedStatesForActionsTo: aCollection collectAll: aBoolean [

	aCollection addAll: (self computeAnnouncedStatesForActionsCollectAll: aBoolean).
]

{ #category : #updating }
APartInterface >> addAnnouncedStatesForAspectsTo: aCollection collectAll: aBoolean [

	self description aspectKeysAndValuesDo: [:k :v | 
		v addAnnouncedStatesTo: aCollection in: self name: k collectAll: aBoolean].

]

{ #category : #updating }
APartInterface >> addAnnouncedStatesOfAspectConditionChangesTo: aCollection collectAll: aBoolean [

	aspectConditionChanges keysAndValuesDo: [:k :condChange |
		(aBoolean 
			or: [part changedPartOrParentRecursively notNil 
			or: [condChange isChanged]])
				ifTrue: [
					aCollection add: (self
						createAnnouncedStateOn: (part inactivePartOrParentRecursively ifNil: [condChange])
						key: k)]].

]

{ #category : #updating }
APartInterface >> addAnnouncedStatesOfRedirectedActionsTo: aCollection collectAll: aBoolean [

	self description actionsRedirected keysAndValuesDo: [:k :redirected |
		| action |
		action := redirected action.
		(aBoolean or: [action isChanged]) ifTrue: [
			aCollection add: (self createAnnouncedStateOn: action key: k)]].

]

{ #category : #'API Action' }
APartInterface >> addDependencyFrom: anAspect to: aPath [

	^ self part dependenciesRegistry addDependencyFrom: self part aspect: anAspect to: aPath 

]

{ #category : #updating }
APartInterface >> addObjectsForAnnouncementsTo: aCollection collectAll: aBoolean [

	part objectsForAnnouncement do: [:obj |
		aCollection 	addAll: (obj computeStatesForAnnounceCollectAll: aBoolean use: self)].

]

{ #category : #'API Action' }
APartInterface >> addRawDependencyFrom: anAspect to: aPath [

	^ self part dependenciesRegistry addRawDependencyFrom: self part aspect: anAspect to: aPath 

]

{ #category : #'API Aspects' }
APartInterface >> aspectBuildRedirectionKey [

	^self aspectBuilder aspectBuildRedirectionKey
]

{ #category : #accessing }
APartInterface >> aspectBuilder [

	^aspectBuilder
]

{ #category : #announcements }
APartInterface >> aspectConditionHasChangedFor: aKey [
	
	^(aspectConditionChanges at: aKey
		ifPresent: [ :aspectConditionChange | aspectConditionChange isChanged]
		ifAbsent: [false])
]

{ #category : #'API building' }
APartInterface >> aspectCreated: aKey [

	aspectConditionChanges at: aKey put: APConditionChange create.

]

{ #category : #'API building' }
APartInterface >> aspectNamed: aKey addDependents: aCollectionOfAspectKeys [
	"If there are aspects which should be informed of the change of the <aKey> aspect
	they may be added as dependents to the <aKey> aspect."

	aCollectionOfAspectKeys do: 
			[:newDependent |
			(self description aspectFor: aKey ifAbsent: [APMissingAspectKeyError signalKey: aKey]) subAdaptor
				addDependent: (self description aspectFor: newDependent ifAbsent: [APMissingAspectKeyError signalKey: aKey]) subAdaptor]
]

{ #category : #'initialize-release' }
APartInterface >> checkForClosingPart [

	part finishClosing
		ifTrue: 
			[interactionListeners
				do: [:eachListener | eachListener recordFinishedClosing].
			self release]
]

{ #category : #announcements }
APartInterface >> computeAnnouncedStateForKey: aKey [
	"Same procedure as in #computeStatesForAnnounceCollectAll :, but returns the current state object to the passed key"
	"DE:Gleiches Verfahren wie in #computeStatesForAnnounceCollectAll:, liefert jedoch das aktuelle State-Objekt zum übergebenen Key"

	aspectConditionChanges at: aKey
		ifPresent: [:condChange | ^self createAnnouncedStateOn: condChange key: aKey].
	self description aspectsRedirected at: aKey
		ifPresent: [:subPart | ^self createAnnouncedStateOn: subPart key: aKey].
	self description actionAt: aKey
		ifPresent: [:action | ^self createAnnouncedStateOn: action key: aKey].
	^nil
]

{ #category : #announcements }
APartInterface >> computeAnnouncedStateForKey: k targetPart: targetPart targetAspect: targetAspect [

	^targetPart inactivePartOrParentRecursively
		ifNotNil: 
			[:inactivePart |
			self createAnnouncedStateOn: inactivePart key: k]
		ifNil: 
			[(targetPart partInterface computeAnnouncedStateForKey: targetAspect)
				ifNotNil: 
					[:state |
					state key: k.
					state]
				ifNil: [self createAnnouncedStateOn: targetPart key: k]]
]

{ #category : #updating }
APartInterface >> computeAnnouncedStatesCollectAll: collectAll [

	| result |
	result := OrderedCollection new.
	self addAnnouncedStatesOfAspectConditionChangesTo: result collectAll: collectAll.
	self addAnnouncedStatesForAspectsTo: result collectAll: collectAll.
	self addAnnouncedStatesForActionsTo: result collectAll: collectAll.
	self addAnnouncedStatesOfRedirectedActionsTo: result collectAll: collectAll.
	self addObjectsForAnnouncementsTo: result collectAll: collectAll.
	^result
]

{ #category : #updating }
APartInterface >> computeAnnouncedStatesForActionsCollectAll: collectAll [

	| result partConditionChanged inactivePart |
	result := OrderedCollection new.
	partConditionChanged := part changedPartOrParentRecursively notNil.
	inactivePart := part inactivePartOrParentRecursively.
	(self description actionsRaw) keysAndValuesDo: 
			[:k :action |
			(collectAll or: [partConditionChanged or: [action isChanged]])
				ifTrue: 
					[result add: (self
								createAnnouncedStateOn: (inactivePart ifNil: [action])
								key: k)]].
	^result
]

{ #category : #updating }
APartInterface >> computeAnnouncedStatesTo: aCollection for: k part: targetPart aspect: targetAspect collectAll: collectAll [

	(collectAll or: 
			[targetPart changedPartOrParentRecursively notNil
				or: [targetPart partInterface aspectConditionHasChangedFor: targetAspect]])
		ifTrue: 
			[aCollection add: (self
						computeAnnouncedStateForKey: k
						targetPart: targetPart
						targetAspect: targetAspect)].
]

{ #category : #'API building' }
APartInterface >> createAspectNamed: aKey build: aBuildBlock [

	self description checkForAspectRedefinition: aKey.
	^self description addAspectWithoutRedefinitionCheck: (APAspect named: aKey for: (aBuildBlock value: aspectBuilder)) as: aKey
]

{ #category : #'API building' }
APartInterface >> createListHolderAspectNamed: aKey build: aBuildBlock [

	self description checkForAspectRedefinition: aKey.
	^self description addAspectWithoutRedefinitionCheck: (APAspect named: aKey for: (aBuildBlock value: aspectBuilder)) as: aKey
]

{ #category : #'API Menu' }
APartInterface >> createMenuForKey: menuKey [

	self createMenuForKey: menuKey use: (part aPartPerform: menuKey)
]

{ #category : #'API Menu' }
APartInterface >> createMenuForKey: menuKey concatenateEnumParts: enumParts [

	| menuParts |
	menuParts := enumParts reject: [:evp | evp enumeration size = 0].
	menuParts isEmpty ifTrue: [^self].
	menus at: menuKey
		put: 
			[| m |
			m := APMenu new.
			menuParts do: [:ep | self aspectBuilder addItemsFromEnumPart: ep to: m]
				separatedBy: [m addLine].
			m]
]

{ #category : #'API Menu' }
APartInterface >> createMenuForKey: menuKey use: enumPart [

	menus at: menuKey put: (aspectBuilder createMenuBlockForPart: enumPart)
]

{ #category : #'API Action' }
APartInterface >> dependantsOf: anAspect [

	^ self part dependenciesRegistry dependantsOf: self part aspect: anAspect
]

{ #category : #'API Action' }
APartInterface >> dependentAspectsOf: anAspect [

	^ self part dependenciesRegistry dependentAspectsOf: self part aspect: anAspect
]

{ #category : #'API Aspects' }
APartInterface >> enumerationKeysFor: aspectKey [

	| redir |
	redir := self description aspectsRedirected at: aspectKey ifAbsent: [^OrderedCollection new].
	^redir toPart enumerationKeys
]

{ #category : #'API Action' }
APartInterface >> execute: aKey ifDisabled: disabledBlock [

	^self
		execute: aKey
		ifDisabled: disabledBlock
		ifAbsent: [ APMissingActionError signalKey: aKey]
]

{ #category : #'API Action' }
APartInterface >> execute: aKey ifDisabled: disabledBlock ifAbsent: absentBlock [

	| action |
	action := self description actionAt: aKey
				ifAbsent: [^absentBlock value].
	^self
		executeAction: action
		ifDisabled: disabledBlock
]

{ #category : #'API Action' }
APartInterface >> execute: aKey with: anArgument ifDisabled: disabledBlock [

	^self
		execute: aKey
		with: anArgument
		ifDisabled: disabledBlock
		ifAbsent: [ APMissingActionError signalKey: aKey ]
]

{ #category : #'API Action' }
APartInterface >> execute: aKey with: anArgument ifDisabled: disabledBlock ifAbsent: absentBlock [

	| action |
	action := self description actionAt: aKey ifAbsent: [^absentBlock value].
	^self executeAction: action with: anArgument ifDisabled: disabledBlock
]

{ #category : #'API Action' }
APartInterface >> executeAction: anAction ifDisabled: disabledBlock [

	^anAction isExecutable
		ifTrue: 
			[(currentActionsExecuted includes: anAction)
				ifTrue: [^self handleRecursionForAction: anAction].
			self privateExecute: anAction for: part with: nil]
		ifFalse: [disabledBlock cull: anAction reasonForInactivity]
]

{ #category : #'API Action' }
APartInterface >> executeAction: basicAction with: anArgument ifDisabled: disabledBlock [

	^basicAction isExecutable
		ifTrue: [self privateExecute: basicAction for: part with: anArgument]
		ifFalse: [disabledBlock cull: basicAction reasonForInactivity]
]

{ #category : #'API Action' }
APartInterface >> executeTrigger: triggerKey [

	^self executeTrigger: triggerKey with: nil
]

{ #category : #'API Action' }
APartInterface >> executeTrigger: triggerKey ifAbsent: absentBlock [

	(self hasTrigger: triggerKey) ifFalse: [^absentBlock value].
	^self executeTrigger: triggerKey with: nil
]

{ #category : #'API Action' }
APartInterface >> executeTrigger: triggerKey with: anArgument [
	"Falls der Trigger nicht verarbeitet wurde, wird er an das parentInterface weiterdeligiert."

	| result |
	(self description triggerActions at: triggerKey
		ifAbsent: [self description actionAt: triggerKey ifAbsent: []])
			ifNotNil: [:action | result := self privateExecute: action for: part with: anArgument]
			ifNil: 
				[self forwardingTriggersToParent ifTrue: [
					self parentInterface
						ifNotNil: [:pi | pi executeTrigger: triggerKey with: anArgument]]].
	^result
]

{ #category : #'API Aspects' }
APartInterface >> findRedirectionOrConstructKeyPointingTo: anAspectKey in: aPartInterface [

	| redirPath s |
	redirPath := aPartInterface partPathUpTo: part.
	redirPath add: anAspectKey.
	redirPath := redirPath asArray.
	self description aspectsRedirected
		keysAndValuesDo: [:k :redir | redir path = redirPath ifTrue: [^k]].
	s := WriteStream on: String new.
	redirPath do: [:pathEl | s nextPutAll: pathEl] separatedBy: [s space].
	^s contents asSymbol
]

{ #category : #'API Action' }
APartInterface >> forwardingTriggersToParent [ 

	^ false
]

{ #category : #private }
APartInterface >> handleRecursionForAction: anAction [

	APActionRecursionError signalFor: anAction key part: part
]

{ #category : #'API Action' }
APartInterface >> hasTrigger: triggerKey [

	^self description triggerActions includesKey: triggerKey
]

{ #category : #'initialize-release' }
APartInterface >> initialize [

	super initialize.
	self initializeAspectBuilder.
	aspectConditionChanges := Dictionary new.
	menus := Dictionary new.
	utilityObjects := Dictionary new.
]

{ #category : #'initialize-release' }
APartInterface >> initializeAspectBuilder [

	aspectBuilder := part aspectBuilderClass on: self
]

{ #category : #'API Action' }
APartInterface >> isActionExecutable: actionKey ifAbsent: absentBlock [

	| action |
	part isActive ifFalse: [^false].
	action := self description actionAt: actionKey ifAbsent: [^absentBlock value].
	^action isExecutable
]

{ #category : #accessing }
APartInterface >> locale [ 

	^ self part locale
]

{ #category : #'API Menu' }
APartInterface >> menuFor: aKey ifAbsent: absentBlock [

	^menus at: aKey
		ifAbsent: 
			[part subInterfaces do: 
					[:sc |
					| menu |
					menu := sc menuFor: aKey ifAbsent: [].
					menu notNil ifTrue: [^menu]].
			^absentBlock value]
]

{ #category : #'API Menu' }
APartInterface >> parentMenuLabelForKey: aKey [
	"UserMessage zurückgeben, falls das Menü mit dem Binding-Key aKey als Submenü ausgeführt werden soll."

	^nil
]

{ #category : #private }
APartInterface >> pathFromKey: aKey [

	^self class pathFromKey: aKey
]

{ #category : #'API Aspects' }
APartInterface >> postBuildComponentKey: aGuiCompKey in: aView [

	aspectBuilder postBuildComponentKey: aGuiCompKey in: aView
]

{ #category : #printing }
APartInterface >> printOn: s [

	<ignoreForCoverage>
	super printOn: s.
	s nextPut: $(.
	part printOn: s.
	s nextPut: $)
]

{ #category : #private }
APartInterface >> privateExecute: anAction for: aPart with: anArgument [
	
	self logAction: anAction.

	^self
		safelyExecuteAction: anAction
		withArgs: (anAction createArgumentsArrayOn: aPart and: anArgument)
		do: 
			[:action :actionArgs |
			| result |
			interactionListeners
				do: [:eachListener | eachListener executingAction: action].
			currentActionsExecuted add: action.
			result := action executeWith: actionArgs.
			action postExecuteForPart: aPart.
			currentActionsExecuted removeLast == action ifFalse: [self halt].
			interactionListeners
				do: [:eachListener | eachListener executedAction: action with: actionArgs for: aPart].
			currentActionsExecuted isEmpty
				ifTrue: [part isOpenAsPrompt ifFalse: [self checkForClosingPart]].
			result]
]

{ #category : #'API Action' }
APartInterface >> putTrigger: aTriggerActionWithKey [

	aTriggerActionWithKey checkConsistencyForPart: part
		ifNotDo: [:msg | self error: msg].
	^self description addActionWithoutRedefinitionCheck: aTriggerActionWithKey
]

{ #category : #'API Action' }
APartInterface >> reasonForActionNotExecutable: actionKey ifAbsent: absentBlock [

	| action |
	part isActive ifFalse: [^part statefulCondition reason].
	action := self description actionAt: actionKey ifAbsent: [^absentBlock value].
	^action statefulCondition reason
]

{ #category : #'API Aspects' }
APartInterface >> recursiveUpdateActionsRedirectedUsingCache: conditionCache [

	| partsToUpdate redirectionTargets |
	
	"We need to reject all interfaces in the same scope because they were already updated."
	
	redirectionTargets := (self description actionsRedirected values collect: [ :anAction | anAction to ]) collect: #part.

	partsToUpdate := redirectionTargets copyWithoutAll: (({self scopeRootInterface}, self scopeRootInterface allSubInterfaces) collect: #part).
	
	partsToUpdate do: [ :aPart | aPart partInterface recursiveUpdateConditionUsingCache: conditionCache ].
]

{ #category : #'API building' }
APartInterface >> redirectExistingAction: aKey to: aPartPath [

	self description checkForActionExistence: aKey.
	self description undefineAction: aKey.
	^ self description createAction: aKey redirectTo: aPartPath
]

{ #category : #'API building' }
APartInterface >> redirectExistingAspect: aKey to: aPartPath [

	self description checkForAspectExistence: aKey.
	self description undefineAspectNamed: aKey.
	^ self description createAspectNamed: aKey redirectTo:  aPartPath
]

{ #category : #'API Aspects' }
APartInterface >> redirectedInterfaces [

	"return interfaces of redirection targets"

	| result |
	result := IdentitySet new: self description aspectsRedirected size.
	self description aspectsRedirected keysAndValuesDo: [:k :v | result add: v to].
	^result
]

{ #category : #'initialize-release' }
APartInterface >> release [

	super release.
	aspectBuilder := aspectConditionChanges := menus := utilityObjects := nil
]

{ #category : #'initialize-release' }
APartInterface >> requestForPartClose [
	"true zurückgeben, wenn sich der Part beenden kann. Wenn ja, wird der Part außerdem sofort beendet, weil davon ausgegangen wird, dass sich Clients ebenfalls beenden.
	Falls ein PromptablePart beendet wird, der nicht als Prompt geöffnet wurde, wird dessen Closing-Trigger explizit aufgerufen, um ein symmetrisches Verhalten
	beim Schließen zu gewährleisten."

	part ifNil: [^true].
	
	[part shallLiveWithoutClients ifTrue: [^false].
	(self executeTrigger: #requestForClose ifAbsent: [true]) ifFalse: [^false].
	part isOpenAsPrompt
		ifFalse: 
			[part promptClosingTriggerKey
				ifNotNil: [:tKey | self executeTrigger: tKey with: part]].
	self closePart]
			on: Error
			do: [:ex | self halt].
	^true
]

{ #category : #private }
APartInterface >> setterConditionForAspect: aKey [

	^(part setterConditionFor: aKey) value
]

{ #category : #updating }
APartInterface >> subInterfacesForPostBuildDo: keyAndModelBlock [

	self allSubInterfaces
		do: [:si | keyAndModelBlock value: si part key value: si]
]

{ #category : #'API Aspects' }
APartInterface >> subjectForAspects [

	^part
]

{ #category : #updating }
APartInterface >> updateCondition [

	self updateConditionUsingCache: IdentityDictionary new
]

{ #category : #updating }
APartInterface >> updateConditionUsingCache: conditionCache [

	super updateConditionUsingCache: conditionCache.
	self description actionsRaw keysAndValuesDo: 
			[:k :a |
			(part isActive and: [ part activeFocus ])
				ifTrue: [a updateConditionUsingCache: conditionCache]
				ifFalse: [a updateOnFinalReason: APart reasonInactive]].
	aspectConditionChanges keysAndValuesDo: 
			[:k :model |
			aspectConditionChanges at: k
				put: (APConditionChange
						fromOld: (aspectConditionChanges at: k)
						toNew: (self setterConditionForAspect: k)
						usingCache: conditionCache)]
]

{ #category : #'API utility' }
APartInterface >> utilityAt: aKey [

	^utilityObjects at: aKey ifAbsent: []
]

{ #category : #'API utility' }
APartInterface >> utilityAt: aKey ifAbsent: absentBlock [

	^utilityObjects at: aKey ifAbsent: absentBlock
]

{ #category : #'API utility' }
APartInterface >> utilityAt: aKey ifAbsentPut: aBlock [

	^utilityObjects at: aKey ifAbsentPut: aBlock
]

{ #category : #'API utility' }
APartInterface >> utilityAt: aKey put: anObject [

	^utilityObjects at: aKey put: anObject
]
