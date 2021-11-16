"
A presenter with grid layout with a label and presenter on each row. Defined by `aspectPairs`
"
Class {
	#name : #ApedPresenterEditor,
	#superclass : #ApedAbstractEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedPresenterEditor class >> defaultSpec [
	<spec>
	
	| vertical grid frame | 
	
	grid := SpGridLayout new beRowNotHomogeneous. 

	self aspectPairs withIndexDo: [ :each :rowIndex|
		grid 
			add: each key at: 1@rowIndex;
			add: each value at: 2@rowIndex ].		
	
	vertical := SpBoxLayout newVertical.
	vertical 
		add: grid;
		add: (SpBoxLayout newHorizontal 
			borderWidth: 10;
			spacing: 10;
			add: #reset withConstraints: [:c | c expand: true; fill: true ])  withConstraints: [:c | c expand: false; fill: false ].
	
	frame := SpFrameLayout newLabel: 'Presenter'.
	frame add: vertical.
	
	^ frame 
]

{ #category : #API }
ApedPresenterEditor class >> matchingPartClasses [

	^ { ApedPresenterPart }
]
