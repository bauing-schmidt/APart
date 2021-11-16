"
APartGenericListener is a recording client that allows configurable responses to aspect changes, state changes as well as and performed actions. See protocol initialize / release

-

APartGenericListener ist ein RecordingClient, der konfigurierbare Reaktionen auf Aspect-Änderungen, State-Änderungen sowie auf durchgeführte Actions ermöglicht. Siehe Protokoll initialize/release
"
Class {
	#name : #APartGenericListener,
	#superclass : #APartRecordingClient,
	#instVars : [
		'interestingAspectKeys',
		'interestingStateKeys',
		'interestingActionKeys'
	],
	#category : #'APart Basic-Clients'
}

{ #category : #API }
APartGenericListener >> cloneOnSubInterface: anInterface [

	| clone |
	clone := self class on: anInterface.
	interestingAspectKeys
		keysAndValuesDo: [:k :block | clone onChangeOfAspects: (Array with: k) do: block].
	interestingActionKeys
		keysAndValuesDo: [:k :block | clone onActionsExecuted: (Array with: k) do: block].
	interestingStateKeys
		keysAndValuesDo: [:k :block | clone onChangeOfStates: (Array with: k) do: block].
	^clone
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> finalizeRecordings [

	<ignoreForCoverage>
	"this method should be never reached because this recording client does not store recordings"
]

{ #category : #API }
APartGenericListener >> finishRecordingPromptUnder: aParentInterface [

	<ignoreForCoverage>
]

{ #category : #announcements }
APartGenericListener >> handleDefaultAnnouncedState: anAnnouncedState [

	| oldState |
	oldState := announcedStates at: anAnnouncedState key ifAbsent: [].
	super handleDefaultAnnouncedState: anAnnouncedState.
	interestingStateKeys at: anAnnouncedState key
		ifPresent: [:stateListener | stateListener value: anAnnouncedState value: oldState]
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> hasRecordings [

	^false
]

{ #category : #'initialize-release' }
APartGenericListener >> initOn: aPartInterface [

	interestingAspectKeys := Dictionary new.
	interestingStateKeys := Dictionary new.
	interestingActionKeys := Dictionary new.
	super initOn: aPartInterface
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> initializeRecordedInteractions [
]

{ #category : #accessing }
APartGenericListener >> interestingActionKeys [

	^interestingActionKeys
]

{ #category : #accessing }
APartGenericListener >> interestingAspectKeys [

	^interestingAspectKeys
]

{ #category : #accessing }
APartGenericListener >> interestingStateKeys [

	^interestingStateKeys
]

{ #category : #'initialize-release' }
APartGenericListener >> onActionsExecuted: actionKeys do: aThreeArgsBlock [
	"arg1: actionKey, arg2: actionArg/nil, arg3: executing part"

	actionKeys do: [:k | interestingActionKeys at: k put: aThreeArgsBlock]
]

{ #category : #'initialize-release' }
APartGenericListener >> onChangeOfAspects: aspectKeys do: aTwoArgsBlock [
	"arg1: aspectKey, arg2: aspectValue"

	aspectKeys do: [:k | interestingAspectKeys at: k put: aTwoArgsBlock]
]

{ #category : #'initialize-release' }
APartGenericListener >> onChangeOfStates: stateKeys do: aTwoArgsBlock [
	"arg1: newAnnouncedState, arg2: oldAnnouncedState"

	stateKeys do: [:k | interestingStateKeys at: k put: aTwoArgsBlock]
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> openModalUnder: aParentClient [

	<ignoreForCoverage>
	self error: 'Should not be called'
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> recordActionBeginFor: anAction [
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> recordActionEndFor: anAction with: aValue part: aPart [

	interestingActionKeys at: anAction key
		ifPresent: 
			[:actionListener |
			actionListener
				value: anAction key
				value: aValue
				value: aPart]
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> recordFinishedClosing [
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> recordPromptResult: aPromptResult [

	<ignoreForCoverage>
]

{ #category : #'Subclass responsibility' }
APartGenericListener >> recordValueChangeAt: anAspectKey value: aValue [

	interestingAspectKeys at: anAspectKey
		ifPresent: [:aspectListener | aspectListener value: anAspectKey value: aValue]
]
