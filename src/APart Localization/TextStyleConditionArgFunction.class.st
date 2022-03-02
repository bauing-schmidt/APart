Class {
	#name : #TextStyleConditionArgFunction,
	#superclass : #TextStyleConditionFunction,
	#instVars : [
		'argument'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionArgFunction >> argument: anObject [

	argument := anObject
]

{ #category : #accessing }
TextStyleConditionArgFunction >> value: anObject [

	^ argument
]
