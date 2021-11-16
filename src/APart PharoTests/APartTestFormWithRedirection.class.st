Class {
	#name : #APartTestFormWithRedirection,
	#superclass : #APartTestFormPart,
	#instVars : [
		'target',
		'actionExecuted'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #accessing }
APartTestFormWithRedirection >> actionExecuted [

	^ actionExecuted
]

{ #category : #accessing }
APartTestFormWithRedirection >> executeAction [ 

	actionExecuted := true
]

{ #category : #accessing }
APartTestFormWithRedirection >> initialize [

	super initialize.
	
	actionExecuted := false.
]

{ #category : #accessing }
APartTestFormWithRedirection >> initializeValues [

	super initializeValues.

	self partInterface description createAspectNamed: #target.
]

{ #category : #accessing }
APartTestFormWithRedirection >> target [ 

	^ target
]

{ #category : #accessing }
APartTestFormWithRedirection >> target: aValue [

	target := aValue
]
