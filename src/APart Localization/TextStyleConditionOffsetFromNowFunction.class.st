Class {
	#name : #TextStyleConditionOffsetFromNowFunction,
	#superclass : #TextStyleConditionBinaryFunction,
	#category : #'APart Localization'
}

{ #category : #evaluating }
TextStyleConditionOffsetFromNowFunction >> value: anObject [

	| aNumber duration |
	aNumber := right value: anObject.

	duration := left value: aNumber.

	^ self value: duration value: aNumber
]

{ #category : #evaluating }
TextStyleConditionOffsetFromNowFunction >> value: aDuration value: aNumber [

	^ DateAndTime now + aDuration
]
