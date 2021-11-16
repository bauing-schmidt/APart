"
test initial setup od the part hierarchy
"
Class {
	#name : #APartScopesInitialSetupTest,
	#superclass : #TestCase,
	#instVars : [
		'rootPart'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #tests }
APartScopesInitialSetupTest >> left2 [

	^ rootPart left child
]

{ #category : #tests }
APartScopesInitialSetupTest >> right2 [

	^ rootPart right child
]

{ #category : #tests }
APartScopesInitialSetupTest >> setUp [ 

	super setUp.
	
	rootPart := APartScopesTestRootPart createWithClientRegistry.
	
	"it is required to let recompute all conditions"
	rootPart partInterface updateAndAnnounceAll.
]

{ #category : #tests }
APartScopesInitialSetupTest >> testAccessorChangesConditionStateForRight1 [

	self assert: (rootPart right child partInterface description actionAt: #disableAspectInRight1 ifAbsent: [  ]) isExecutable.
	self deny: (rootPart right child partInterface description actionAt: #enableAspectInRight1 ifAbsent: [  ]) isExecutable.

	rootPart right partInterface holdClientUpdatesWhile: [ 
		rootPart right aspectInRight1: #right1Disabled.
	]. 

	self deny: (rootPart right child partInterface description actionAt: #right2ActionDependingOnAspectInRight1 ifAbsent: [  ]) isExecutable.
	self deny: (rootPart right child partInterface description actionAt: #disableAspectInRight1 ifAbsent: [  ]) isExecutable.
	self assert: (rootPart right child partInterface description actionAt: #enableAspectInRight1 ifAbsent: [  ]) isExecutable.
	

	rootPart right child  partInterface holdClientUpdatesWhile: [ 
		rootPart right aspectInRight1: #right1Enabled.
	]. 
	
	self assert: (rootPart right child partInterface description actionAt: #right2ActionDependingOnAspectInRight1 ifAbsent: [  ]) isExecutable.
	self assert: (rootPart right child partInterface description actionAt: #disableAspectInRight1 ifAbsent: [  ]) isExecutable.
	self deny: (rootPart right child partInterface description actionAt: #enableAspectInRight1 ifAbsent: [  ]) isExecutable.


]

{ #category : #tests }
APartScopesInitialSetupTest >> testAccessorChangesConditionStateForRight2 [

	self assert: (self right2 partInterface description actionAt: #disableAspectInRight2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInRight2 ifAbsent: [  ]) isExecutable.

	self right2 partInterface holdClientUpdatesWhile: [ 
		self right2 aspectInRight2: #right2Disabled.
	]. 

	self deny: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInRight2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #disableAspectInRight2 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #enableAspectInRight2 ifAbsent: [  ]) isExecutable.
	

	self right2 partInterface holdClientUpdatesWhile: [ 
		self right2 aspectInRight2: #right2Enabled.
	]. 
	
	self assert: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInRight2 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #disableAspectInRight2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInRight2 ifAbsent: [  ]) isExecutable.


]

{ #category : #tests }
APartScopesInitialSetupTest >> testAccessorInLeft2ChangesConditionStateForRight2 [

	self assert: (self right2 partInterface description actionAt: #disableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInLeft2 ifAbsent: [  ]) isExecutable.

	rootPart partInterface holdClientUpdatesWhile: [ 
		self left2 aspectInLeft2: #left2Disabled.
	].

	self deny: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #disableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #enableAspectInLeft2 ifAbsent: [  ]) isExecutable.

	self right2 partInterface holdClientUpdatesWhile: [ 
		self left2 aspectInLeft2: #left2Enabled.
	]. 
	
	self assert: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #disableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInLeft2 ifAbsent: [  ]) isExecutable.


]

{ #category : #tests }
APartScopesInitialSetupTest >> testHierarchy [ 

	self assertCollection: rootPart subPartCount equals: 2.
	self assertCollection: rootPart left subPartCount equals: 1.
	self assertCollection: rootPart right subPartCount equals: 1.
	self assertCollection: rootPart left child subPartCount equals: 0.
	self assertCollection: rootPart right child subPartCount equals: 0.

]

{ #category : #tests }
APartScopesInitialSetupTest >> testHierarchyAspects [

	self assert: rootPart knownLeft2 equals: rootPart left child.
	
	rootPart right aspectInRight1: #aspectInRight1Value.
	rootPart right aspectInRight1Absolute: #aspectInRight1AbsoluteValue.
	
	self assert: (rootPart right child partInterface description aspectFor: #redirectedToRight1 ifAbsent: nil) value equals: #aspectInRight1Value.	
	self assert: (rootPart right child partInterface description aspectFor: #redirectedToRight1Absolute ifAbsent: nil) value equals: #aspectInRight1AbsoluteValue.
	
	rootPart left aspectInLeft1: #aspectInLeft1Value.
	rootPart left aspectInLeft1Absolute: #aspectInLeft1AbsoluteValue.
	
	self assert: (rootPart right child partInterface description aspectFor: #redirectedToLeft1 ifAbsent: nil) value equals: #aspectInLeft1Value.	
	self assert: (rootPart right child partInterface description aspectFor: #redirectedToLeft1Absolute ifAbsent: nil) value equals: #aspectInLeft1AbsoluteValue.
]

{ #category : #tests }
APartScopesInitialSetupTest >> testRight2ActionsDependingOnLeft1 [

	self assert: (self right2 partInterface description actionAt: #disableAspectInLeft1 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInLeft1 ifAbsent: [  ]) isExecutable.

	self right2 partInterface execute: #disableAspectInLeft1 ifDisabled: [].

	self deny: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft1 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #disableAspectInLeft1 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #enableAspectInLeft1 ifAbsent: [  ]) isExecutable.
	
	self right2 partInterface execute: #enableAspectInLeft1 ifDisabled: [].
	
	self assert: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft1 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #disableAspectInLeft1 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInLeft1 ifAbsent: [  ]) isExecutable.


]

{ #category : #tests }
APartScopesInitialSetupTest >> testRight2ActionsDependingOnLeft2 [

	self assert: (self right2 partInterface description actionAt: #disableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInLeft2 ifAbsent: [  ]) isExecutable.

	self right2 partInterface execute: #disableAspectInLeft2 ifDisabled: [].

	self deny: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #disableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #enableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	
	self right2 partInterface execute: #enableAspectInLeft2 ifDisabled: [].
	
	self assert: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #disableAspectInLeft2 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInLeft2 ifAbsent: [  ]) isExecutable.


]

{ #category : #tests }
APartScopesInitialSetupTest >> testRight2ActionsDependingOnRight1 [

	self assert: (self right2 partInterface description actionAt: #disableAspectInRight1 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInRight1 ifAbsent: [  ]) isExecutable.

	self right2 partInterface execute: #disableAspectInRight1 ifDisabled: [].
	
	self deny: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInRight1 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #disableAspectInRight1 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #enableAspectInRight1 ifAbsent: [  ]) isExecutable.
	
	self right2 partInterface execute: #enableAspectInRight1 ifDisabled: [].
	
	self assert: (self right2 partInterface description actionAt: #right2ActionDependingOnAspectInRight1 ifAbsent: [  ]) isExecutable.
	self assert: (self right2 partInterface description actionAt: #disableAspectInRight1 ifAbsent: [  ]) isExecutable.
	self deny: (self right2 partInterface description actionAt: #enableAspectInRight1 ifAbsent: [  ]) isExecutable.


]

{ #category : #tests }
APartScopesInitialSetupTest >> testRight2ActionsDependingOnRight2 [

	self assert: (rootPart right child partInterface description actionAt: #disableAspectInRight2 ifAbsent: [  ]) isExecutable.
	self deny: (rootPart right child partInterface description actionAt: #enableAspectInRight2 ifAbsent: [  ]) isExecutable.

	rootPart right child partInterface execute: #disableAspectInRight2 ifDisabled: [].
	
	self deny: (rootPart right child partInterface description actionAt: #right2ActionDependingOnAspectInRight2 ifAbsent: [  ]) isExecutable.
	self deny: (rootPart right child partInterface description actionAt: #disableAspectInRight2 ifAbsent: [  ]) isExecutable.
	self assert: (rootPart right child partInterface description actionAt: #enableAspectInRight2 ifAbsent: [  ]) isExecutable.
	
	rootPart right child partInterface execute: #enableAspectInRight2 ifDisabled: [].
	
	self assert: (rootPart right child partInterface description actionAt: #right2ActionDependingOnAspectInRight2 ifAbsent: [  ]) isExecutable.
	self assert: (rootPart right child partInterface description actionAt: #disableAspectInRight2 ifAbsent: [  ]) isExecutable.
	self deny: (rootPart right child partInterface description actionAt: #enableAspectInRight2 ifAbsent: [  ]) isExecutable.


]
