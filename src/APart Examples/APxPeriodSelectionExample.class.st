"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxPeriodSelectionExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-PeriodSelection'
}

{ #category : #API }
APxPeriodSelectionExample class >> matchingPartClass [

	^APxPeriodSelectionExamplePart
]
