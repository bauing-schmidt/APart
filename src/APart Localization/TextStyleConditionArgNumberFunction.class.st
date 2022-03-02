Class {
	#name : #TextStyleConditionArgNumberFunction,
	#superclass : #TextStyleConditionArgFunction,
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionArgNumberFunction >> value: anObject [

	^ Number readFromString: argument
]
