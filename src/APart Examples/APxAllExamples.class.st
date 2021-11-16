"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxAllExamples,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-All'
}

{ #category : #API }
APxAllExamples class >> matchingPartClass [

	^APxAllExamplesPart
]

{ #category : #announcements }
APxAllExamples >> handleSpecialAnnouncedStates: specialAnnouncedStatesOrNil [

	(self bindingsManager componentAt: #exampleClasses) widget invalidateNow
]
