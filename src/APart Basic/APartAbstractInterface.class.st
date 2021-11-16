"
APartAbstractInterface ist die abstrakte Basisklasse für alle Arten von PartInterface. Alle Aktivitäten direkt im Zusammenhang mit dem zugeordneten Part werden in dieser Klasse implementiert.
"
Class {
	#name : #APartAbstractInterface,
	#superclass : #Object,
	#instVars : [
		'part',
		'partChannel',
		'isDisableRootUpdate',
		'interactionListeners',
		'currentActionsExecuted',
		'holdClientsSignal',
		'changedAspectsHolder',
		'announcer',
		'isClosing'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'instance creation' }
APartAbstractInterface class >> for: aPart [

	^self basicNew initOn: aPart
]

{ #category : #creation }
APartAbstractInterface class >> new [
	"Hier ist noch kein initialize gewünscht"

	^self basicNew
]

{ #category : #'API Aspects' }
APartAbstractInterface >> allAspectKeysInclude: aKey [

	^false
]

{ #category : #accessing }
APartAbstractInterface >> allSubInterfaces [

	^self allSubInterfacesInto: OrderedCollection new
]

{ #category : #accessing }
APartAbstractInterface >> allSubInterfacesInto: aCollection [

	part subPartsDo: 
			[:sc |
			aCollection add: sc partInterface.
			sc partInterface allSubInterfacesInto: aCollection].
	^aCollection
]

{ #category : #updating }
APartAbstractInterface >> announceAllChanges [

	self announceChangesDoAlways: true
]

{ #category : #updating }
APartAbstractInterface >> announceChanges [

	self announceChangesDoAlways: false
]

{ #category : #updating }
APartAbstractInterface >> announceChangesDoAlways: shallDoAlways [
	"In the case of a switching interface, the result can be nil"

	| result |
	self selfOrSubInterfaceDo: 
			[:pif |
			result := pif computeAnnouncedStatesCollectAll: shallDoAlways].
	result size > 0
		ifTrue: 
			[self announcer announce: ((APInterfaceChangedAnnouncement interface: self)
						announcedStates: result;
						yourself)]
]

{ #category : #updating }
APartAbstractInterface >> announceFocusRequest [

	self announcer announce: (APInterfaceFocusRequestAnnouncement interface: self)
]

{ #category : #accessing }
APartAbstractInterface >> announcer [ 
	
	^ announcer
]

{ #category : #private }
APartAbstractInterface >> aspectValueChanged: anAspect bypassUpdatesHold: bypassUpdatesHold [

	(holdClientsSignal not or: [bypassUpdatesHold])
		ifTrue: [^anAspect changed: #value].
	changedAspectsHolder add: anAspect
]

{ #category : #dependencies }
APartAbstractInterface >> aspectsDependingOn: aKey [

	^ self recursiveBackwardDependantsOf: self part aspect: aKey
	
]

{ #category : #'API Aspects' }
APartAbstractInterface >> changeSubject: aGenericListOrFilter [

	partChannel value: aGenericListOrFilter
]

{ #category : #updating }
APartAbstractInterface >> changedAspectValue: aspectKey [

	self changedAspectValue: aspectKey suppressListeners: false
]

{ #category : #updating }
APartAbstractInterface >> changedAspectValue: aspectKey suppressListeners: shallSuppressListeners [

	^self
		changedAspectValue: aspectKey
		suppressListeners: shallSuppressListeners
		bypassUpdatesHold: false
]

{ #category : #updating }
APartAbstractInterface >> changedAspectValue: aspectKey suppressListeners: shallSuppressListeners bypassUpdatesHold: bypassUpdatesHold [

	(part isScopeRoot not and: [self parentInterface notNil])
		ifTrue: 
			[self parentInterface
				changedAspectValue: (part key asString , ' ' , aspectKey) asSymbol
				suppressListeners: shallSuppressListeners
				bypassUpdatesHold: bypassUpdatesHold].
	(self description aspectFor: aspectKey ifAbsent: [])
		ifNotNil: 
			[:aspect |
			self scopeRootInterface
				aspectValueChanged: aspect
				bypassUpdatesHold: bypassUpdatesHold.
			shallSuppressListeners
				ifFalse: 
					[interactionListeners do: 
							[:eachListener |
							eachListener
								changedAspect: aspectKey
								value: aspect value
								in: self].
					self updateDependantsOf: aspectKey ]]
]

{ #category : #updating }
APartAbstractInterface >> changedAspectValues: aspectKeyColl [

	aspectKeyColl
		do: [:aspectKey | self changedAspectValue: aspectKey suppressListeners: false].
	aspectKeyColl notEmpty ifTrue: [^self].
	self selfOrSubInterfaceDo: 
			[:pif |
			pif
				description localAspectKeysDo: [:aspectKey | pif changedAspectValue: aspectKey suppressListeners: false]]
]

{ #category : #'initialize-release' }
APartAbstractInterface >> checkForClosingPart [

	part finishClosing ifTrue: [self release]
]

{ #category : #announcements }
APartAbstractInterface >> clientRegistered: aClient [ 

	self part clientRegistered: aClient
]

{ #category : #accessing }
APartAbstractInterface >> clientRegistry [

	^part ifNotNil: [:p | p clientRegistry]
]

{ #category : #'API client' }
APartAbstractInterface >> cloneInteractionListenersOn: anInterface [

	^(interactionListeners collect: 
			[:ial |
			ial
				privateRecordInteraction: ((anInterface part isSimplePrompt
							ifTrue: [APRecordedInteraction simplePrompt]
							ifFalse: [APRecordedInteraction complexPrompt])
							key: anInterface part key;
							yourself);
				cloneOnSubInterface: anInterface])
		reject: [:e | e isNil]
]

{ #category : #'initialize-release' }
APartAbstractInterface >> closePart [
	"Benachrichtigt Clients über den anstehenden Close des Parts und führt den Close anschließend durch."

	part setClosing.
	self announcer announce: (APInterfaceClosingAnnouncement interface: self).
	(currentActionsExecuted isEmpty or: [part parentPart isNil])
		ifTrue: [part isOpenAsPrompt ifFalse: [self checkForClosingPart]]
]

{ #category : #private }
APartAbstractInterface >> collectExtraAnnouncementsFor: aClient [
	part extraAnnouncements
		do: [ :selectorAndAnnouncement | 
			(self subscriptionRegistry
				hasSubscriptionsOf: aClient receiverForExtraAnnouncements
				for: selectorAndAnnouncement value)
				ifFalse: [ self announcer
						when: selectorAndAnnouncement value
						send: (aClient selectorForExtraAnnouncement: selectorAndAnnouncement key)
						to: aClient receiverForExtraAnnouncements ] ]
]

{ #category : #announcements }
APartAbstractInterface >> computeAnnouncedStatesCollectAll: collectAll [

	self subclassResponsibility
]

{ #category : #announcements }
APartAbstractInterface >> createAnnouncedStateOn: aStatefulObject key: aKey [

	| announcedState |
	announcedState := APartAnnouncedState 
		key: aKey 
		active: aStatefulObject isActive.
	announcedState
		stateExplainingKey: (aStatefulObject isActive
					ifTrue: [self stateExplainingKeyFor: aKey]
					ifFalse: [aStatefulObject reasonForInactivity]);
		stateExplainingText: (self textForStateExplainingKey: announcedState stateExplainingKey).
	self logAnnouncedState: announcedState.
	^announcedState
]

{ #category : #updating }
APartAbstractInterface >> dependentAspectsOf: anAspect [

	^ Set new
]

{ #category : #accessing }
APartAbstractInterface >> description [

	^ self part description
]

{ #category : #'API Action' }
APartAbstractInterface >> executeTrigger: triggerKey ifAbsent: absentBlock [

	^absentBlock value
]

{ #category : #'API client' }
APartAbstractInterface >> findParentClientsForPrompt: aPromptPart [
	"There should be always at least one client to be found.
	In scenarios where no parent exists and furthermore no client has been registered for the prompt part itself,
	the prompt part instance itself will be returned as its client.
	This case, however, can easily be recognized and has to be handled by the part itself."

	| cr interfaces |
	cr := self clientRegistry.
	interfaces := (OrderedCollection withAll: self parentInterfaces)
		add: aPromptPart partInterface;
		yourself.
	interfaces do: [ :eachInterface |
		(cr findClientsForInterface: eachInterface) ifNotNil: [ :setOfClients | ^setOfClients].
	].
	^Set with: aPromptPart
]

{ #category : #testing }
APartAbstractInterface >> hasAspectNamed: aName [

	^ (self description aspectFor: aName ifAbsent: [ nil ]) notNil
]

{ #category : #'API Action' }
APartAbstractInterface >> hasTrigger: triggerKey [

	^false
]

{ #category : #updating }
APartAbstractInterface >> holdClientUpdatesWhile: aBlock [

	^self holdClientUpdatesWhile: aBlock
		performScopeUpdate: part isScopeInitializing not
]

{ #category : #updating }
APartAbstractInterface >> holdClientUpdatesWhile: aBlock performScopeUpdate: shallPerformScopeUpdate [
	"Holding client updates is managed by the scope root interface, it prevents aspect value changes from being propagated until the first block has finished its execution:
		- holdClientsSignal will mark whether a holdClientUpdatesWhile: was already sent to the interface.
		- After the execution of the first block that held the client updates the following will happen:
			- if shallPerformScopeUpdate is set to true, a parent and children recursive update and announce will be called (updating and announcing changes in the current part branch).
			- triggering all queued change notifications.
			- ensuring the reset of the holdClientsSignal."

	part isScopeRoot
		ifFalse: 
			[^self scopeRootInterface holdClientUpdatesWhile: aBlock
				performScopeUpdate: shallPerformScopeUpdate].
	holdClientsSignal ifTrue: [^aBlock value].
	^
	[holdClientsSignal := true.
	aBlock value] ensure: 
				[
				[shallPerformScopeUpdate ifTrue: [self scopeUpdateAndAnnounce].
				changedAspectsHolder copy do: 
						[:aspectOrAdaptor |
						| aspect |
						aspect := aspectOrAdaptor.
						(aspect hasAPValueAdaptor)
							ifTrue: [aspect subAdaptor model isReleased ifFalse: [aspect subAdaptor changed: #value]]
							ifFalse: 
								[(aspect subAdaptor subjectChannel isKindOf: APValueAdaptor)
									ifTrue: [ aspect subAdaptor subjectChannel model isReleased 
										ifFalse: [aspect subAdaptor changed: #value]]
									ifFalse: [aspect subAdaptor subject isReleased 
										ifFalse: [aspect subAdaptor changed: #value]]]]]
						ensure: 
							[changedAspectsHolder wipe.
							holdClientsSignal := false]]
]

{ #category : #'initialize-release' }
APartAbstractInterface >> initOn: aPart [

	part := aPart.
	self initialize
]

{ #category : #'initialize-release' }
APartAbstractInterface >> initialize [

	super initialize.

	announcer := Announcer new.

	holdClientsSignal := false.
	interactionListeners := IdentitySet new.
	currentActionsExecuted := OrderedCollection new.
	changedAspectsHolder := Set new.
	isClosing := false
]

{ #category : #'initialize-release' }
APartAbstractInterface >> initializeAspects [
	"Wird nur für spezielle Anwendungsfälle benötigt. Zum Zeitpunkt dieses Aufrufs sollten bereits alle durch den Part definierten Aspekte vorhanden sein."
]

{ #category : #'API client' }
APartAbstractInterface >> interactionListenersDo: aBlock [

	interactionListeners do: aBlock
]

{ #category : #accessing }
APartAbstractInterface >> isClosing [
	^ isClosing
]

{ #category : #accessing }
APartAbstractInterface >> isClosing: anObject [
	isClosing := anObject
]

{ #category : #'API client' }
APartAbstractInterface >> isDisconnected [

	^part isNil
]

{ #category : #'API Aspects' }
APartAbstractInterface >> localAspectKeys [

	^SortedCollection new
]

{ #category : #'API Aspects' }
APartAbstractInterface >> localAspectKeysDo: aBlock [
]

{ #category : #debugging }
APartAbstractInterface >> logAction: anAction [ 

	"override me in subclass"
]

{ #category : #debugging }
APartAbstractInterface >> logAnnouncedState: announcedState [ 

	"override me in subclass"
]

{ #category : #debugging }
APartAbstractInterface >> logPerform: aKey [ 

	"override me in subclass"
]

{ #category : #updating }
APartAbstractInterface >> noticeRemovedFromParent [
]

{ #category : #'API Menu' }
APartAbstractInterface >> openMenu: aMenu itemValueDo: aOneArgBlock [

	self subclassResponsibility
]

{ #category : #accessing }
APartAbstractInterface >> parentInterface [

	^part parentPart ifNotNil: [:pc | pc partInterface]
]

{ #category : #accessing }
APartAbstractInterface >> parentInterfaces [

	| result next |
	result := OrderedCollection new.
	next := self parentInterface.
	[next notNil] whileTrue: 
			[result add: next.
			next := next parentInterface].
	^result
]

{ #category : #accessing }
APartAbstractInterface >> part [

	^part
]

{ #category : #'API Aspects' }
APartAbstractInterface >> partPathUpTo: ancestorPart [

	^self partPathUpTo: ancestorPart into: OrderedCollection new
]

{ #category : #'API Aspects' }
APartAbstractInterface >> partPathUpTo: ancestorPart into: pathColl [

	pathColl add: part key.
	part parentPart == ancestorPart ifTrue: [^pathColl].
	^self parentInterface partPathUpTo: ancestorPart into: pathColl
]

{ #category : #'API client' }
APartAbstractInterface >> privDisconnect [

	part := nil.
]

{ #category : #updating }
APartAbstractInterface >> recursiveAnnounceAllChanges [

	self announceAllChanges.
	self subInterfaces do: [:si | si recursiveAnnounceAllChanges]
]

{ #category : #updating }
APartAbstractInterface >> recursiveAnnounceChanges [

	self announceChanges.

	self subInterfaces do: [:si | 	si recursiveAnnounceChanges]
]

{ #category : #dependencies }
APartAbstractInterface >> recursiveBackwardDependantsOf: aPart aspect: anAspect [

	| dependencies |
	
	self flag: #todo. "protect recursive dependencies"
	
	dependencies := self part dependenciesRegistry backwardDependantsOf: aPart aspect: anAspect.
	
	(dependencies copy do: [ :eachAssociation | dependencies addAll: (eachAssociation key dependenciesRegistry backwardDependantsOf: eachAssociation key aspect: eachAssociation value) ]).
	
	^ dependencies
]

{ #category : #updating }
APartAbstractInterface >> recursiveParentAnnounceChanges [

	self parentInterface
		ifNotNil: 
			[:parentInterface |
			parentInterface
				announceChanges;
				recursiveParentAnnounceChanges]
]

{ #category : #updating }
APartAbstractInterface >> recursiveParentUpdateCondition [

	self parentInterface
		ifNotNil: 
			[:parentInterface |
			parentInterface
				updateCondition;
				recursiveParentUpdateCondition]
]

{ #category : #updating }
APartAbstractInterface >> recursiveParentUpdateConditionUsingCache: aDict [

	self parentInterface
		ifNotNil: 
			[:parentInterface |
			parentInterface
				updateConditionUsingCache: aDict;
				recursiveParentUpdateConditionUsingCache: aDict]
]

{ #category : #updating }
APartAbstractInterface >> recursiveUpdateActionsRedirectedUsingCache: conditionCache [
	"Nothing to do in base class"
]

{ #category : #updating }
APartAbstractInterface >> recursiveUpdateConditionUsingCache: conditionCache [

	self updateConditionUsingCache: conditionCache.
	self subInterfaces
		do: [:si | si recursiveUpdateConditionUsingCache: conditionCache]
]

{ #category : #'API Aspects' }
APartAbstractInterface >> redirectedInterfaces [

	self subclassResponsibility
]

{ #category : #'API client' }
APartAbstractInterface >> registerClient: aClient [

	(self clientRegistry isClientRegistered: aClient forInterface: self)
		ifTrue: [^self].
	self clientRegistry registerClient: aClient forInterface: self.
	self subscribeInterface: self forAnnouncementsTo: aClient.
	self redirectedInterfaces do: 
			[:redirInterface |
			redirInterface announcer
				when: APInterfaceChangedAnnouncement
				send: #interfaceChanged:
				to: aClient].
	self subInterfaces do: [:si | si subRegisterClient: aClient under: self].
	self collectExtraAnnouncementsFor: aClient
]

{ #category : #'API client' }
APartAbstractInterface >> registerInteractionListener: aClient [

	interactionListeners add: aClient.
	self subInterfaces do: [:si | si registerInteractionListener: aClient]
]

{ #category : #'API client' }
APartAbstractInterface >> registerTopClient: aClient forChangesInSubInterfaces: aSubInterfacesCol [

	aSubInterfacesCol do: 
			[:subInterface |
			subInterface announcer
				when: APInterfaceChangedAnnouncement
				send: #interfaceChanged:fromSubInterface:
				to: aClient]
]

{ #category : #'API client' }
APartAbstractInterface >> registeredClients [

	| cr |
	cr := self clientRegistry.
	self withParentInterfaces do: [ :eachInterface |
		(cr findClientsForInterface: eachInterface) ifNotNil: [ :setOfClients | ^setOfClients].
	].
	^IdentitySet new
]

{ #category : #'API client' }
APartAbstractInterface >> registeredClientsForClientType: aSymbol [

	| cr |
	cr := self clientRegistry.
	self withParentInterfaces do: [ :eachInterface |
		(cr findClientsForInterface: eachInterface) ifNotNil: [ :setOfClients | 
			^setOfClients select: [:cl | cl class clientTypes includes: aSymbol]
		].
	].
	^IdentitySet new
]

{ #category : #'initialize-release' }
APartAbstractInterface >> release [

	self clientRegistry ifNotNil: [:gr | gr removeClientsFor: self].
	announcer := Announcer new.
	super release.
	part := nil.
	
]

{ #category : #'initialize-release' }
APartAbstractInterface >> requestForPartClose [
	"true, wenn sich der Part beenden kann."

	^part shallLiveWithoutClients not
]

{ #category : #'API client' }
APartAbstractInterface >> ribbonConfigurator [

	^nil
]

{ #category : #accessing }
APartAbstractInterface >> rootInterface [

	^part rootPart partInterface
]

{ #category : #updating }
APartAbstractInterface >> rootUpdateAndAnnounce [
	"Root-Interface ist nil, wenn ein Part bereits vom Parent disconnected ist."

	self rootInterface
		ifNotNil: 
			[:ri |
			ri
				recursiveUpdateConditionUsingCache: IdentityDictionary new;
				recursiveAnnounceChanges]
]

{ #category : #accessing }
APartAbstractInterface >> safelyExecuteAction: anAction withArgs: someArgs do: aBlock [

	| actionResult |
	
	[self holdClientUpdatesWhile: 
			[actionResult := aBlock value: anAction value: someArgs]
		performScopeUpdate: anAction wantsScopeUpdate]
			on: Error
			do: 
				[:ex |
				actionResult := nil.
				part notNil
					ifTrue: [part tryHandlingException: ex onAction: anAction with: someArgs]].
	^actionResult
]

{ #category : #accessing }
APartAbstractInterface >> scopeRootInterface [

	^part scopeRootPart partInterface
]

{ #category : #updating }
APartAbstractInterface >> scopeUpdateAndAnnounce [

	| conditionCache |
	part isScopeRoot
		ifFalse: 
			[part isScopeInitializing
				ifFalse: [^self scopeRootInterface scopeUpdateAndAnnounce]].
	conditionCache := IdentityDictionary new: 200.

	self
		recursiveParentUpdateConditionUsingCache: conditionCache;
		recursiveUpdateConditionUsingCache: conditionCache;
		recursiveUpdateActionsRedirectedUsingCache: conditionCache;
		recursiveParentAnnounceChanges;
		recursiveAnnounceChanges
]

{ #category : #private }
APartAbstractInterface >> selfOrSubInterfaceDo: aBlock [

	^aBlock value: self
]

{ #category : #'API client' }
APartAbstractInterface >> sortedPromptExecutors [

	^((self findParentClientsForPrompt: part)
		collect: [:eachClient | eachClient promptExecutor]) asSortedCollection: 
				[:a :b |
				(a weightForExecutingPrompt: self) >= (b weightForExecutingPrompt: self)]
]

{ #category : #private }
APartAbstractInterface >> stateExplainingKeyFor: aKey [

	^nil
]

{ #category : #accessing }
APartAbstractInterface >> subInterfaceAtPath: aPartKeyPath [

	aPartKeyPath isEmpty ifTrue: [^self].
	^(part subPartAt: aPartKeyPath first
		ifNone: [^self error: 'PartKeyPath does not exist: ', aPartKeyPath printString]) partInterface
		subInterfaceAtPath: ((aPartKeyPath asOrderedCollection)
				removeFirst;
				yourself)
]

{ #category : #accessing }
APartAbstractInterface >> subInterfaces [

	^part subInterfaces
]

{ #category : #updating }
APartAbstractInterface >> subInterfacesForPostBuildDo: keyAndModelBlock [

	self subclassResponsibility
]

{ #category : #private }
APartAbstractInterface >> subRegisterClient: aClient under: anInterface [
]

{ #category : #private }
APartAbstractInterface >> subUnregisterClient: aClient under: anInterface [
]

{ #category : #'API Aspects' }
APartAbstractInterface >> subjectChannelForAspects [

	^partChannel ifNotNil: [partChannel]
]

{ #category : #'API client' }
APartAbstractInterface >> subscribeInterface: anInterface forAnnouncementsTo: aClient [

	anInterface announcer
		when: APInterfaceChangedAnnouncement
		send: #interfaceChanged:
		to: aClient.
	anInterface announcer
		when: APInterfaceFocusRequestAnnouncement
		send: #interfaceFocusRequest:
		to: aClient.
	anInterface announcer
		when: APInterfaceClosingAnnouncement
		send: #interfaceClosing:
		to: aClient.
	anInterface announcer
		when: APInterfaceLocaleChangedAnnouncement
		send: #localeChanged:
		to: aClient.
	anInterface announcer
		when: APInterfaceNotificationAnnouncement
		send: #processInterfaceNotification:
		to: aClient
]

{ #category : #private }
APartAbstractInterface >> textForStateExplainingKey: aKey [

	^nil
]

{ #category : #'API client' }
APartAbstractInterface >> unregisterClient: aClient [

	self clientRegistry ifNil: [ ^ self ].

	(self clientRegistry isClientRegistered: aClient forInterface: self)
		ifFalse: [self error: 'Client Interface mistmatch!'].
	self clientRegistry unRegisterClient: aClient forInterface: self.
	self unsubscribeInterface: self forAnnouncementsTo: aClient.
	self redirectedInterfaces
		do: [:redirInterface | redirInterface announcer unsubscribe: aClient].
	self subInterfaces do: [:si | si subUnregisterClient: aClient under: self].
	self unsubscribeExtraAnnouncementsFor: aClient
]

{ #category : #'API client' }
APartAbstractInterface >> unregisterTopClient: aClient forChangesInSubInterfaces: aSubInterfacesCol [

	aSubInterfacesCol do: [:subInterface | subInterface unsubscribe: aClient]
]

{ #category : #private }
APartAbstractInterface >> unsubscribeExtraAnnouncementsFor: aClient [

	self announcer unsubscribe: aClient receiverForExtraAnnouncements
]

{ #category : #'API client' }
APartAbstractInterface >> unsubscribeInterface: anInterface forAnnouncementsTo: aClient [

	anInterface announcer unsubscribe: aClient.
]

{ #category : #updating }
APartAbstractInterface >> updateAndAnnounceAll [

	self
		recursiveUpdateConditionUsingCache: IdentityDictionary new;
		recursiveAnnounceAllChanges
]

{ #category : #updating }
APartAbstractInterface >> updateCondition [

	part updateCondition
]

{ #category : #updating }
APartAbstractInterface >> updateConditionUsingCache: conditionCache [

	part updateConditionUsingCache: conditionCache
]

{ #category : #updating }
APartAbstractInterface >> updateDependantsOf: aKey [

	(self aspectsDependingOn: aKey) do: [ :assoc | 
		assoc key changedAspectValue: assoc value.
		(assoc key partInterface = self) ifFalse: [  
			assoc key partInterface scopeUpdateAndAnnounce ]
	]
]

{ #category : #updating }
APartAbstractInterface >> updatePathConditionsUsingCache: conditionCache [
	"Nothing to do here"
]

{ #category : #'API Aspects' }
APartAbstractInterface >> usePartChannel [

	partChannel := APartPlatform current nativeValueHolderFrom: part
]

{ #category : #'API Action' }
APartAbstractInterface >> withActionAt: anActionKey do: presentBlock ifAbsent: absentBlock [

	^(self description actionAt: anActionKey ifAbsent: [])
		ifNotNil: [:a | presentBlock value: a]
		ifNil: absentBlock
]

{ #category : #accessing }
APartAbstractInterface >> withParentInterfaces [

	^(self parentInterfaces)
		addFirst: self;
		yourself
]
