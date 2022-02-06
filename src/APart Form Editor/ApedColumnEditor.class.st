Class {
	#name : #ApedColumnEditor,
	#superclass : #ApedAbstractEditor,
	#category : #'APart Form Editor-Columns'
}

{ #category : #specs }
ApedColumnEditor class >> aspectPairs [

	^ super aspectPairs, {
		#titleLabel -> #title.
		#expandableLabel -> #expandable.
		#widthLabel -> #width.
	}

]

{ #category : #specs }
ApedColumnEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#titleLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Title'), ':' ].
		#title -> [ aPresenter newTextInput ].
		#expandableLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Expandalbe'), ':' ].
		#expandable -> [ aPresenter newCheckBox ].
		#widthLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Width'), ':' ].
		#width -> [ aPresenter newNumberInput ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #specs }
ApedColumnEditor class >> defaultLayout [
	<spec>
	
	| grid frame | 
	
	grid := SpGridLayout new beRowNotHomogeneous. 

	self aspectPairs withIndexDo: [ :each :rowIndex|
		grid 
			add: each key at: 1@rowIndex;
			add: each value at: 2@rowIndex ].		
			
	frame := SpFrameLayout newLabel: 'Column'.
	frame add: grid.

	^ frame 
]
