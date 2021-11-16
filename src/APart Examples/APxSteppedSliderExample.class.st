"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxSteppedSliderExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-SteppedSlider'
}

{ #category : #API }
APxSteppedSliderExample class >> matchingPartClass [

	^APxSteppedSliderExamplePart
]
