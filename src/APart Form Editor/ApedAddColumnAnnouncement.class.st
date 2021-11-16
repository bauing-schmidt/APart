Class {
	#name : #ApedAddColumnAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'newColumn',
		'parentColumn'
	],
	#category : #'APart Form Editor-Support-Announcements'
}

{ #category : #accessing }
ApedAddColumnAnnouncement >> newColumn [

	^ newColumn
]

{ #category : #accessing }
ApedAddColumnAnnouncement >> newColumn: anObject [

	newColumn := anObject
]

{ #category : #accessing }
ApedAddColumnAnnouncement >> parentColumn [

	^ parentColumn
]

{ #category : #accessing }
ApedAddColumnAnnouncement >> parentColumn: anObject [

	parentColumn := anObject
]
