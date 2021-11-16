"
APartSwitchedAnnouncement wird von einem APSwitchingPart beim Umschalten versendet.
"
Class {
	#name : #APartSwitchedAnnouncement,
	#superclass : #APInterfaceAnnouncement,
	#instVars : [
		'containerId',
		'subId',
		'fromInterface'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APartSwitchedAnnouncement >> containerId [

	^containerId
]

{ #category : #accessing }
APartSwitchedAnnouncement >> containerId: anObject [

	containerId := anObject
]

{ #category : #accessing }
APartSwitchedAnnouncement >> fromInterface [
	^ fromInterface
]

{ #category : #accessing }
APartSwitchedAnnouncement >> fromInterface: anObject [
	fromInterface := anObject
]

{ #category : #accessing }
APartSwitchedAnnouncement >> subId [

	^subId
]

{ #category : #accessing }
APartSwitchedAnnouncement >> subId: anObject [
	subId := anObject
]
