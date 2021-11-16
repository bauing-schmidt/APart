"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxListComboBoxExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-ListComboBox'
}

{ #category : #API }
APxListComboBoxExample class >> matchingPartClass [

	^APxListComboBoxExamplePart
]
