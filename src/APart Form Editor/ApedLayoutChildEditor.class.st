"
I define a form for properties of children of a general layout
"
Class {
	#name : #ApedLayoutChildEditor,
	#superclass : #ApedAbstractEditor,
	#category : #'APart Form Editor-Layout Child Editors'
}

{ #category : #specs }
ApedLayoutChildEditor class >> defaultSpec [
	<spec>
	
	| grid frame | 
	
	grid := SpGridLayout new beRowNotHomogeneous. 

	self aspectPairs withIndexDo: [ :each :rowIndex|
		grid 
			add: each key at: 1@rowIndex;
			add: each value at: 2@rowIndex ].		
	
	frame := SpFrameLayout newLabel: 'Layout child properties'.
	frame add: grid.

	^ frame 
]

{ #category : #API }
ApedLayoutChildEditor class >> matchingPartClass [

	^ApedLayoutChildPart
]
