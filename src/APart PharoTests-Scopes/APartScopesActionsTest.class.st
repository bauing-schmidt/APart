Class {
	#name : #APartScopesActionsTest,
	#superclass : #TestCase,
	#instVars : [
		'rootPart'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #tests }
APartScopesActionsTest >> left2 [

	^ rootPart left child
]

{ #category : #tests }
APartScopesActionsTest >> right2 [

	^ rootPart right child
]

{ #category : #tests }
APartScopesActionsTest >> setUp [ 

	super setUp.
	
	rootPart := APartScopesTestRootPart createWithClientRegistry.
	
	"it is required to let recompute all conditions"
	rootPart partInterface updateAndAnnounceAll.
]

{ #category : #tests }
APartScopesActionsTest >> testActionPerformsUpdate [

	self assert: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft2 ifAbsent: [  ]) isExecutable.

	self right2 execute: #disableAspectInLeft2 ifDisabled: [  ].
	
	self deny: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft2 ifAbsent: [  ]) isExecutable.	
	
	

]
