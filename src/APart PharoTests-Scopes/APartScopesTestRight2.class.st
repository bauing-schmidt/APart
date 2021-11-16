Class {
	#name : #APartScopesTestRight2,
	#superclass : #APartScopesTestPart,
	#instVars : [
		'aspectInRight2',
		'aspectInRight2Absolute'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #accessing }
APartScopesTestRight2 >> aspectInRight2 [
	^ aspectInRight2
]

{ #category : #accessing }
APartScopesTestRight2 >> aspectInRight2: anObject [
	aspectInRight2 := anObject.
	self changedAspectValue: #aspectInRight2.
]

{ #category : #accessing }
APartScopesTestRight2 >> aspectInRight2Absolute [
	^ aspectInRight2Absolute
]

{ #category : #accessing }
APartScopesTestRight2 >> aspectInRight2Absolute: anObject [
	aspectInRight2Absolute := anObject.
	self changedAspectValue: #aspectInRight2Absolute.
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> initializeActions [ 

	self initializeActionsDependingOnRight2.
	self initializeActionsDependingOnRight1.
	
	self initializeActionsDependingOnLeft1.
	self initializeActionsDependingOnLeft2.
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> initializeActionsDependingOnLeft1 [

	 partInterface description
        createAction: #right2ActionDependingOnAspectInLeft1
        do: [ self logAction: #right2ActionDependingOnAspectInLeft1 ]
        if: (APCondition on: [ self valueOfRedirectedToLeft1 = #left1Enabled ] ifNot: #left1EnabledNot).

	 partInterface description
        createAction: #disableAspectInLeft1
        do: [ self valueOfRedirectedToLeft1: #left1Disabled.
				self logAction: #disableAspectInLeft1 ]
        if: (APCondition on: [ self valueOfRedirectedToLeft1 = #left1Enabled ] ifNot: #left1EnabledNot).

	 partInterface description
        createAction: #enableAspectInLeft1
        do: [ 
				self valueOfRedirectedToLeft1: #left1Enabled.
				self logAction: #enableAspectInLeft1 ]
        if: (APCondition on: [ self valueOfRedirectedToLeft1 = #left1Disabled ] ifNot: #left1Enabled).
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> initializeActionsDependingOnLeft2 [

	 partInterface description
        createAction: #right2ActionDependingOnAspectInLeft2
        do: [ self logAction: #right2ActionDependingOnAspectInLeft2 ]
        if: (APCondition on: [ self valueOfRedirectedToLeft2 = #left2Enabled ] ifNot: #left2EnabledNot).

	partInterface addDependencyFrom: #right2ActionDependingOnAspectInLeft2 to: #('..' '..' #left #child aspectInLeft2).

	 partInterface description
        createAction: #disableAspectInLeft2
        do: [ self valueOfRedirectedToLeft2: #left2Disabled.
				self logAction: #disableAspectInLeft2 ]
        if: (APCondition on: [ self valueOfRedirectedToLeft2 = #left2Enabled ] ifNot: #left2EnabledNot).

	 partInterface description
        createAction: #enableAspectInLeft2
        do: [ 
				self valueOfRedirectedToLeft2: #left2Enabled.
				self logAction: #enableAspectInLeft2 ]
        if: (APCondition on: [ self valueOfRedirectedToLeft2 ~= #left2Enabled ] ifNot: #left2Enabled).
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> initializeActionsDependingOnRight1 [

	 partInterface description
        createAction: #right2ActionDependingOnAspectInRight1
        do: [ self logAction: #right2ActionDependingOnAspectInRight1 ]
        if: (APCondition on: [ self valueOfRedirectedToRight1 = #right1Enabled ] ifNot: #right1EnabledNot).

	 partInterface description
        createAction: #disableAspectInRight1
        do: [ self valueOfRedirectedToRight1: #right1Disabled.
				self logAction: #disableAspectInRight1 ]
        if: (APCondition on: [ self valueOfRedirectedToRight1 = #right1Enabled ] ifNot: #right1EnabledNot).

	 partInterface description
        createAction: #enableAspectInRight1
        do: [ 
				self valueOfRedirectedToRight1: #right1Enabled.
				self logAction: #enableAspectInRight1 ]
        if: (APCondition on: [ self valueOfRedirectedToRight1 = #right1Disabled ] ifNot: #right1Enabled).
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> initializeActionsDependingOnRight2 [ 

	 partInterface description
        createAction: #right2ActionDependingOnAspectInRight2
        do: [ self logAction: #right2ActionDependingOnAspectInRight2 ]
        if: (APCondition on: [ self aspectInRight2 = #right2Enabled ] ifNot: #right2EnabledNot).

	 partInterface description
        createAction: #disableAspectInRight2
        do: [ self aspectInRight2: #right2Disabled.
				self logAction: #disableAspectInRight2 ]
        if: (APCondition on: [self aspectInRight2 = #right2Enabled ] ifNot: #right2EnabledNot).

	 partInterface description
        createAction: #enableAspectInRight2
        do: [ 
				self aspectInRight2: #right2Enabled.
				self logAction: #enableAspectInRight2 ]
        if: (APCondition on: [self aspectInRight2 = #right2Disabled ] ifNot: #right2Enabled).
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> initializeValues [

	super initializeValues.
	
	aspectInRight2 := #right2Enabled.
	aspectInRight2Absolute := #right2EnabledAbsolute.

	self partInterface description createAspectNamed: #aspectInRight2.

	self partInterface description createAspectNamed: #redirectedToRight1 redirectTo: #('..' #aspectInRight1).
	self partInterface description createAspectNamed: #redirectedToRight1Absolute redirectTo: #('/' #right aspectInRight1Absolute ).

	self partInterface description createAspectNamed: #redirectedToLeft1 redirectTo: #('..' '..' #left #aspectInLeft1).
	self partInterface description createAspectNamed: #redirectedToLeft1Absolute redirectTo: #('/' #left aspectInLeft1Absolute ).
	
	self partInterface description createAspectNamed: #redirectedToLeft2 redirectTo: #('..' '..' #left child #aspectInLeft2).
	self partInterface description createAspectNamed: #redirectedToLeft2Absolute redirectTo: #('/' #left child aspectInLeft2Absolute ).
	
	
	self at: #aspectInRight2 putCondition: (APCondition on: [ false ] ifNot: #left2Disabled ).

]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> valueOfRedirectedToLeft1 [

	^ (self partInterface description aspectFor: #redirectedToLeft1 ifAbsent: [ ]) subAdaptor value
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> valueOfRedirectedToLeft1: aValue [

	^ (self partInterface description aspectFor: #redirectedToLeft1 ifAbsent: [ ]) subAdaptor value: aValue
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> valueOfRedirectedToLeft2 [

	^ (self partInterface description aspectFor: #redirectedToLeft2 ifAbsent: [ ]) subAdaptor value
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> valueOfRedirectedToLeft2: aValue [

	^ (self partInterface description aspectFor: #redirectedToLeft2 ifAbsent: []) subAdaptor valueWithoutConditionCheck: aValue
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> valueOfRedirectedToRight1 [

	^ (self partInterface description aspectFor: #redirectedToRight1 ifAbsent: [ ]) subAdaptor value
]

{ #category : #'initialize-release' }
APartScopesTestRight2 >> valueOfRedirectedToRight1: aValue [

	^ (self partInterface description aspectFor: #redirectedToRight1 ifAbsent: [ ]) subAdaptor value: aValue
]
