Class {
	#name : #TextStyleConditionOrFunction,
	#superclass : #TextStyleConditionLogicFunction,
	#category : #'APart Localization'
}

{ #category : #evaluating }
TextStyleConditionOrFunction >> value: aBoolean value: anObject [

	^ aBoolean
		  ifTrue: [ true ]
		  ifFalse: [ right value: anObject ]
]
