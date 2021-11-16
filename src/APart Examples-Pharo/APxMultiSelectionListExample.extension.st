Extension { #name : #APxMultiSelectionListExample }

{ #category : #'*APart Examples-Pharo' }
APxMultiSelectionListExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#allNamesList -> [ aPresenter newList beMultipleSelection  ].
		#selectedNamesList -> [ aPresenter newList  ].
		#deselectAll -> [ aPresenter newButton label: 'DeselectAll'   ].
		
		#label1 -> [ aPresenter newLabel label: 'All Names (Multi Selection)'].
		#label2 -> [ aPresenter newLabel label: 'Selected Names' ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxMultiSelectionListExample class >> defaultSpec [
	<spec>
	
	^ SpBoxLayout newVertical
		  borderWidth: 10;
		  spacing: 10;
        add: (
            SpBoxLayout newHorizontal
					spacing: 10;
                add: (SpBoxLayout newVertical
                    add: #label1 expand: false fill: true padding: 0;
                    add: #allNamesList;
                    yourself);
                add: (SpBoxLayout newVertical
                    add: #label2 expand: false fill: true padding: 0;
                    add: #selectedNamesList; 
                    yourself);
                yourself);
        addLast: #deselectAll 
]
