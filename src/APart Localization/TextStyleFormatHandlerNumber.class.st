Class {
	#name : #TextStyleFormatHandlerNumber,
	#superclass : #TextStyleFormatHandler,
	#category : #'APart Localization'
}

{ #category : #API }
TextStyleFormatHandlerNumber >> interpretString: aString on: anObject [

	^ Number readFromString: aString
]
