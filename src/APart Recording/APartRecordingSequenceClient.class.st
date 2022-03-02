"
APartRecordingSequenceClient is a recording client that collects the received interaction events sequentially.

--

APartRecordingSequenceClient ist ein RecordingClient, der die erhaltenen Interaktionsereignisse sequenziell aufsammelt.
"
Class {
	#name : #APartRecordingSequenceClient,
	#superclass : #APartRecordingClient,
	#instVars : [
		'interactionSequence'
	],
	#category : #'APart Recording'
}

{ #category : #API }
APartRecordingSequenceClient >> allLastInteractions [

	interactionSequence size = 0 ifTrue: [^#()].
	^interactionSequence last allLastInteractions
]

{ #category : #private }
APartRecordingSequenceClient >> argumentValueFrom: actionArgs forRecordingAction: anAction inPart: anObject [

	^actionArgs notEmpty ifTrue: [actionArgs first]
]

{ #category : #API }
APartRecordingSequenceClient >> cloneOnSubInterface: anInterface [

	^(self class on: anInterface)
		isRecording: isRecording;
		yourself
]

{ #category : #API }
APartRecordingSequenceClient >> executedAction: anAction with: actionArgs for: aPart [

	| actionToCompare |
	actionToCompare := isRecording ifTrue: [interactionSequence last value].
	super executedAction: anAction with: actionArgs for: aPart.
	isRecording
		ifTrue: 
			[anAction == actionToCompare
				ifTrue: [hasReceivedShutdown ifTrue: [self recordFinishedClosing]]]
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> finalizeRecordings [

	interactionSequence := nil
]

{ #category : #API }
APartRecordingSequenceClient >> finishRecordingPromptUnder: aParentInterface [
	"Do not go through for subclients if there are no interactions. On the top level, on the other hand, something is printed even if the interactions are empty."
	"DE:Für Sub-Clients nicht durchlaufen, wenn keine Interactions vorhanden sind. Auf oberster Ebene wird hingegen auch dann etwas gedruckt, wenn die Interactions leer sind."
	

	interactionSequence size > 0 ifTrue: [self processRecordedInteractions]
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> hasRecordings [

	^interactionSequence isEmptyOrNil not
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> initializeRecordedInteractions [

	interactionSequence := OrderedCollection new
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> privateRecordInteraction: anInteraction [

	isRecording ifFalse: [^nil].
	(interactionSequence isEmpty
		or: [(interactionSequence last addSubInteraction: anInteraction) isNil])
			ifTrue: [interactionSequence add: anInteraction].
	^anInteraction
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> privateRecordValue: newValue forInteractionMatching: matchBlock [
	"In order to handle nested recordings better, it is generally searched from the back to the front"
	"DE:Um mit verschachtelten Recordings besser umgehen zu können, wird generell von hinten nach vorn gesucht"

	isRecording ifFalse: [^nil].
	interactionSequence size to: 1
		by: -1
		do: 
			[:i |
			| ia |
			ia := interactionSequence at: i.
			(ia matchYourselfOrSubInteractions: matchBlock)
				ifNotNil: 
					[:matchingIA |
					matchingIA value: newValue.
					^matchingIA]].
	"Sollte nicht auftreten"
	^nil
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> recordActionBeginFor: anAction [

	^self privateRecordInteraction: ((anAction createRecordedInteraction)
				isOpenForSubs: true;
				yourself)
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> recordActionEndFor: anAction with: actionArgs part: aPart [

	interactionSequence notEmpty
		ifTrue: 
			[| lastIA |
			lastIA := interactionSequence last.
			lastIA assignEndAction: anAction
				value: (self
						argumentValueFrom: actionArgs
						forRecordingAction: anAction
						inPart: aPart).
			(lastIA type = #trigger and: [lastIA value isNil])
				ifTrue: 
					["Kein recording-tauglicher Operator gefunden. Falls dieser jedoch Sub-Interactions hat, muss er aufbewahrt werden.
					Beispiel: Prompt mit Resultat bei #requestSelectionChanged"
					lastIA subInteractionsOrNil size = 0
						ifTrue: 
							[interactionSequence removeLast.
							^nil].
					^lastIA].
			^lastIA].
	"Sollte normalerweise nicht auftreten"
	^nil
]

{ #category : #API }
APartRecordingSequenceClient >> recordCalledSubInteractions: subInteractions [

	interactionSequence last lastOpenInteraction
		recordCalledSubInteractions: subInteractions
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> recordFinishedClosing [

	isRecording ifTrue: [self isRecording: false]
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> recordPromptResult: aPromptResult [
	"In the previously recorded call, the result is subsequently set"
	"DE:Im zuvor erfassten Call wird nachträglich das Resultat gesetzt"

	^self privateRecordValue: aPromptResult
		forInteractionMatching: 
			[:ia |
			ia isPromptCall and: [ia key = aPromptResult promptKey]]
]

{ #category : #'Subclass responsibility' }
APartRecordingSequenceClient >> recordValueChangeAt: anAspectKey value: aValue [

	^self privateRecordInteraction: ((APRecordedInteraction valueChange)
				key: anAspectKey;
				value: aValue;
				yourself)
]
