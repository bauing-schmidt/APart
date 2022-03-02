Class {
	#name : #TextStyleConditionBinaryFunction,
	#superclass : #TextStyleConditionFunction,
	#instVars : [
		'left',
		'right',
		'block'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionBinaryFunction >> left: anObject [

	left := anObject
]

{ #category : #accessing }
TextStyleConditionBinaryFunction >> right: anObject [

	right := anObject
]

{ #category : #accessing }
TextStyleConditionBinaryFunction >> value: anObject [

	^ self value: (left value: anObject) value: (right value: anObject)
]

{ #category : #evaluating }
TextStyleConditionBinaryFunction >> value: anArg value: anotherArg [

	self subclassResponsibility
]
