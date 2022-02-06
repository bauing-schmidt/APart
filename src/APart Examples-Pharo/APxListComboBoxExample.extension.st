Extension { #name : #APxListComboBoxExample }

{ #category : #'*APart Examples-Pharo' }
APxListComboBoxExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#numbersSelectionDisplay -> [ aPresenter newDropList 
			choicesSymbol: #numbersDisplayList;
			id: #numbersList ].
		#numbersListEnabled -> [ aPresenter newCheckBox label: 'List Enabled' ].
		#replaceList -> [  aPresenter newButton label: 'Replace List'   ].
		#selectNext -> [  aPresenter newButton label: 'Select Next'  ].
		#selectPrevious -> [ aPresenter newButton label: 'Select Prev.'  ].
		#numberToAdd -> [  aPresenter newNumberInput  ].
		#addNumberToList -> [  aPresenter newButton label: 'Add'   ].
		#removeSelection -> [ aPresenter newButton label: 'Remove Selection'   ].
		#renameSelection -> [ aPresenter newButton label: 'Rename Selection'   ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxListComboBoxExample class >> defaultLayout [
	<spec>

	^ SpBoxLayout newHorizontal
		borderWidth: 10;
		spacing: 10;
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				addLast: #numbersSelectionDisplay;
				addLast: (SpBoxLayout newHorizontal
					add: #selectPrevious;
					add: #selectNext;
					yourself);
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
