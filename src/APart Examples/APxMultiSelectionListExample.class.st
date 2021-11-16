"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxMultiSelectionListExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-MultiSelectionList'
}

{ #category : #API }
APxMultiSelectionListExample class >> matchingPartClass [

	^APxMultiSelectionListExamplePart
]
