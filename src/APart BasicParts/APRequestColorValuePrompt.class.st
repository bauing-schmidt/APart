"
APRequestColorValuePrompt selection of a color value.

"
Class {
	#name : #APRequestColorValuePrompt,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'value'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APRequestColorValuePrompt >> defaultPromptSelector [

	^#requestColorValue:
]

{ #category : #accessing }
APRequestColorValuePrompt >> value [

	^value
]

{ #category : #accessing }
APRequestColorValuePrompt >> value: anObject [

	value := anObject
]
