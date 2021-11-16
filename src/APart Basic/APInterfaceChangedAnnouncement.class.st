"
APInterfaceChangedAnnouncement dient zur Übermittlung von Änderungen des Interface-Objekts an dessen Clients (z.B. APartView-Subklassen)
"
Class {
	#name : #APInterfaceChangedAnnouncement,
	#superclass : #APInterfaceAnnouncement,
	#instVars : [
		'announcedStates'
	],
	#category : #'APart Basic-Announcements'
}

{ #category : #accessing }
APInterfaceChangedAnnouncement >> announcedStates [

	^announcedStates
]

{ #category : #accessing }
APInterfaceChangedAnnouncement >> announcedStates: anObject [

	announcedStates := anObject
]

{ #category : #printing }
APInterfaceChangedAnnouncement >> printOn: s [

	super printOn: s.
	announcedStates size = 0 ifTrue: [^self].
	s
		nextPutAll: ' {';
		cr.
	announcedStates do: 
			[:as |
			s tab.
			as printStateOn: s.
			s cr].
	s
		nextPut: $};
		cr
]
