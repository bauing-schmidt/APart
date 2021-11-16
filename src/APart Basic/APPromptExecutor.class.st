"
APPromptExecutor ist die Basisklasse für alle Arten von PromptExecutor (d.h. für unterschiedliche Client-Typen).
Um spezifische Clients besser zu unterstützen, die das Dispatching der verschiedenen Prompt-Selektoren per #perform:with: durchführen, wird jeder Standard-Prompt-Selektor als subclassResponsibility implementiert. Wenn ein PromptExecutor jedoch #basicExecutePrompt: überschreibt (wie z.B. APUnitTestPromptExecutor), dann werden diese Implementationen nicht benötigt.
"
Class {
	#name : #APPromptExecutor,
	#superclass : #Object,
	#instVars : [
		'owner',
		'postOpenAction'
	],
	#category : #'APart Basic-Prompt'
}

{ #category : #API }
APPromptExecutor class >> clientTypes [

	self subclassResponsibility
]

{ #category : #'instance creation' }
APPromptExecutor class >> defaultForClientType: aClientType [

	| matches |
	matches := (self allSubclasses
				select: [:sc | sc clientTypes includes: aClientType])
					asSortedCollection: [:a :b | a clientTypes size <= b clientTypes size].
	matches isEmpty ifTrue: [^nil].
	^matches first on: nil
]

{ #category : #'instance creation' }
APPromptExecutor class >> on: aClient [

	^self new initOn: aClient
]

{ #category : #'API prompts' }
APPromptExecutor >> confirmEnumValue: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> confirmYesNo: aPromptPart [

	self subclassResponsibility
]

{ #category : #API }
APPromptExecutor >> executePromptForPart: aPromptPart synchronize: otherPromptExecutors [

	| result triggerKey |
	aPromptPart scopeUpdate.
	triggerKey := self perform: aPromptPart promptSelector with: aPromptPart.
	result := triggerKey notNil
				ifTrue: [aPromptPart partInterface executeTrigger: triggerKey].
	otherPromptExecutors do: 
			[:e |
			e
				noticeExecutionOfTrigger: triggerKey
				forPrompt: aPromptPart
				weight: (self weightForExecutingPrompt: aPromptPart)].
	^result
]

{ #category : #'initialize-release' }
APPromptExecutor >> initOn: aClient [

	owner := aClient.
	self initialize
]

{ #category : #'API prompts' }
APPromptExecutor >> multiChoice: aPromptPart [

	self subclassResponsibility
]

{ #category : #private }
APPromptExecutor >> noticeExecutionOfTrigger: triggerKey forPrompt: aPromptPart weight: anInteger [
	"Wird aufgerufen, wenn mehr als ein PromptExecutor für einen Prompt verfügbar waren, weil es mehr als einen gleichzeitig geöffneten Typ von Client gibt.
	Hier besteht die Gelegenheit, auf die Ausführung eines bestimmten triggerKeys zu reagieren (was eventuell für UnitTests interessant ist, die parallel
	zu einem GUI laufen). Dabei kann berücksichtigt werden, mit welchem Gewicht des Prompt-Executors der Prompt zuletzt aktiviert wurde.
	Daran kann ein UnitTest erkennen, ob er die Notification aktiv oder passiv erhält."
]

{ #category : #'API prompts' }
APPromptExecutor >> openModal: aPromptPart [

	self subclassResponsibility
]

{ #category : #API }
APPromptExecutor >> openNonModalClientFor: aPromptPart [
	"Wird nur für GUIs aufgerufen, default: Keine Aktion"
]

{ #category : #API }
APPromptExecutor >> owner [ 
	
	^ owner
]

{ #category : #accessing }
APPromptExecutor >> postOpenAction [ 
	
	^ postOpenAction
]

{ #category : #accessing }
APPromptExecutor >> postOpenAction: aBlock [

	"used for testing purposes of modal dialogs, enables to execute a code in context of the dialog"
	
	postOpenAction := aBlock
]

{ #category : #'API prompts' }
APPromptExecutor >> reportConfirmationYesNo: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> requestColorValue: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> requestExistingFilename: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> requestNewFilename: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> singleChoice: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> singleChoiceButtons: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> text: aPromptPart [

	self subclassResponsibility
]

{ #category : #'API prompts' }
APPromptExecutor >> warning: aPromptPart [

	self subclassResponsibility
]

{ #category : #API }
APPromptExecutor >> weightForExecutingPrompt: aPromptPart [

	^0
]
