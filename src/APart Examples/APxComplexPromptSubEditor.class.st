"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxComplexPromptSubEditor,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-ComplexPrompt'
}

{ #category : #API }
APxComplexPromptSubEditor class >> matchingPartClass [

	^APxComplexPromptSubEditorPart
]
