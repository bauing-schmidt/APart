Extension { #name : #APxTreeExample }

{ #category : #'*APart Examples-Pharo' }
APxTreeExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		"#showOnlyGroups -> [ aPresenter newCheckBox label: 'Show Only Groups' ]."
		#groupsTree -> [ aPresenter newTreeTable ].
		#selectPrevious -> [ aPresenter newButton label: 'Select Previous'  ].
		#selectNext -> [  aPresenter newButton label: 'Select Next'  ].
		#replaceTree -> [  aPresenter newButton label: 'Replace Tree'   ].
		#removeSelection -> [  aPresenter newButton label: 'Remove Selection'   ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxTreeExample class >> defaultSpec [
	<spec>

	^ SpBoxLayout newHorizontal
		borderWidth: 10;
		spacing: 10;
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				add: #groupsTree;
				addLast: (SpBoxLayout newHorizontal
					add: #selectPrevious;
					add: #selectNext));
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				"addLast: #showOnlyGroups;"
				addLast: #replaceTree;
				addLast: #removeSelection);
		yourself.
					
]
