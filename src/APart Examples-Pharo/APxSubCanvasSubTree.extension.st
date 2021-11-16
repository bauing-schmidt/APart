Extension { #name : #APxSubCanvasSubTree }

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasSubTree class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#selectionInTree -> [ aPresenter newTreeTable ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasSubTree class >> defaultSpec [
	<spec>
	^ SpBoxLayout newVertical
		add: #selectionInTree 
]
