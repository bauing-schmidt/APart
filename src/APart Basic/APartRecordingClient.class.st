"
APartRecordingClient is the abstract superclass of a client that records all business logic events during enabled recording. For this purpose, an object of the class APRecordedInteraction is generated per event and stored in an ordered collection (recordedInteractions). It also collects all status objects received by announcement in a dictionary.

When recording, the RecordingClient connects to an APartInterface, where it logs in via #registerInteractionListener: for notifications of aspect changes as well as actions performed.

The utilization of the recordings must take place in a subclass (#processRecordedInteractions). It is up to the subclasses to use the recordedInteractions in whole or in part during the recording process.

--

APartRecordingClient ist die abstrakte Superklasse eines Clients, der während des aktivierten Recordings alle zur Geschäftslogik gehörenden Ereignisse aufnimmt. Dazu wird pro Ereignis ein Objekt der Klasse APRecordedInteraction erzeugt und in einer OrderedCollection aufbewahrt (recordedInteractions). Außerdem sammelt er alle per Announcement erhaltenen Status-Objekte in einem Dictionary.

Der RecordingClient verbindet sich bei der Initialisierung mit einem APartInterface, bei dem er sich per #registerInteractionListener: für Benachrichtigungen bei Aspect-Changes sowie bei ausgeführten Aktionen anmeldet.

 Die Verwertung der Aufzeichnungen muss in einer Subklasse erfolgen (#processRecordedInteractions). Dabei steht es den Subklassen frei, die recordedInteractions bereits während der Aufnahme ganz oder teilweise zu verwerten.
"
Class {
	#name : #APartRecordingClient,
	#superclass : #APartHeadlessClient,
	#instVars : [
		'isRecording',
		'announcedStates',
		'hasReceivedShutdown',
		'isLogging',
		'keysToLog',
		'loggingStream'
	],
	#category : #'APart Basic-Clients'
}

{ #category : #announcements }
APartRecordingClient >> announcedStateForKey: aKey ifAbsent: absentBlock [

	^announcedStates at: aKey ifAbsent: absentBlock
]

{ #category : #API }
APartRecordingClient >> changedAspect: anAspectKey value: aValue in: aPartInterface [

	| aspectToRecord |
	aspectToRecord := aPartInterface == partInterface
				ifTrue: [anAspectKey]
				ifFalse: 
					[partInterface findRedirectionOrConstructKeyPointingTo: anAspectKey
						in: aPartInterface].
	isRecording
		ifTrue: [self recordValueChangeAt: aspectToRecord value: aValue]
]

{ #category : #API }
APartRecordingClient >> cloneOnSubInterface: anInterface [

	self subclassResponsibility
]

{ #category : #logging }
APartRecordingClient >> endLogging [

	self logLine: 'End logging recording client'.
	isLogging := false
]

{ #category : #API }
APartRecordingClient >> executedAction: anAction with: actionArgs for: aPart [

	isRecording
		ifTrue: [self recordActionEndFor: anAction with: actionArgs part: aPart]
]

{ #category : #API }
APartRecordingClient >> executingAction: anAction [

	isRecording ifTrue: [self recordActionBeginFor: anAction]
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> finalizeRecordings [

	self subclassResponsibility
]

{ #category : #API }
APartRecordingClient >> finishRecordingPromptUnder: aParentInterface [

	self subclassResponsibility
]

{ #category : #announcements }
APartRecordingClient >> handleDefaultAnnouncedState: anAnnouncedState [

	announcedStates at: anAnnouncedState key put: anAnnouncedState.
	self logLine: #handleDefaultAnnouncedState: printString key: anAnnouncedState key isActive: anAnnouncedState isActive
]

{ #category : #accessing }
APartRecordingClient >> hasReceivedShutdown [

	^ hasReceivedShutdown
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> hasRecordings [

	self subclassResponsibility
]

{ #category : #'initialize-release' }
APartRecordingClient >> initOn: aPartInterface [

	isRecording := false.
	announcedStates := Dictionary new.
	hasReceivedShutdown := false.
	isLogging := false.
	loggingStream := Transcript.
	keysToLog := Set new.
	super initOn: aPartInterface.
	partInterface registerInteractionListener: self.
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> initializeRecordedInteractions [

	self subclassResponsibility
]

{ #category : #announcements }
APartRecordingClient >> interfaceClosing: anAnnouncement [

	super interfaceClosing: anAnnouncement.
	self logLine: 'Shutdown received'.
	isRecording ifTrue: [hasReceivedShutdown := true]
]

{ #category : #logging }
APartRecordingClient >> isLogging [

	^isLogging
]

{ #category : #API }
APartRecordingClient >> isRecording [

	^isRecording
]

{ #category : #API }
APartRecordingClient >> isRecording: aBoolean [

	isRecording := aBoolean.
	isRecording
		ifTrue: [self privateStartRecording]
		ifFalse: [self privateEndRecording]
]

{ #category : #logging }
APartRecordingClient >> keysToLog [

	^keysToLog
]

{ #category : #logging }
APartRecordingClient >> keysToLog: someKeys [

	keysToLog addAll: someKeys
]

{ #category : #logging }
APartRecordingClient >> logLine: aString [

	isLogging ifFalse: [^self].
	self loggingStream nextPutAll: aString asString; cr.
]

{ #category : #logging }
APartRecordingClient >> logLine: aString key: aKey isActive: aBoolean [

	isLogging ifFalse: [^self].
	keysToLog notEmpty ifTrue: [(keysToLog includes: aKey) ifFalse: [^self]].
	self
		logLine: aString , ' (' , aKey printString , '=' , aBoolean printString
				, ')'
]

{ #category : #logging }
APartRecordingClient >> loggedKeysFrom: aDictionary [

	isLogging ifFalse: [^#()].
	keysToLog isEmpty ifTrue: [^aDictionary keys].
	^keysToLog select: [:k | aDictionary includesKey: k]
]

{ #category : #accessing }
APartRecordingClient >> loggingStream [
	^ loggingStream
]

{ #category : #accessing }
APartRecordingClient >> loggingStream: anObject [
	loggingStream := anObject
]

{ #category : #private }
APartRecordingClient >> privateEndRecording [

	self hasRecordings
		ifTrue: 
			[self processRecordedInteractions.
			self finalizeRecordings]
]

{ #category : #private }
APartRecordingClient >> privateStartRecording [

	self initializeRecordedInteractions
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> processRecordedInteractions [

	<ignoreForCoverage>
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> recordActionBeginFor: anAction [

	self subclassResponsibility
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> recordActionEndFor: anAction with: aValue part: aPart [

	self subclassResponsibility
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> recordFinishedClosing [

	self subclassResponsibility
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> recordPromptResult: aPromptResult [

	self subclassResponsibility
]

{ #category : #'Subclass responsibility' }
APartRecordingClient >> recordValueChangeAt: anAspectKey value: aValue [

	self subclassResponsibility
]

{ #category : #logging }
APartRecordingClient >> startLogging [

	isLogging := true.
	self logLine: 'Start logging recording client #'
				, (partInterface part key ifNil: [partInterface part class name])
]
