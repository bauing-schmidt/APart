"
The following comment was copied from the original comments of AnnTestAnnouncement

==========================================================

AnnTestAnnouncement ist ein Testbeispie für den Inhalt eines Announcements, siehe AnnTestAnnouncer class>>#_test
"
Class {
	#name : #APxTestAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'flag',
		'what'
	],
	#category : #'APart Examples-RedirectedAction'
}

{ #category : #accessing }
APxTestAnnouncement >> flag [

	^flag
]

{ #category : #accessing }
APxTestAnnouncement >> flag: anObject [

	flag := anObject
]

{ #category : #accessing }
APxTestAnnouncement >> what [

	^what
]

{ #category : #accessing }
APxTestAnnouncement >> what: anObject [

	what := anObject
]
