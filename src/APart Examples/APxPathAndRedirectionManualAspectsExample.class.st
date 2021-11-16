"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxPathAndRedirectionManualAspectsExample,
	#superclass : #APxPathAndRedirectionExample,
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #API }
APxPathAndRedirectionManualAspectsExample class >> matchingPartClass [

	^APxPathAndRedirectionManualAspectsPart
]
