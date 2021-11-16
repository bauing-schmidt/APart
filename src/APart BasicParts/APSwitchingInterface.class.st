"
APSwitchingInterface ist das Interface zu APSwitchingPart.
it keeps a record of all aspects created from paths that do have the switching part as part of the path, it handles the changed value notification, and the enablement/disablement when the currentPart has changed.
"
Class {
	#name : #APSwitchingInterface,
	#superclass : #APartInterface,
	#instVars : [
		'registeredForUpdates'
	],
	#category : #'APart BasicParts'
}

{ #category : #'API Action' }
APSwitchingInterface >> actionAt: anActionKey ifAbsent: absentBlock [

	^self subInterface
		ifNil: [absentBlock value]
		ifNotNil: [:interface | interface description actionAt: anActionKey ifAbsent: absentBlock]
]

{ #category : #announcements }
APSwitchingInterface >> aspectConditionHasChangedFor: aKey [

	self subInterface
		ifNotNil: [:subInterface | ^subInterface aspectConditionHasChangedFor: aKey].
	^super aspectConditionHasChangedFor: aKey
]

{ #category : #updating }
APSwitchingInterface >> changedAspectValue: aspectKey suppressListeners: shallSuppressListeners bypassUpdatesHold: bypassUpdatesHold [

	| modifiedKey |
	super
		changedAspectValue: aspectKey
		suppressListeners: shallSuppressListeners
		bypassUpdatesHold: bypassUpdatesHold.
	modifiedKey := aspectKey.
	part subPartsDo: 
			[:subPart |
			modifiedKey := (modifiedKey copyReplaceAll: subPart key
						with: part key) asSymbol].
	registeredForUpdates keysAndValuesDo: 
			[:k :v |
			(k endsWith: modifiedKey)
				ifTrue: 
					[self scopeRootInterface aspectValueChanged: v
						bypassUpdatesHold: bypassUpdatesHold]]
]

{ #category : #updating }
APSwitchingInterface >> changedAspectValues: aspectKeyColl [

	self subInterface changedAspectValues: aspectKeyColl
]

{ #category : #announcements }
APSwitchingInterface >> computeAnnouncedStateForKey: aKey [

	self subInterface
		ifNotNil: [:subInterface | ^subInterface computeAnnouncedStateForKey: aKey].
	(registeredForUpdates keys anySatisfy: [:k | k endsWith: aKey])
		ifTrue: 
			[^self
				createAnnouncedStateOn: (APConditionFinal on: #NoCurrentPart)
				key: aKey].
	^super computeAnnouncedStateForKey: aKey
]

{ #category : #'API Aspects' }
APSwitchingInterface >> currentPartChanged [

	registeredForUpdates values do: [:each | each changed].
]

{ #category : #'API Aspects' }
APSwitchingInterface >> definesAspect: aKey [

	^self subInterfaces
		allSatisfy: [:subInterface | subInterface description definesAspect: aKey]
]

{ #category : #'initialize-release' }
APSwitchingInterface >> initialize [

	super initialize.
	registeredForUpdates := Dictionary new
]

{ #category : #'API Action' }
APSwitchingInterface >> registerForUpdatesKey: aKey adaptor: anAspectAdator [

	registeredForUpdates at: aKey put: anAspectAdator
]

{ #category : #private }
APSwitchingInterface >> selfOrSubInterfaceDo: aBlock [

	^self subInterface ifNotNil: [:si | aBlock value: si]
]

{ #category : #private }
APSwitchingInterface >> subInterface [

	^part currentPart ifNotNil: [:cc | cc partInterface]
]

{ #category : #'initialize-release' }
APSwitchingInterface >> subRegisterClient: aClient under: anObject [

	self announcer when: APartSwitchedAnnouncement send: #partSwitched: to: aClient.
	super registerClient: aClient.

]

{ #category : #private }
APSwitchingInterface >> subUnregisterClient: aClient under: anObject [

	self unsubscribe: aClient.
	super unregisterClient: aClient
]
