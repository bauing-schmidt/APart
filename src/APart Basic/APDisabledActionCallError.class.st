Class {
	#name : #APDisabledActionCallError,
	#superclass : #Error,
	#instVars : [
		'reason'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #accessing }
APDisabledActionCallError class >> signalReason: aReason [

	^ self new
		reason: aReason;
		signal;
		yourself
]

{ #category : #accessing }
APDisabledActionCallError >> messageText [

	^ 'Internal error: Called action disabled for reason: ' , reason asString
]

{ #category : #accessing }
APDisabledActionCallError >> reason [
	^ reason
]

{ #category : #accessing }
APDisabledActionCallError >> reason: anObject [
	reason := anObject
]
