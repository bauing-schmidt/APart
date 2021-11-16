"
APxComplexPromptSubEditorPart ist ein PromptPart als Beispiel für einen Editor.
"
Class {
	#name : #APxComplexPromptSubEditorPart,
	#superclass : #APart,
	#instVars : [
		'firstName',
		'lastName',
		'result'
	],
	#category : #'APart Examples-ComplexPrompt'
}

{ #category : #'Example API' }
APxComplexPromptSubEditorPart class >> canStartStandalone [

	^false
]

{ #category : #'initialize-release' }
APxComplexPromptSubEditorPart >> defineAspects [

	partInterface description createAllAspectsNamed: #(#firstName #lastName)
]

{ #category : #'Exposed values' }
APxComplexPromptSubEditorPart >> firstName [

	^firstName
]

{ #category : #'Exposed values' }
APxComplexPromptSubEditorPart >> firstName: anObject [

	firstName := anObject.
	self changedAspectValue: #firstName
]

{ #category : #private }
APxComplexPromptSubEditorPart >> hasChanges [

	^firstName ~= parentPart firstName or: [lastName ~= parentPart lastName]
]

{ #category : #'initialize-release' }
APxComplexPromptSubEditorPart >> initializeActions [

	partInterface description
		createAction: #clearFirstName
			do: [self firstName: nil]
			if: (APCondition on: [firstName size > 0] ifNot: #FieldIsEmpty)
			helpText: #ClearField;
		createAction: #clearLastName
			do: [self lastName: nil]
			if: (APCondition on: [lastName size > 0] ifNot: #FieldIsEmpty)
			helpText: #ClearField;
		createAction: #cancelEdit
			do: [partInterface closePart]
			if: APCondition true
			helpText: #unused;
		createAction: #saveData
			do: [partInterface requestForPartClose]
			if: (APCondition on: [firstName size > 0] ifNot: #MissingFirstName)
					& (APCondition on: [lastName size > 0] ifNot: #MissingLastName)
						& (APCondition on: [self hasChanges] ifNot: #NoChanges).
	self trigger: #requestForClose
		do: 
			[self hasChanges
				ifTrue: 
					[(APConfirmationYesNo onPart: self)
						title: #FrageDatenSpeichern;
						message: #FrageDatenSpeichern;
						trigger: #confirmYes do: [result := Array with: firstName with: lastName];
						trigger: #confirmNo do: [result := nil];
						openClientPrompt].
			true]
]

{ #category : #'initialize-release' }
APxComplexPromptSubEditorPart >> initializeValues [

	result := nil.
	firstName := parentPart firstName.
	lastName := parentPart lastName.
]

{ #category : #'API testing' }
APxComplexPromptSubEditorPart >> isPromptable [

	^true
]

{ #category : #'Exposed values' }
APxComplexPromptSubEditorPart >> lastName [

	^lastName
]

{ #category : #'Exposed values' }
APxComplexPromptSubEditorPart >> lastName: anObject [

	lastName := anObject.
	self changedAspectValue: #lastName
]

{ #category : #API }
APxComplexPromptSubEditorPart >> result [

	^result
]
