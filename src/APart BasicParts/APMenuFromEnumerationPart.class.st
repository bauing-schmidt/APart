Class {
	#name : #APMenuFromEnumerationPart,
	#superclass : #APEnumerationValuePart,
	#instVars : [
		'targetInterface'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APMenuFromEnumerationPart >> targetInterface [
	^ targetInterface ifNil: [ self partInterface rootInterface ]
]

{ #category : #accessing }
APMenuFromEnumerationPart >> targetInterface: anObject [
	targetInterface := anObject
]
