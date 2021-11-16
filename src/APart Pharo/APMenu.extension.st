Extension { #name : #APMenu }

{ #category : #'*APart Pharo' }
APMenu >> asSpecMenuIn: application [

	| spMenu | 
	
	spMenu := SpMenuPresenter newApplication: application.

	spMenu
		addGroup: [ :group | 
			self items do: [ :menuItem |
				spMenu addItem: [ :specItem | menuItem setSpecMenuItem: specItem ] ] ].
		
	^ spMenu
	
]
