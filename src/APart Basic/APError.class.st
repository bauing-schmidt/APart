"
I'm am the aPart specific general error for cases when we want to signal important errors with rare occurence (alternative to simple `self error: 'description'`) while we still want to be able to properly test it and 	distinguis them from random tests errors.
"
Class {
	#name : #APError,
	#superclass : #Error,
	#instVars : [
		'attribute'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #accessing }
APError >> attribute [
	^ attribute
]

{ #category : #accessing }
APError >> attribute: anObject [
	attribute := anObject
]
