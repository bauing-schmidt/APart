Class {
	#name : #APConditionExpectedError,
	#superclass : #Error,
	#instVars : [
		'wrongClassName'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APConditionExpectedError class >> signalFor: className [

	^ self new
		wrongClassName: className;
		signal
]

{ #category : #accessing }
APConditionExpectedError >> messageText [

	^ 'Expected APCondition instead of ', self wrongClassName asString
]

{ #category : #accessing }
APConditionExpectedError >> wrongClassName [
	^ wrongClassName
]

{ #category : #accessing }
APConditionExpectedError >> wrongClassName: anObject [
	wrongClassName := anObject
]
