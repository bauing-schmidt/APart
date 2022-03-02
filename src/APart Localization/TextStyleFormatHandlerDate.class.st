Class {
	#name : #TextStyleFormatHandlerDate,
	#superclass : #TextStyleFormatHandler,
	#category : #'APart Localization'
}

{ #category : #API }
TextStyleFormatHandlerDate >> interpretString: aString on: aDateAndTime [

	^ aDateAndTime format: aString
]
