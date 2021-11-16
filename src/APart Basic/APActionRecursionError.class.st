Class {
	#name : #APActionRecursionError,
	#superclass : #Error,
	#instVars : [
		'part',
		'key',
		'action'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APActionRecursionError class >> signalFor: anAction part: aPart [

	^ self new 
		action: anAction;
		part: aPart;
		signal
]

{ #category : #accessing }
APActionRecursionError >> action [
	^ action
]

{ #category : #accessing }
APActionRecursionError >> action: anObject [
	action := anObject
]

{ #category : #accessing }
APActionRecursionError >> messageText [

	^ 'Detected recursion for action ', action key asString, ' in part ', part displayString
]

{ #category : #accessing }
APActionRecursionError >> part [
	^ part
]

{ #category : #accessing }
APActionRecursionError >> part: anObject [
	part := anObject
]
