"
APPublicAction is the first non-abstract class to represent an action instance in the aPart framework. It is used for common cases where code to execute and condition to check are typically defined directly when instantiating the action instance. 
"
Class {
	#name : #APPublicAction,
	#superclass : #APExecutableWithCondition,
	#instVars : [
		'postExecution'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #API }
APPublicAction >> isRawAction [

	^ true
]

{ #category : #API }
APPublicAction >> postExecuteForPart: aPart [

	postExecution isNil ifTrue: [^false].
	postExecution cull: aPart.
	^true
]

{ #category : #API }
APPublicAction >> postExecution [

	postExecution isNil ifTrue: [^false]
]

{ #category : #API }
APPublicAction >> postExecution: aBlockOrSymbol [

	postExecution := aBlockOrSymbol
]
