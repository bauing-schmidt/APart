Class {
	#name : #APActionRedefinitionError,
	#superclass : #Error,
	#instVars : [
		'key'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APActionRedefinitionError class >> signalKey: aspectKey [

	^ self new 
		key: aspectKey;
		signal
]

{ #category : #accessing }
APActionRedefinitionError >> key [
	^ key
]

{ #category : #accessing }
APActionRedefinitionError >> key: anObject [
	key := anObject
]

{ #category : #accessing }
APActionRedefinitionError >> messageText [

	^ 'Trying to redefine action ', self key asString
]
