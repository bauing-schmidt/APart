"
Example views are not commented on themselves, but only their respective associated Part class (found in #matchingPartClass).

--

DE:Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxEnumerationComboBoxExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-EnumerationComboBox'
}

{ #category : #API }
APxEnumerationComboBoxExample class >> matchingPartClass [

	^APxEnumerationComboBoxExamplePart
]
