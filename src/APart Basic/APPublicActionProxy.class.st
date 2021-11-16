Class {
	#name : #APPublicActionProxy,
	#superclass : #APPublicAction,
	#instVars : [
		'targetAction'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #'instance creation' }
APPublicActionProxy class >> from: anAction [ 

	^ self new initializeOn: anAction
]

{ #category : #initialization }
APPublicActionProxy >> initializeOn: anAction [ 

	targetAction := anAction
]

{ #category : #accessing }
APPublicActionProxy >> targetAction [

	^ targetAction
]
