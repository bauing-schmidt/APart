"
APSingleChoicePrompt allows easy selection from a list.

--

DE:APSingleChoicePrompt erlaubt die Einfachselektion aus einer Liste.
"
Class {
	#name : #APSingleChoicePrompt,
	#superclass : #APMultiChoicePrompt,
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APSingleChoicePrompt >> defaultPromptSelector [

	^#singleChoice:
]

{ #category : #accessing }
APSingleChoicePrompt >> selectedValue [
	"Reuse superclass slot, but use better name"
	
	^ selectedValues
]
