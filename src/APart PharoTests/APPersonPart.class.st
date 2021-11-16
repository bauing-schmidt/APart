Class {
	#name : #APPersonPart,
	#superclass : #APart,
	#instVars : [
		'name',
		'surname'
	],
	#category : #'APart PharoTests'
}

{ #category : #accessing }
APPersonPart >> name [
	^ name
]

{ #category : #accessing }
APPersonPart >> name: anObject [
	name := anObject
]

{ #category : #accessing }
APPersonPart >> surname [
	^ surname
]

{ #category : #accessing }
APPersonPart >> surname: anObject [
	surname := anObject
]
