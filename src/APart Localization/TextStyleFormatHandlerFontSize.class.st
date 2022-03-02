Class {
	#name : #TextStyleFormatHandlerFontSize,
	#superclass : #TextStyleFormatHandler,
	#category : #'APart Localization'
}

{ #category : #API }
TextStyleFormatHandlerFontSize >> interpretString: aString on: aText [

	| pointSize |
	pointSize := Number readFromString: aString.

	^ aText
		  addAttribute: (TextFontReference toFont:
					   (LogicalFont
						    familyName: 'Source Code Pro'
						    pointSize: pointSize));
		  yourself
]
