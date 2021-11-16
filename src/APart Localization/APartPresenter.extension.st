Extension { #name : #APartPresenter }

{ #category : #'*APart Localization' }
APartPresenter >> aPartTranslate: aString [ 

	^ GetTextTranslator aPartTranslate: aString for: self localeID

]

{ #category : #'*APart Localization' }
APartPresenter >> aPartTranslateDynamic: aString [ 

	^ (GetTextTranslator availableForLocaleID: self localeID)
		 translate: aString inDomain: 'APart'.
]

{ #category : #'*APart Localization' }
APartPresenter >> locale [ 

	^ self partInterface locale ifNil: [ self application locale ]
]

{ #category : #'*APart Localization' }
APartPresenter >> localeID [ 

	^ self locale localeID
]
