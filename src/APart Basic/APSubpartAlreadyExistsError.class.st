Class {
	#name : #APSubpartAlreadyExistsError,
	#superclass : #Error,
	#instVars : [
		'key',
		'alreadyExisting'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APSubpartAlreadyExistsError class >> signalKey: aSymbol alreadyExisting: part [

	^ self new 
		key: aSymbol; 
		alreadyExisting: part; 
		signal
]

{ #category : #accessing }
APSubpartAlreadyExistsError >> alreadyExisting [
	^ alreadyExisting
]

{ #category : #accessing }
APSubpartAlreadyExistsError >> alreadyExisting: anObject [
	alreadyExisting := anObject
]

{ #category : #accessing }
APSubpartAlreadyExistsError >> key [
	^ key
]

{ #category : #accessing }
APSubpartAlreadyExistsError >> key: anObject [
	key := anObject
]

{ #category : #accessing }
APSubpartAlreadyExistsError >> messageText [

	^ 'Part for key ', self key printString, ' is already existing: ', alreadyExisting displayString
]
