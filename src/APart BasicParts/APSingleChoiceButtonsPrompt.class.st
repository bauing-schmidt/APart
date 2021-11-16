"
APSingleChoiceButtonsPrompt allows easy selection from a list of buttons

--

DE:APSingleChoiceButtonsPrompt erlaubt die Einfachselektion aus einer Liste von Buttons
"
Class {
	#name : #APSingleChoiceButtonsPrompt,
	#superclass : #APSingleChoicePrompt,
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APSingleChoiceButtonsPrompt >> defaultPromptSelector [

	^#singleChoiceButtons:
]
