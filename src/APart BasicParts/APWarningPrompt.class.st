"
APWarningPrompt ist ein Prompt zur Anzeige eines Textes ohne Möglichkeit der Verzweigung.

"
Class {
	#name : #APWarningPrompt,
	#superclass : #APartSimplePrompt,
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APWarningPrompt >> defaultPromptSelector [

	^#warning:
]
