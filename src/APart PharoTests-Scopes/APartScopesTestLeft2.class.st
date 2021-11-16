Class {
	#name : #APartScopesTestLeft2,
	#superclass : #APartScopesTestPart,
	#instVars : [
		'aspectInLeft2',
		'aspectInLeft2Absolute'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #accessing }
APartScopesTestLeft2 >> aspectInLeft2 [
	^ aspectInLeft2
]

{ #category : #accessing }
APartScopesTestLeft2 >> aspectInLeft2: anObject [

	Transcript show: 'aspectInLeft2:', anObject asString; cr.
	aspectInLeft2 := anObject.
	self changedAspectValue: #aspectInLeft2.
]

{ #category : #accessing }
APartScopesTestLeft2 >> aspectInLeft2Absolute [
	^ aspectInLeft2Absolute
]

{ #category : #accessing }
APartScopesTestLeft2 >> aspectInLeft2Absolute: anObject [
	aspectInLeft2Absolute := anObject.
	self changedAspectValue: #aspectInLeft2Absolute.
]

{ #category : #'initialize-release' }
APartScopesTestLeft2 >> initializeValues [

	super initializeValues.

	aspectInLeft2 := #left2Enabled.
	aspectInLeft2Absolute := #left2EnabledAbsolute.

	self partInterface description createAspectNamed: #aspectInLeft2.
	self parentPart parentPart knownLeft2: self.
	
	self at: #aspectInLeft2 putCondition: (APCondition on: [ aspectInLeft2 = #left2Enabled ] ifNot: #left2Disabled ).
]
