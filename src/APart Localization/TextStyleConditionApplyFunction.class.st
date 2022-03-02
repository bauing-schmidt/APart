Class {
	#name : #TextStyleConditionApplyFunction,
	#superclass : #TextStyleConditionBinaryFunction,
	#category : #'APart Localization'
}

{ #category : #evaluating }
TextStyleConditionApplyFunction >> value: anObject value: aSelector [

	^ anObject perform: aSelector trim asSymbol
]
