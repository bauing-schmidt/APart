"
APartDisconnectedInterface replaces a standard interface when the associated part is dismantled. As a result, the client can still address it, but no longer has access to aspects, as all calls to it are implemented neutrally.

--

DE:APartDisconnectedInterface ersetzt ein Standard-Interface, wenn der zugehörige Part abgebaut wird. Dadurch kann es der Client immer noch adressieren, erhält jedoch keinen Zugriff mehr auf Aspekte, da alle diesbezüglichen Aufrufe neutral implementiert sind.
"
Class {
	#name : #APartDisconnectedInterface,
	#superclass : #APartAbstractInterface,
	#instVars : [
		'replacedInterface'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'API Actions' }
APartDisconnectedInterface >> actionAt: anActionKey ifAbsent: absentBlock [

	^absentBlock value
]

{ #category : #accessing }
APartDisconnectedInterface >> aspectBuilder [

	^nil
]

{ #category : #updating }
APartDisconnectedInterface >> changedAll [
]

{ #category : #updating }
APartDisconnectedInterface >> changedAspectValue: aspectKey suppressListeners: shallSuppressListeners bypassUpdatesHold: bypassUpdatesHold [
]

{ #category : #updating }
APartDisconnectedInterface >> changedAspectValues: aspectKeyColl [
]

{ #category : #announcements }
APartDisconnectedInterface >> computeAnnouncedStatesCollectAll: collectAll [

	^OrderedCollection new
]

{ #category : #'initialize-release' }
APartDisconnectedInterface >> initialize [

	replacedInterface := part partInterface.
	replacedInterface ifNil: [^self].
	super initialize.
	self clientRegistry
		clientsForInterface: replacedInterface
		ifPresent: [ :setOfClients |
			setOfClients do: [:c | c changeInterfaceFrom: replacedInterface to: self]]
		ifAbsent: []
]

{ #category : #'API client' }
APartDisconnectedInterface >> isDisconnected [

	^true
]

{ #category : #'API Aspects' }
APartDisconnectedInterface >> redirectedInterfaces [

	^IdentitySet new
]

{ #category : #'initialize-release' }
APartDisconnectedInterface >> release [

	super release.
	replacedInterface := nil
]

{ #category : #updating }
APartDisconnectedInterface >> rootUpdateAndAnnounce [
]

{ #category : #updating }
APartDisconnectedInterface >> scopeUpdateAndAnnounce [
]

{ #category : #updating }
APartDisconnectedInterface >> subInterfacesForPostBuildDo: keyAndModelBlock [
]
