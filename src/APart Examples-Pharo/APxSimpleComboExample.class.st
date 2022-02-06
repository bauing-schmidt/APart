Class {
	#name : #APxSimpleComboExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-Pharo'
}

{ #category : #'as yet unclassified' }
APxSimpleComboExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#numbersListEnabled -> [ aPresenter newCheckBox label: 'List Enabled' ].
		#numbersList -> [ aPresenter newDropList 
			aspectSymbol: #numbersSelectionDisplay;
			choicesSymbol: #numbersDisplayList;
			id: #numbersList ].
		#replaceList -> [  aPresenter newButton label: 'Replace List'   ].
		#selectNext -> [  aPresenter newButton label: 'Select Next'  ].
		#selectPrevious -> [ aPresenter newButton label: 'Select Prev.'  ].
		#numberToAdd -> [  aPresenter newTextInput  ].
		#addNumberToList -> [  aPresenter newButton label: 'Add'   ].
		#removeSelection -> [ aPresenter newButton label: 'Remove Selection'   ].
	 }.
]

{ #category : #'as yet unclassified' }
APxSimpleComboExample class >> defaultLayout [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.

	(self associatedPresentersFor: nil) keysDo: [ :aKey |
		aLayout add: aKey ].
		
	^ aLayout
]

{ #category : #API }
APxSimpleComboExample class >> matchingPartClass [

	^APxSimpleComboExamplePart
]
