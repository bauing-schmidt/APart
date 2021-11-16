Class {
	#name : #APMissingActionError,
	#superclass : #Error,
	#instVars : [
		'key'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APMissingActionError class >> signalKey: aspectKey [

	^ self new 
		key: aspectKey;
		signal
]

{ #category : #accessing }
APMissingActionError >> key [
	^ key
]

{ #category : #accessing }
APMissingActionError >> key: anObject [
	key := anObject
]

{ #category : #accessing }
APMissingActionError >> messageText [

	^ 'Trying to call undefined action: ', self key asString
]
