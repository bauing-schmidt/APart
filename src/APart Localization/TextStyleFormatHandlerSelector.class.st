Class {
	#name : #TextStyleFormatHandlerSelector,
	#superclass : #TextStyleFormatHandler,
	#category : #'APart Localization'
}

{ #category : #API }
TextStyleFormatHandlerSelector >> interpretString: aString on: anObject [

	^ anObject perform: aString allButFirst asSymbol
]
