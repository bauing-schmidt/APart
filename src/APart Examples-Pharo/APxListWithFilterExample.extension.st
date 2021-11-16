Extension { #name : #APxListWithFilterExample }

{ #category : #'*APart Examples-Pharo' }
APxListWithFilterExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#personList -> [ aPresenter newList ].
		#selectPrevious -> [ aPresenter newButton label: 'Select Prev.' ].
		#selectNext -> [ aPresenter newButton label: 'Select Next' ].
		#isFilterEnabled -> [ aPresenter newCheckBox label: 'Use filter' ].
		#isSortByFirstName -> [ aPresenter newCheckBox label: 'Sort by first name' ].
		#filterName -> [ aPresenter newTextInput ].
		#filterFirstName -> [ aPresenter newTextInput ].

		#labelFilterName -> [ aPresenter newLabel label: 'Filter name'].
		#labelFilterFirstName -> [ aPresenter newLabel label: 'Filter first name'].
	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxListWithFilterExample class >> defaultSpec [
	<spec>

	^ SpBoxLayout newHorizontal
		borderWidth: 10;
		spacing: 10;
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				add: #personList;
				addLast: (SpBoxLayout newHorizontal
					add: #selectPrevious;
					add: #selectNext;
					yourself);
				yourself);
		add: (
			SpGridLayout new
				add: #isFilterEnabled at: 1@1;
				add: #isSortByFirstName at: 2@1;
				add: #labelFilterName at: 1@2;
				add: #filterName at: 2@2;
				add: #labelFilterFirstName at: 1@3;
				add: #filterFirstName at: 2@3;
				yourself);
		yourself.
					
]

{ #category : #'*APart Examples-Pharo' }
APxListWithFilterExample >> initialExtent [
	^ (850@400) scaledByDisplayScaleFactor
]

{ #category : #'*APart Examples-Pharo' }
APxListWithFilterExample >> initializePresenters [
	super initializePresenter.
	(self presenterNamed: #filterName)
		whenTextChangedDo: [  ]
]
