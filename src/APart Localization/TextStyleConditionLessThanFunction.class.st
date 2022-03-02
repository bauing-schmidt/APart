Class {
	#name : #TextStyleConditionLessThanFunction,
	#superclass : #TextStyleConditionBinaryFunction,
	#category : #'APart Localization'
}

{ #category : #evaluating }
TextStyleConditionLessThanFunction >> value: anArg value: anotherArg [

	^ anArg < anotherArg
]
