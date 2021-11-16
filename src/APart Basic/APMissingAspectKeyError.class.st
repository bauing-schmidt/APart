Class {
	#name : #APMissingAspectKeyError,
	#superclass : #Error,
	#instVars : [
		'key'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APMissingAspectKeyError class >> signalKey: aspectKey [

	^ self new 
		key: aspectKey;
		signal
]

{ #category : #accessing }
APMissingAspectKeyError >> key [
	^ key
]

{ #category : #accessing }
APMissingAspectKeyError >> key: anObject [
	key := anObject
]

{ #category : #accessing }
APMissingAspectKeyError >> messageText [

	^ 'Missing aspect for key ', self key asString
]
