Class {
	#name : #ApedRemoveLayoutAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'layout'
	],
	#category : #'APart Form Editor-Support-Announcements'
}

{ #category : #accessing }
ApedRemoveLayoutAnnouncement >> layout [
	^ layout
]

{ #category : #accessing }
ApedRemoveLayoutAnnouncement >> layout: anObject [
	layout := anObject
]
