"
APartAnnouncedState represents the state of activation of a particular aspect. When an APInterfaceChangedAnnouncement is sent, it contains a list of APAnnouncedStates.

DE:APartAnnouncedState repräsentiert den Zustand der Aktivierung eines bestimmten Aspekts. Wenn ein APInterfaceChangedAnnouncement versendet wird, dann enthält es eine Liste von APAnnouncedStates.
"
Class {
	#name : #APartAnnouncedState,
	#superclass : #Object,
	#instVars : [
		'key',
		'aspectType',
		'isActive',
		'stateExplainingKey',
		'stateExplainingText'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'instance variables' }
APartAnnouncedState class >> key: aKey active: isActive [

	^ self new 
		key: aKey;
		isActive: isActive
]

{ #category : #accessing }
APartAnnouncedState >> aspectType: anObject [

	aspectType := anObject
]

{ #category : #accessing }
APartAnnouncedState >> isActive [

	^isActive
]

{ #category : #accessing }
APartAnnouncedState >> isActive: anObject [

	isActive := anObject
]

{ #category : #accessing }
APartAnnouncedState >> key [

	^key
]

{ #category : #accessing }
APartAnnouncedState >> key: anObject [

	key := anObject
]

{ #category : #printing }
APartAnnouncedState >> printOn: s [

	super printOn: s.
	key isNil ifTrue: [^self].
	self printStateOn: s
]

{ #category : #printing }
APartAnnouncedState >> printStateOn: s [

	s
		nextPutAll: ' (';
		nextPutAll: key printString;
		nextPut: $=;
		nextPutAll: isActive printString;
		nextPut: $)
]

{ #category : #accessing }
APartAnnouncedState >> resolvedStateExplainingText [

	^stateExplainingText
		ifNil: 
			[stateExplainingKey
				ifNotNil: 
					[stateExplainingKey ]]
]

{ #category : #accessing }
APartAnnouncedState >> stateExplainingKey [

	^stateExplainingKey
]

{ #category : #accessing }
APartAnnouncedState >> stateExplainingKey: anObject [

	stateExplainingKey := anObject
]

{ #category : #accessing }
APartAnnouncedState >> stateExplainingText [

	^stateExplainingText
]

{ #category : #accessing }
APartAnnouncedState >> stateExplainingText: anObject [

	stateExplainingText := anObject
]
