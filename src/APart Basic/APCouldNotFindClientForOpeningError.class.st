Class {
	#name : #APCouldNotFindClientForOpeningError,
	#superclass : #Error,
	#instVars : [
		'part'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #exceptioninstantiator }
APCouldNotFindClientForOpeningError class >> signal: aPart [

	^ self new
		part: aPart;
		signal;
		yourself
]

{ #category : #accessing }
APCouldNotFindClientForOpeningError >> messageText [

	^ 'Could not find client for opening ', self part printString
]

{ #category : #accessing }
APCouldNotFindClientForOpeningError >> part [
	^ part
]

{ #category : #accessing }
APCouldNotFindClientForOpeningError >> part: anObject [
	part := anObject
]
