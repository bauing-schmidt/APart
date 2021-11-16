Class {
	#name : #APConditionRedefinitionError,
	#superclass : #Error,
	#instVars : [
		'conditionName'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #signalling }
APConditionRedefinitionError class >> signalForConditionNamed: aString [

	^ self new 
		conditionName: aString; 
		signal
]

{ #category : #accessing }
APConditionRedefinitionError >> conditionName [
	^ conditionName ifNil: 'UNKNOWN'
]

{ #category : #accessing }
APConditionRedefinitionError >> conditionName: anObject [
	conditionName := anObject
]

{ #category : #accessing }
APConditionRedefinitionError >> messageText [

	^ 'Trying to redefine Condition named ', self conditionName asString
]
