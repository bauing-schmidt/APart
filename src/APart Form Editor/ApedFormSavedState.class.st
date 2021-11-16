Class {
	#name : #ApedFormSavedState,
	#superclass : #Object,
	#instVars : [
		'jsonForm',
		'selectedElementIndexes',
		'selectedLayoutIndexes'
	],
	#category : #'APart Form Editor-Support'
}

{ #category : #accessing }
ApedFormSavedState >> jsonForm [

	^ jsonForm
]

{ #category : #accessing }
ApedFormSavedState >> jsonForm: anObject [

	jsonForm := anObject
]

{ #category : #accessing }
ApedFormSavedState >> selectedElementIndexes [

	^ selectedElementIndexes
]

{ #category : #accessing }
ApedFormSavedState >> selectedElementIndexes: anObject [

	selectedElementIndexes := anObject
]

{ #category : #accessing }
ApedFormSavedState >> selectedLayoutIndexes [

	^ selectedLayoutIndexes
]

{ #category : #accessing }
ApedFormSavedState >> selectedLayoutIndexes: anObject [

	selectedLayoutIndexes := anObject
]
