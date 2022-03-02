Class {
	#name : #TextStyleConditionAndFunction,
	#superclass : #TextStyleConditionLogicFunction,
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionAndFunction >> value: aBoolean value: anObject [

	^ aBoolean
		  ifTrue: [ right value: anObject ]
		  ifFalse: [ false ]
]
