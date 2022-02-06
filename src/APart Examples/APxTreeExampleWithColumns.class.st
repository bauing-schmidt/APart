Class {
	#name : #APxTreeExampleWithColumns,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-Tree with columns'
}

{ #category : #'as yet unclassified' }
APxTreeExampleWithColumns class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		"#showOnlyGroups -> [ aPresenter newCheckBox label: 'Show Only Groups' ]."
		#groupsTree -> [ aPresenter newTreeTable ].
		#selectPrevious -> [ aPresenter newButton label: 'Select Previous'  ].
		#selectNext -> [  aPresenter newButton label: 'Select Next'  ].
		#replaceTree -> [  aPresenter newButton label: 'Replace Tree'   ].
		#removeSelection -> [  aPresenter newButton label: 'Remove Selection'   ].
	 }.
]

{ #category : #'as yet unclassified' }
APxTreeExampleWithColumns class >> defaultLayout [
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

{ #category : #API }
APxTreeExampleWithColumns class >> matchingPartClass [

	^APxTreeExampleWithColumnsPart
]
