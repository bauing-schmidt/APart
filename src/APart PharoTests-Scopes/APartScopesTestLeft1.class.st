Class {
	#name : #APartScopesTestLeft1,
	#superclass : #APartScopesTestPart,
	#instVars : [
		'child',
		'aspectInLeft1',
		'aspectInLeft1Absolute'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #accessing }
APartScopesTestLeft1 >> aspectInLeft1 [
	^ aspectInLeft1
]

{ #category : #accessing }
APartScopesTestLeft1 >> aspectInLeft1: anObject [
	aspectInLeft1 := anObject.
	self changedAspectValue: #aspectInLeft1.
]

{ #category : #accessing }
APartScopesTestLeft1 >> aspectInLeft1Absolute [
	^ aspectInLeft1Absolute
]

{ #category : #accessing }
APartScopesTestLeft1 >> aspectInLeft1Absolute: anObject [
	aspectInLeft1Absolute := anObject.
	self changedAspectValue: #aspectInLeft1Absolute.
]

{ #category : #accessing }
APartScopesTestLeft1 >> child [
	^ child
]

{ #category : #'initialize-release' }
APartScopesTestLeft1 >> initializeValues [

	super initializeValues.

	aspectInLeft1 := #left1Enabled.
	aspectInLeft1Absolute := #left1EnabledAbsolute.

	child := APartScopesTestLeft2 onPart: self key: #child.
	self partInterface description createAspectNamed: #aspectInLeft1.
	self partInterface description createAspectNamed: #aspectInLeft1Absolute.
	
]
