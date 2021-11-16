"
APartHeadlessClient is the base class for all clients that work with one part without a GUI (for example in the context of UnitTests).
This class is also useful for generic handling of UseCaseRequests that occur during a UnitTest run. To do this, the part must trigger a focus request on the already opened client (#focusOrOpenClient). Immediately before this, the client must have passed a codeBlock via #focusBlock: which contains the test activities that should be executed in the client. As a result, the generic client replaces the inputs in a GUI that would be requested in normal operation of the UseCase in response to the request

-- 

APartHeadlessClient ist die Basisklasse für alle Clients, die ohne GUI mit einem Part zusammenarbeiten (z.B. im Rahmen von UnitTests).
Diese Klasse eignet sich aber auch für die generische Behandlung von UseCaseRequests, die während eines UnitTest-Ablaufs auftreten. Hierzu muss der Part einen Focus-Request auf den schon geöffneten Client auslösen (#focusOrOpenClient). Unmittelbar davor muss dem Client per #focusBlock: ein CodeBlock übergeben worden sein, der diejenigen Testaktivitäten enthält, die im Client ausgeführt werden sollen. Dadurch ersetzt der generische Client die Eingaben in einem GUI, die im Normalbetrieb des UseCase als Reaktion auf den Request angefordert würden.


"
Class {
	#name : #APartHeadlessClient,
	#superclass : #APartAbstractClient,
	#instVars : [
		'isOpen',
		'focusBlocks'
	],
	#category : #'APart Basic-Clients'
}

{ #category : #API }
APartHeadlessClient class >> clientTypes [

	^#(#Headless #UnitTest)
]

{ #category : #'interface opening' }
APartHeadlessClient class >> openOnPart: aPart [

	^self on: aPart partInterface
]

{ #category : #accessing }
APartHeadlessClient >> addFocusBlock: anObject [

	focusBlocks add: anObject
]

{ #category : #API }
APartHeadlessClient >> changedAspect: anAspectKey value: aValue in: anObject [
	"Notification for changing an aspect value"
	"DE:Notification für das Verändern eines Aspekt-Wertes"
]

{ #category : #'interface closing' }
APartHeadlessClient >> closeAndUnschedule [
	"Nothing to do here"
	"DE:Hier nichts zu tun"
]

{ #category : #private }
APartHeadlessClient >> createPromptExecutor [

	^APHeadlessPromptExecutor on: self
]

{ #category : #API }
APartHeadlessClient >> executeFocusBlock [

	focusBlocks notEmpty
		ifTrue: [focusBlocks removeFirst cull: partInterface part]
]

{ #category : #API }
APartHeadlessClient >> executingAction: anAction [
	"Notification for the start of an action. Here, a possible argument is ignored."
	"DE:Notification für den Beginn einer Aktion. Hierbei wird ein eventuelles Argument nicht beachtet."
]

{ #category : #announcements }
APartHeadlessClient >> handleDefaultAnnouncedState: anAnnouncedState [

	"do nothing"
]

{ #category : #API }
APartHeadlessClient >> hasFocusBlock [

	^focusBlocks notEmpty
]

{ #category : #'initialize-release' }
APartHeadlessClient >> initOn: aPartInterface [

	super initOn: aPartInterface.
	partInterface registerClient: self.
	isOpen := true.
]

{ #category : #'initialize-release' }
APartHeadlessClient >> initialize [

	super initialize.
	focusBlocks := OrderedCollection new
]

{ #category : #announcements }
APartHeadlessClient >> interfaceFocusRequest: anAnnouncement [ 

	anAnnouncement interface == partInterface ifFalse: [^self].
	self executeFocusBlock
]

{ #category : #announcements }
APartHeadlessClient >> interfaceFocusRequest: anAnnouncement from: anAnnouncer [

	anAnnouncement interface == partInterface ifFalse: [^self].
	self executeFocusBlock
]

{ #category : #accessing }
APartHeadlessClient >> isHeadlessClient [

	^true
]

{ #category : #API }
APartHeadlessClient >> isOpen [

	^isOpen
]
