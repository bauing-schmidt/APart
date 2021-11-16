"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxTreeExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-Tree'
}

{ #category : #API }
APxTreeExample class >> matchingPartClass [

	^APxTreeExamplePart
]
