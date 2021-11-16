"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxMultiSelectionTreeExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-MultiSelectionTree'
}

{ #category : #API }
APxMultiSelectionTreeExample class >> matchingPartClass [

	^APxMultiSelectionTreeExamplePart
]
