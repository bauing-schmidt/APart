"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxEnablementExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-Enablement'
}

{ #category : #API }
APxEnablementExample class >> matchingPartClass [

	^APxEnablementExamplePart
]
