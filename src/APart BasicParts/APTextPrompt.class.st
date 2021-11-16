"
APTextPrompt ermöglicht die Eingabe eines Textes per Prompt. Es wird unterschiedlich fortgesetzt abhängig davon, ob die Eingabe erfolgt ist oder nicht.
"
Class {
	#name : #APTextPrompt,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'value'
	],
	#category : #'APart BasicParts'
}

{ #category : #private }
APTextPrompt >> conditionForCancel [

	^APCondition true
]

{ #category : #private }
APTextPrompt >> conditionForOK [

	^APCondition true
]

{ #category : #'initialize-release' }
APTextPrompt >> defaultPromptSelector [

	^#text:
]

{ #category : #'initialize-release' }
APTextPrompt >> initializeActions [

	partInterface description
		createAction: #confirmOk
		do: []
		if: self conditionForOK
		helpText: #Ok.
	partInterface description
		createAction: #confirmCancel
		do: []
		if: self conditionForCancel
		helpText: #Cancel
]

{ #category : #accessing }
APTextPrompt >> value [

	^value
]

{ #category : #accessing }
APTextPrompt >> value: anObject [

	value := anObject
]
