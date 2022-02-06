Extension { #name : #APxSubCanvasSubTree }

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasSubTree class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#selectionInTree -> [ aPresenter newTreeTable ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasSubTree class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		add: #selectionInTree 
]
