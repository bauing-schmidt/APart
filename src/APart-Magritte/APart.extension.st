Extension { #name : #APart }

{ #category : #'*APart-Magritte' }
APart class >> editInGtk [

	| aDescription | 
	
	GtkEngine ensureRunning.
	aDescription := self basicNew  magritteDescription .
	APartDescriptionEditorPresenter open: aDescription inSpecBackend: #Gtk class: self.
	^ aDescription
]

{ #category : #'*APart-Magritte' }
APart class >> editInMorphic [

	| aDescription | 
	
	aDescription := self basicNew  magritteDescription .
	APartDescriptionEditorPresenter open: aDescription inSpecBackend: #Morphic class: self.
	^ aDescription
]
