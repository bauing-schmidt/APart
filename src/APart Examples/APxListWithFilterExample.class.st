"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxListWithFilterExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-ListWithFilter'
}

{ #category : #API }
APxListWithFilterExample class >> matchingPartClass [

	^APxListWithFilterExamplePart
]
