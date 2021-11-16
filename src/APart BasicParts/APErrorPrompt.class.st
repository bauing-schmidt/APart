Class {
	#name : #APErrorPrompt,
	#superclass : #APartSimplePrompt,
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APErrorPrompt >> defaultPromptSelector [

	^#error:
]
