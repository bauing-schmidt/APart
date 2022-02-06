Extension { #name : #APxSubCanvasSubList }

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasSubList class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#selectionInList -> [ aPresenter newList ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasSubList class >> defaultLayout [
	<spec>
	^ SpBoxLayout newVertical
		add: #selectionInList 
]
