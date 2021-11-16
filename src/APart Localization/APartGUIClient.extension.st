Extension { #name : #APartGUIClient }

{ #category : #'*APart Localization' }
APartGUIClient >> locale [

	^ locale ifNil: [ 
		owner ifNil: [ APartLocaleEnGB new ]
			ifNotNil: [ :anOwner | anOwner locale ] ]
	
]
