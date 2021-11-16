"
APartRecordingUnitTestClient ist die Basisklasse für Clients, die zum Ablauf von UnitTests aufgebaut werden. Da er von RecordingClient erbt, kann er Interaktionen aufzeichnen und daraus Sourcecode für UnitTests erzeugen.
"
Class {
	#name : #APartRecordingUnitTestClient,
	#superclass : #APartRecordingSequenceClient,
	#instVars : [
		'testCase',
		'parentClient'
	],
	#category : #'APart Tests'
}

{ #category : #API }
APartRecordingUnitTestClient class >> clientTypes [

	^#(#UnitTest)
]

{ #category : #'instance creation' }
APartRecordingUnitTestClient class >> on: aPartInterface useTest: aTestCase [

	^(self on: aPartInterface)
		useTest: aTestCase;
		yourself
]

{ #category : #private }
APartRecordingUnitTestClient >> argumentValueFrom: actionArgs forRecordingAction: anAction inPart: aPart [

	anAction isTrigger
		ifFalse: 
			[^super
				argumentValueFrom: actionArgs
				forRecordingAction: anAction
				inPart: aPart].
	^SUTAPOperator createForTriggerAction: anAction part: aPart
]

{ #category : #API }
APartRecordingUnitTestClient >> cloneOnSubInterface: anInterface [

	isRecording ifFalse: [^nil].
	^(self class on: anInterface useTest: testCase)
		isRecording: true;
		parentClient: self;
		yourself
]

{ #category : #private }
APartRecordingUnitTestClient >> createPromptExecutor [

	^APUnitTestPromptExecutor on: self
]

{ #category : #private }
APartRecordingUnitTestClient >> finalizeRecordings [

	parentClient notNil ifTrue: [^self processRecordedInteractions].
	super finalizeRecordings.
	testCase finalizeRecordings
]

{ #category : #API }
APartRecordingUnitTestClient >> finishRecordingPromptUnder: aParentInterface [
	"Hier nichts zu tun"
]

{ #category : #announcements }
APartRecordingUnitTestClient >> handleSpecialAnnouncedStates: specialAnnouncedStatesOrNil [
	"Jetzt wurden alle Changes empfangen, und die neuen Zustände können bewertet werden.
	Für das Recording werden sie dem aktuellsten Interaction-Objekt (genauer: jeder letzten in der Hierarchie der subInteractions) zugeordnet, jedoch nur, 
	falls dieses noch keine States gesetzt hat.
	Hintergrund: Es gibt Changes, die mit Option suppressListeners übermittelt wurden. In diesem Fall erfolgt zwar ein rootUpdate, 
	es existiert jedoch noch keine neue Interaction."

	isRecording
		ifTrue: 
			[interactionSequence isEmpty
				ifTrue: 
					[parentClient isNil
						ifTrue: [interactionSequence add: testCase createStartInteraction]].
			self allLastInteractions
				do: [:lastIA | lastIA setExpectedStatesIfUndefinedFrom: announcedStates logger: self]]
]

{ #category : #'interface opening' }
APartRecordingUnitTestClient >> openModalUnder: aParentClient [

	self error: 'Yet unclear if this is needed'
]

{ #category : #accessing }
APartRecordingUnitTestClient >> parentClient [

	^parentClient
]

{ #category : #accessing }
APartRecordingUnitTestClient >> parentClient: anObject [

	parentClient := anObject
]

{ #category : #private }
APartRecordingUnitTestClient >> privateEndRecording [

	parentClient notNil ifTrue: [^self].
	super privateEndRecording
]

{ #category : #private }
APartRecordingUnitTestClient >> privateStartRecording [

	super privateStartRecording.
	testCase startPrintingCode
]

{ #category : #private }
APartRecordingUnitTestClient >> processRecordedInteractions [
	"Eintrag für #finishedClosing kann erst hier gesetzt werden, weil sonst das automatische Befüllen der expectedStates für die letzten Einträge nicht funktionieren würde."

	interactionSequence notNil
		ifTrue: 
			[self allLastInteractions
				do: [:lastIA | lastIA setExpectedStatesIfUndefinedFrom: announcedStates logger: self].
			interactionSequence add: (APRecordedInteraction special: #finishedClosing).
			testCase printCodeForInteractions: interactionSequence]
]

{ #category : #API }
APartRecordingUnitTestClient >> testCase [

	^testCase
]

{ #category : #'initialize-release' }
APartRecordingUnitTestClient >> useTest: aTestCase [

	testCase := aTestCase
]
