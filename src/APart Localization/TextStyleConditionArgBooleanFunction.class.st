Class {
	#name : #TextStyleConditionArgBooleanFunction,
	#superclass : #TextStyleConditionArgFunction,
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionArgBooleanFunction >> value: anObject [

	^ argument = 'true'
]
