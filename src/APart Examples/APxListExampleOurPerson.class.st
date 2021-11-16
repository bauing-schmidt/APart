Class {
	#name : #APxListExampleOurPerson,
	#superclass : #Object,
	#instVars : [
		'name',
		'firstName'
	],
	#category : #'APart Examples-ListExample'
}

{ #category : #accessing }
APxListExampleOurPerson >> firstName [
	^ firstName
]

{ #category : #accessing }
APxListExampleOurPerson >> firstName: anObject [
	firstName := anObject
]

{ #category : #accessing }
APxListExampleOurPerson >> name [
	^ name
]

{ #category : #accessing }
APxListExampleOurPerson >> name: anObject [
	name := anObject
]

{ #category : #accessing }
APxListExampleOurPerson >> printOn: aStream [

	aStream 
		nextPutAll: self firstName;
		nextPutAll: ' ';
		nextPutAll: self name
]
