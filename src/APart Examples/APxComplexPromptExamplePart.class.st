"
APxComplexPromptExamplePart ist der Ausgangs-Part für das Beispiel ""modaler Prompt"".

"
Class {
	#name : #APxComplexPromptExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'editorNormal',
		'firstName',
		'lastName'
	],
	#category : #'APart Examples-ComplexPrompt'
}

{ #category : #accessing }
APxComplexPromptExamplePart >> firstName [

	^firstName
]

{ #category : #accessing }
APxComplexPromptExamplePart >> firstName: anObject [

	firstName := anObject.
	self changedAspectValue: #firstName
]

{ #category : #'initialize-release' }
APxComplexPromptExamplePart >> initializeActions [

	partInterface description createAction: #editModal
		do: 
			[(APxComplexPromptSubEditorPart
				onPart: self
				key: #editorModal
				whenClosingDo: [:editor | self privateEndEdit: editor]) openClientPrompt].
	partInterface description createAction: #editNormal
		do: 
			[editorNormal := APxComplexPromptSubEditorPart
						onPart: self
						key: #editorNormal
						whenClosingDo: [self privateEndEdit: editorNormal].
			editorNormal openClient]
]

{ #category : #'initialize-release' }
APxComplexPromptExamplePart >> initializeValues [

	firstName := 'first'.
	lastName := 'last'.
	self disableAllAspects: #(#firstName #lastName)
]

{ #category : #accessing }
APxComplexPromptExamplePart >> lastName [

	^lastName
]

{ #category : #accessing }
APxComplexPromptExamplePart >> lastName: anObject [

	lastName := anObject.
	self changedAspectValue: #lastName
]

{ #category : #private }
APxComplexPromptExamplePart >> privateEndEdit: editor [

	editor result
		ifNotNil: 
			[:resultArray |
			self firstName: resultArray first.
			self lastName: resultArray last].
	editor isOpenAsPrompt ifFalse: [editorNormal := nil]
]
