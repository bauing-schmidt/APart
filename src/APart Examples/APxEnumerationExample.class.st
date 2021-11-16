"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxEnumerationExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-EnumerationExample'
}

{ #category : #API }
APxEnumerationExample class >> matchingPartClass [

	^APxEnumerationExamplePart
]
