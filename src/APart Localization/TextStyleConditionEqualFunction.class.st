Class {
	#name : #TextStyleConditionEqualFunction,
	#superclass : #TextStyleConditionBinaryFunction,
	#category : #'APart Localization'
}

{ #category : #evaluating }
TextStyleConditionEqualFunction >> value: anArg value: anotherArg [

	^ anArg = anotherArg
]
