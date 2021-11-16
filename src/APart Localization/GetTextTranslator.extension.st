Extension { #name : #GetTextTranslator }

{ #category : #'*APart Localization' }
GetTextTranslator class >> aPartTranslate: aString for: localeId [ 

	^ (self availableForLocaleID: localeId)
		 translate: aString inDomain: 'APart'.
]
