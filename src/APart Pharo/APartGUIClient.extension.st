Extension { #name : #APartGUIClient }

{ #category : #'*APart Pharo' }
APartGUIClient >> specApplication [
	^SpApplication new
		useBackend: backendToUse;
		yourself
]
