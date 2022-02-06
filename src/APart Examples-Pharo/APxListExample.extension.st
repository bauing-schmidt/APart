Extension { #name : #APxListExample }

{ #category : #'*APart Examples-Pharo' }
APxListExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#numbersListEnabled -> [ aPresenter newCheckBox label: 'List Enabled' ].
		#numbersList -> [ aPresenter newList ].
		#replaceList -> [  aPresenter newButton label: 'Replace List'   ].
		#selectNext -> [  aPresenter newButton label: 'Select Next'  ].
		#selectPrevious -> [ aPresenter newButton label: 'Select Prev.'  ].
		#numberToAdd -> [ aPresenter newNumberInput  ].
		#addNumberToList -> [  aPresenter newButton label: 'Add'   ].
		#removeSelection -> [ aPresenter newButton label: 'Remove Selection'   ].
		#renameSelection -> [ aPresenter newButton label: 'Rename Selection'   ].
		#numbersSelectionDisplay -> [ aPresenter newDropList 
			choicesSymbol: #numbersDisplayList;
			id: #numbersList  ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxListExample class >> defaultLayout [
	<spec>

	^ SpBoxLayout newHorizontal
		borderWidth: 10;
		spacing: 10;
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				add: #numbersList;
				addLast: (SpBoxLayout newHorizontal
					add: #selectPrevious;
					add: #selectNext;
					yourself);
				addLast: #numbersSelectionDisplay;
				yourself);
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				addLast: #numbersListEnabled;
				addLast: #replaceList;
				addLast: (SpBoxLayout newHorizontal
					add: #numberToAdd;
					add: #addNumberToList;
					yourself);
				addLast: #removeSelection;
				addLast: #renameSelection;
				yourself);
		yourself.
					
]
