Class {
	#name : #TextStyleFormatHandlerFontColor,
	#superclass : #TextStyleFormatHandler,
	#category : #'APart Localization'
}

{ #category : #API }
TextStyleFormatHandlerFontColor >> interpretString: aString on: aText [

	| aColor |
	aColor := Color colorFrom: aString.

	^ aText
		  addAttribute: (TextColor new color: aColor);
		  yourself
]
