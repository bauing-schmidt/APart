Extension { #name : #APxSubCanvasPartSwitchExample }

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasPartSwitchExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#switchToNoView -> [ aPresenter newButton label: 'No View' ].
		#switchToTreeView -> [ aPresenter newButton label: 'Tree View' ].
		#switchToListView -> [ aPresenter newButton label: 'List View' ].
		#currentView -> [ aPresenter newSubcanvas ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxSubCanvasPartSwitchExample class >> defaultLayout [
	<spec>
		
	^  SpBoxLayout newVertical
		add: #switchToNoView;
		add: #switchToTreeView;
		add: #switchToListView;
		add: #currentView
]
