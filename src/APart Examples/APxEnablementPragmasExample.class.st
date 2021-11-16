"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxEnablementPragmasExample,
	#superclass : #APxEnablementExample,
	#category : #'APart Examples-EnablementPragma'
}

{ #category : #API }
APxEnablementPragmasExample class >> matchingPartClass [
	"self open"

	^APxEnablementPragmasExamplePart
]
