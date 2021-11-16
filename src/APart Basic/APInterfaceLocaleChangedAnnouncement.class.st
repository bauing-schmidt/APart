Class {
	#name : #APInterfaceLocaleChangedAnnouncement,
	#superclass : #APInterfaceAnnouncement,
	#instVars : [
		'locale'
	],
	#category : #'APart Basic-Announcements'
}

{ #category : #accessing }
APInterfaceLocaleChangedAnnouncement >> locale [
	^ locale
]

{ #category : #accessing }
APInterfaceLocaleChangedAnnouncement >> locale: anObject [
	locale := anObject
]
