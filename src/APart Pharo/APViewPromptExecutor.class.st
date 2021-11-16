"
APViewPromptExecutor implementiert Prompts auf Basis von View-Clients.
"
Class {
	#name : #APViewPromptExecutor,
	#superclass : #APPromptExecutor,
	#category : #'APart Pharo'
}

{ #category : #API }
APViewPromptExecutor class >> clientTypes [

	^#(#GUI)
]

{ #category : #'API prompts' }
APViewPromptExecutor >> confirmEnumValue: aPromptPart [

	^((APartDialog for: owner)
		choose: aPromptPart message
		fromLabels: aPromptPart genericEnumeration texts
		values: aPromptPart genericEnumeration keys
		sorted: false
		wLabel: aPromptPart title)
			ifNotNil: 
				[:v |
				aPromptPart value: v.
				#confirmChoice]
			ifNil: [#cancelChoice]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> confirmSaveAll: aPromptPart [

	aPromptPart value: ((APartDialog for: owner)
				chooseReport: aPromptPart report
				labels: { 
					aPromptPart labelSave. 
					aPromptPart labelSaveAll.
					aPromptPart labelNotSave. 
					aPromptPart labelNotSaveAll. 
					aPromptPart labelCancel }
				values: #(#save #saveAll notSave notSaveAll cancel)
				default: #save
				wLabel: aPromptPart title 
				for: self ownerWindow).
	^aPromptPart value ifNotNil: [#continueOk] ifNil: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> confirmWithButtons: aPromptPart [

	aPromptPart value: ((APartDialog for: owner)
				chooseReport: aPromptPart report
				labels: aPromptPart labels
				values: aPromptPart keys
				default: aPromptPart keys first
				wLabel: aPromptPart title 
				for: self ownerWindow).
	^aPromptPart value ifNotNil: [#continueOk] ifNil: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> confirmYesNo: aPromptPart [

	^((APartDialog for: owner)
		questionYesNo: aPromptPart message
		wLabel: aPromptPart title
		labelYes: aPromptPart labelYes
		labelNo: aPromptPart labelNo) = #yes
		ifTrue: [#confirmYes]
		ifFalse: [#confirmNo]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> error: aPromptPart [

	(APartDialog for: owner) errorMessage: aPromptPart message wLabel: aPromptPart title.
	^#continueOk
]

{ #category : #'API prompts' }
APViewPromptExecutor >> multiChoice: aPromptPart [

	aPromptPart selectedValues: ((APartDialog for: owner)
				chooseMany: aPromptPart message
				fromLabels: aPromptPart labels
				values: aPromptPart values
				sorted: aPromptPart sortLabels
				wLabel: aPromptPart title).
	^aPromptPart selectedValues ifNotNil: [#continueOk] ifNil: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> multilineText: aPromptPart [

	aPromptPart value: ((APartDialog for: owner)
				requestMultiline: aPromptPart message
				initialAnswer: aPromptPart value
				wLabel: aPromptPart title).
	^aPromptPart value notNil ifTrue: [#continueOk] ifFalse: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> openModal: aPromptPart [
	"clientClasses enthält im Fall von registrierten GUIs nicht die generische Klasse APartGUIClient, sondern direkt die ApplicationModel-Subklasse."

	| clientClasses |
	clientClasses := aPromptPart clientRegistry
				findClientClassesForPart: aPromptPart.
	clientClasses := clientClasses
				select: [:cl | cl clientTypes includes: #GUI].
	clientClasses size = 1
		ifFalse: 
			[self
				error: 'Expected exactly 1 client class instead of '
						, clientClasses size printString , ' for '
						, aPromptPart].
	clientClasses any openModalOnPart: aPromptPart parentClient: owner.
	^aPromptPart result ifNotNil: [aPromptPart promptClosingTriggerKey]
]

{ #category : #API }
APViewPromptExecutor >> openNonModalClientFor: aPromptPart [

	(aPromptPart clientRegistry findClientClassesWithTypesForPart: aPromptPart)
		at: #GUI
		ifPresent: [:guiClientClass | guiClientClass openOnPart: aPromptPart]
]

{ #category : #private }
APViewPromptExecutor >> ownerWindow [
	
	^owner
		ifNotNil: [:o | o ownerDo: [:gui | APartPlatform current ownerWindowOf: gui ]].
]

{ #category : #'API prompts' }
APViewPromptExecutor >> reportConfirmationYesNo: aPromptPart [

	aPromptPart value: ((APartDialog for: owner)
				chooseReport: aPromptPart report
				labels: (Array with: aPromptPart labelYes with: aPromptPart labelNo)
				values: (Array with: #confirmYes with: #confirmNo)
				default: #confirmNo
				wLabel: aPromptPart title 
				for: self ownerWindow).
	^aPromptPart value ifNotNil: [#continueOk] ifNil: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> requestColorValue: aPromptPart [

	^ APartPlatform current requestColorValue: aPromptPart
]

{ #category : #'API prompts' }
APViewPromptExecutor >> requestExistingFilename: aPromptPart [

"	^ APartPlatform current requestNewFilename: aPromptPart
"	

	aPromptPart value: (self owner application selectExistingFileFrom: aPromptPart).

	^aPromptPart value = ''
		ifTrue: 
			[aPromptPart value: nil.
			#fileSelectionCancelled]
		ifFalse: [#fileSelected]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> requestNewFilename: aPromptPart [

	"	^ APartPlatform current requestNewFilename: aPromptPart
"

	aPromptPart value:
		(self owner application selectNewFileFrom: aPromptPart).

	^ aPromptPart value = ''
		  ifTrue: [ 
			  aPromptPart value: nil.
			  #fileSelectionCancelled ]
		  ifFalse: [ #fileSelected ]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> singleChoice: aPromptPart [

	aPromptPart selectedValues: ((APartDialog for: owner)
				choose: aPromptPart message
				fromLabels: aPromptPart labels
				values: aPromptPart values
				sorted: aPromptPart sortLabels
				wLabel: ((aPromptPart title ifNil: [ '' ]) translateFor: self owner locale)).
	^aPromptPart selectedValues ifNotNil: [#continueOk] ifNil: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> singleChoiceButtons: aPromptPart [
	aPromptPart selectedValues: ((APartDialog for: owner)
				multipleChoice: aPromptPart message
				labels: aPromptPart labels
				values: aPromptPart values
				default: nil).
	^aPromptPart selectedValues ifNotNil: [#continueOk] ifNil: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> text: aPromptPart [

	aPromptPart value: ((APartDialog for: owner)
				request: aPromptPart message
				initialAnswer: aPromptPart value
				wLabel: aPromptPart title).
	^aPromptPart value notNil ifTrue: [#continueOk] ifFalse: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> textMultiline: aPromptPart [

	aPromptPart value: ((APartDialog for: owner)
				requestMultiline: aPromptPart message
				initialAnswer: aPromptPart value
				wLabel: aPromptPart title).
	^aPromptPart value notNil ifTrue: [#continueOk] ifFalse: [#continueCancel]
]

{ #category : #'API prompts' }
APViewPromptExecutor >> warning: aPromptPart [

	(APartDialog for: owner) message: aPromptPart message wLabel: aPromptPart title.
	^#continueOk
]

{ #category : #API }
APViewPromptExecutor >> weightForExecutingPrompt: aPromptPart [

	^1
]
