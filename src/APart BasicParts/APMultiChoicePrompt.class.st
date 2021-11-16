"
APMultiChoicePrompt allows multiple selection from a list. For reasons of generic handling, the collection is held with the selected values in instance variable #value.

--

DE:APMultiChoicePrompt erlaubt die Mehrfachselektion aus einer Liste. Aus Gründen der generischen Handhabung wird die Collection mit den gewählten Werten in Instanzvariable value gehalten.
"
Class {
	#name : #APMultiChoicePrompt,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'labels',
		'values',
		'sortLabels',
		'selectedValues'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APMultiChoicePrompt >> defaultPromptSelector [

	^#multiChoice:
]

{ #category : #accessing }
APMultiChoicePrompt >> labels [

	^labels
]

{ #category : #accessing }
APMultiChoicePrompt >> labels: anObject [

	labels := anObject
]

{ #category : #accessing }
APMultiChoicePrompt >> selectedValues [
	^ selectedValues
]

{ #category : #accessing }
APMultiChoicePrompt >> selectedValues: anObject [
	selectedValues := anObject
]

{ #category : #accessing }
APMultiChoicePrompt >> sortLabels [

	^sortLabels == true
]

{ #category : #accessing }
APMultiChoicePrompt >> sortLabels: anObject [

	sortLabels := anObject
]

{ #category : #accessing }
APMultiChoicePrompt >> value [ self halt
]

{ #category : #accessing }
APMultiChoicePrompt >> value:blah [ self halt
]

{ #category : #accessing }
APMultiChoicePrompt >> values [

	^values
]

{ #category : #accessing }
APMultiChoicePrompt >> values: anObject [

	values := anObject
]
