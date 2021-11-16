Class {
	#name : #APInterfaceNotificationAnnouncement,
	#superclass : #APInterfaceAnnouncement,
	#instVars : [
		'notificationName',
		'arguments'
	],
	#category : #'APart Basic-Announcements'
}

{ #category : #accessing }
APInterfaceNotificationAnnouncement >> arguments [
	^ arguments
]

{ #category : #accessing }
APInterfaceNotificationAnnouncement >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
APInterfaceNotificationAnnouncement >> notificationName [
	^ notificationName
]

{ #category : #accessing }
APInterfaceNotificationAnnouncement >> notificationName: anObject [
	notificationName := anObject
]
