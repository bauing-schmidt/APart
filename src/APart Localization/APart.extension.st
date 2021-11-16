Extension { #name : #APart }

{ #category : #'*APart Localization' }
APart >> locale [ 

	^ self parentPart
		ifNotNil: [ :aParent | aParent locale ]
		ifNil: [ APartLocaleEnGB new ]
]
