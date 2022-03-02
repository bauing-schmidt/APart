"
An empty placeholder for cases when no presenter is selected for editing
"
Class {
	#name : #ApedNullPresenterPart,
	#superclass : #ApedPresenterPart,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #visiting }
ApedNullPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitNullPart: self
]
