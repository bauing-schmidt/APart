Class {
	#name : #APartScopesTestRight1,
	#superclass : #APartScopesTestPart,
	#instVars : [
		'child',
		'aspectInRight1',
		'aspectInRight1Absolute'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #accessing }
APartScopesTestRight1 >> aspectInRight1 [
	^ aspectInRight1
]

{ #category : #accessing }
APartScopesTestRight1 >> aspectInRight1: anObject [
	aspectInRight1 := anObject.
	self changedAspectValue: #aspectInRight1.
]

{ #category : #accessing }
APartScopesTestRight1 >> aspectInRight1Absolute [
	^ aspectInRight1Absolute
]

{ #category : #accessing }
APartScopesTestRight1 >> aspectInRight1Absolute: anObject [
	aspectInRight1Absolute := anObject.
	self changedAspectValue: #aspectInRight1Absolute.
]

{ #category : #accessing }
APartScopesTestRight1 >> child [
	^ child
]

{ #category : #'initialize-release' }
APartScopesTestRight1 >> initializeValues [

	super initializeValues.

	aspectInRight1 := #right1Enabled.
	aspectInRight1Absolute := #right1EnabledAbsolute.

	self partInterface description createAspectNamed: #aspectInRight1.
	self partInterface description createAspectNamed: #aspectInRight1Absolute.
	child := APartScopesTestRight2 onPart: self key: #child.

]
