"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxListExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-ListExample'
}

{ #category : #API }
APxListExample class >> matchingPartClass [

	^APxListExamplePart
]
