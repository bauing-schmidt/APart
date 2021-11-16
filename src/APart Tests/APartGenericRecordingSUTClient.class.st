"
APartGenericSUTClient ist ein generischer Client für UnitTests, die keine speziellen Funktionen auf der Client-Seite benötigen (was die Regel ist).

"
Class {
	#name : #APartGenericRecordingSUTClient,
	#superclass : #APartRecordingUnitTestClient,
	#instVars : [
		'extraAnnouncementStack'
	],
	#category : #'APart Tests'
}

{ #category : #accessing }
APartGenericRecordingSUTClient >> extraAnnouncementStack [

	^extraAnnouncementStack
]

{ #category : #'initialize-release' }
APartGenericRecordingSUTClient >> initialize [

	super initialize.
	extraAnnouncementStack := OrderedCollectionWithDependants new.
]

{ #category : #announcements }
APartGenericRecordingSUTClient >> partSwitched: anAnnouncement [
]

{ #category : #announcements }
APartGenericRecordingSUTClient >> partSwitched: anAnnouncement from: aSwitchingInterface [
]

{ #category : #private }
APartGenericRecordingSUTClient >> privateEndRecording [

	parentClient notNil
		ifTrue: 
			[parentClient recordCalledSubInteractions: interactionSequence.
			^self].
	super privateEndRecording
]

{ #category : #announcements }
APartGenericRecordingSUTClient >> registerExtraAnnouncement: anAnnouncement interface: anInterface [

	extraAnnouncementStack add: anAnnouncement.
]

{ #category : #announcements }
APartGenericRecordingSUTClient >> selectorForExtraAnnouncement: originalSelector [

	^#registerExtraAnnouncement:interface:
]
