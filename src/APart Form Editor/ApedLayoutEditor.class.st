"
I define form for editing of a general layout properties
"
Class {
	#name : #ApedLayoutEditor,
	#superclass : #ApedAbstractEditor,
	#category : #'APart Form Editor-Layout Editors'
}

{ #category : #specs }
ApedLayoutEditor class >> defaultLayout [
	<spec>
	
	| grid frame | 
	
	grid := SpGridLayout new beRowNotHomogeneous. 

	self aspectPairs withIndexDo: [ :each :rowIndex|
		grid 
			add: each key at: 1@rowIndex;
			add: each value at: 2@rowIndex ].		
			
	frame := SpFrameLayout newLabel: 'Layout'.
	frame add: grid.

	^ frame 
]

{ #category : #API }
ApedLayoutEditor class >> matchingPartClass [

	^ApedLayoutPart
]
