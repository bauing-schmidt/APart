"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxEnumerationAutoAspectExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-EnumerationAutoAspect'
}

{ #category : #API }
APxEnumerationAutoAspectExample class >> matchingPartClass [

	^APxEnumerationAutoAspectExamplePart
]
