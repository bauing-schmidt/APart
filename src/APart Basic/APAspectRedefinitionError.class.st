Class {
	#name : #APAspectRedefinitionError,
	#superclass : #Error,
	#instVars : [
		'key'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APAspectRedefinitionError class >> signalKey: aspectKey [

	^ self new 
		key: aspectKey;
		signal
]

{ #category : #accessing }
APAspectRedefinitionError >> key [
	^ key
]

{ #category : #accessing }
APAspectRedefinitionError >> key: anObject [
	key := anObject
]

{ #category : #accessing }
APAspectRedefinitionError >> messageText [

	^ 'Trying to redefine aspect named ', self key asString
]
