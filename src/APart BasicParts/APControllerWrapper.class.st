"
APControllerWrapper a wrapper class used to represent a widget controller in APart.
"
Class {
	#name : #APControllerWrapper,
	#superclass : #Object,
	#instVars : [
		'hasEditValue',
		'editValue',
		'aspectKey'
	],
	#category : #'APart BasicParts'
}

{ #category : #'instance creation' }
APControllerWrapper class >> on: aUIController [

	^(self new)
		hasEditValue: aUIController hasEditValue;
		editValue: aUIController view editValue;
		aspectKey: aUIController model aspectKey;
		yourself.
]

{ #category : #accessing }
APControllerWrapper >> aspectKey [

	^aspectKey
]

{ #category : #accessing }
APControllerWrapper >> aspectKey: anObject [

	aspectKey := anObject
]

{ #category : #accessing }
APControllerWrapper >> editValue [

	^editValue
]

{ #category : #accessing }
APControllerWrapper >> editValue: anObject [

	editValue := anObject
]

{ #category : #accessing }
APControllerWrapper >> hasEditValue [

	^hasEditValue == true
]

{ #category : #accessing }
APControllerWrapper >> hasEditValue: anObject [

	hasEditValue := anObject
]

{ #category : #API }
APControllerWrapper >> newAnnouncement [

	^(APControllerWrapperAnnouncement new)
		aspectKey: aspectKey;
		yourself
]
