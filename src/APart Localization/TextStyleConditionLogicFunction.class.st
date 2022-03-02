Class {
	#name : #TextStyleConditionLogicFunction,
	#superclass : #TextStyleConditionBinaryFunction,
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionLogicFunction >> value: anObject [

	^ self value: (left value: anObject) value: anObject
]
