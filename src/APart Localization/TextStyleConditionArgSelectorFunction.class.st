Class {
	#name : #TextStyleConditionArgSelectorFunction,
	#superclass : #TextStyleConditionArgFunction,
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleConditionArgSelectorFunction >> value: anObject [

	^ anObject perform: argument trim asSymbol
]
