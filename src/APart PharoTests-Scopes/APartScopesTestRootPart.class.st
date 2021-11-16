Class {
	#name : #APartScopesTestRootPart,
	#superclass : #APartScopesTestPart,
	#instVars : [
		'left',
		'right',
		'knownLeft2'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #'initialize-release' }
APartScopesTestRootPart >> initializeValues [

	super initializeValues.

	left := APartScopesTestLeft1 onPart: self key: #left.
	right := APartScopesTestRight1 onPart: self key: #right.
	
	self partInterface description createAspectNamed: #knownLeft2.
	
]

{ #category : #accessing }
APartScopesTestRootPart >> knownLeft2 [
	^ knownLeft2
]

{ #category : #accessing }
APartScopesTestRootPart >> knownLeft2: anObject [
	knownLeft2 := anObject
]

{ #category : #accessing }
APartScopesTestRootPart >> left [
	^ left
]

{ #category : #accessing }
APartScopesTestRootPart >> right [
	^ right
]
