Class {
	#name : #APInterfaceAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'interface'
	],
	#category : #'APart Basic-Announcements'
}

{ #category : #accessing }
APInterfaceAnnouncement class >> interface: anInterface [

	^ self new
		interface: anInterface;
		yourself
]

{ #category : #accessing }
APInterfaceAnnouncement >> interface [
	^ interface
]

{ #category : #accessing }
APInterfaceAnnouncement >> interface: anObject [
	interface := anObject
]
