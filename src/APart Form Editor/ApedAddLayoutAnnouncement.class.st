Class {
	#name : #ApedAddLayoutAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'newLayout',
		'parentLayout',
		'layoutChild'
	],
	#category : #'APart Form Editor-Support-Announcements'
}

{ #category : #accessing }
ApedAddLayoutAnnouncement >> layoutChild [
	^ layoutChild
]

{ #category : #accessing }
ApedAddLayoutAnnouncement >> layoutChild: anObject [
	layoutChild := anObject
]

{ #category : #accessing }
ApedAddLayoutAnnouncement >> newLayout [
	^ newLayout
]

{ #category : #accessing }
ApedAddLayoutAnnouncement >> newLayout: anObject [
	newLayout := anObject
]

{ #category : #accessing }
ApedAddLayoutAnnouncement >> parentLayout [
	^ parentLayout
]

{ #category : #accessing }
ApedAddLayoutAnnouncement >> parentLayout: anObject [
	parentLayout := anObject
]
