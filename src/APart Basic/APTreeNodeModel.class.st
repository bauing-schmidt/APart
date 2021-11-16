Class {
	#name : #APTreeNodeModel,
	#superclass : #Object,
	#instVars : [
		'value',
		'children',
		'path',
		'opened',
		'parent'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APTreeNodeModel class >> on: anObject [ 
	^self on: anObject path: #()
]

{ #category : #'instance creation' }
APTreeNodeModel class >> on: anObject path: aPath [ 
	^self
		on: anObject
		path: aPath
		opened: false
]

{ #category : #'instance creation' }
APTreeNodeModel class >> on: anObject path: aPath opened: aBoolean [ 
	^self new
		 value: anObject;
		 path: aPath;
		 opened: aBoolean;
		 yourself
]

{ #category : #converting }
APTreeNodeModel >> addAllChildrenTo: aCollection inTree: aTree [
	opened := true.
	aTree getAndSetChildenFor: self.
	children
		do: [ :each | 
			aCollection add: each.
			each addAllChildrenTo: aCollection inTree: aTree ].
	^ aCollection
]

{ #category : #converting }
APTreeNodeModel >> addChild: aChild [

	children add: aChild.
	aChild parent: self.
]

{ #category : #converting }
APTreeNodeModel >> addWithOpenedChildrenTo: aCollection [

	aCollection add: self.
	self hasOpenChildren ifFalse: [ ^ aCollection ].
	children do: [ :child | child addWithOpenedChildrenTo: aCollection ].
	^ aCollection
]

{ #category : #converting }
APTreeNodeModel >> childAt: aSelectionIndex [ 

	| aChild rest |
	
	aChild := self children at: aSelectionIndex first.
	rest := aSelectionIndex allButFirst.
	^ rest 
		ifNotEmpty: [ aChild childAt: rest ]
		 ifEmpty: [ aChild ]
]

{ #category : #converting }
APTreeNodeModel >> children [
	^children
]

{ #category : #converting }
APTreeNodeModel >> children: aCollection [
	children := aCollection
]

{ #category : #converting }
APTreeNodeModel >> childrenAt: aSelectionIndex [ 

	| aChild rest |
	
	rest := aSelectionIndex allButFirst.
	^ rest 
		ifNotEmpty: [ 
			aChild := self children at: aSelectionIndex first.
			aChild childrenAt: rest ]
		ifEmpty: [ self children ]
]

{ #category : #converting }
APTreeNodeModel >> clear [ 

	children removeAll.
]

{ #category : #converting }
APTreeNodeModel >> depth [
	^ path size
]

{ #category : #converting }
APTreeNodeModel >> hasOpenChildren [

	^ children notNil and: [ opened ]
]

{ #category : #converting }
APTreeNodeModel >> initialize [ 

	children := OrderedCollection new.
]

{ #category : #converting }
APTreeNodeModel >> isRoot [ 
	
	^ self depth = 0
]

{ #category : #converting }
APTreeNodeModel >> openChildrenCount [

	self hasOpenChildren ifFalse: [ ^ 0 ].
	^ children
		inject: 0
		into: [ :sum :child | sum + 1 + child openChildrenCount ]
]

{ #category : #converting }
APTreeNodeModel >> openChildrenThatCorrespondToOpenChildrenOf: oldChildren [

	(oldChildren isNil or: [ oldChildren isEmpty ])
		ifTrue: [ ^ self ].

	children
		do: [ :each | 
			| oldChild |
			oldChild := oldChildren
				detect: [ :eachChild | eachChild value = each value ]
				ifNone: [ nil ].
			oldChild
				ifNotNil: [ each opened: oldChild opened.
					each children: oldChild children ] ]
]

{ #category : #converting }
APTreeNodeModel >> opened [
	^opened ifNil:[true]
]

{ #category : #converting }
APTreeNodeModel >> opened: aBoolean [
	opened := aBoolean
]

{ #category : #accessing }
APTreeNodeModel >> parent [

	^parent
]

{ #category : #accessing }
APTreeNodeModel >> parent: anObject [

	parent := anObject
]

{ #category : #converting }
APTreeNodeModel >> path [
	^path
]

{ #category : #accessing }
APTreeNodeModel >> path: anObject [
	path := anObject
]

{ #category : #accessing }
APTreeNodeModel >> removeChild: aChild [

	children remove: aChild.
	aChild parent: nil.
]

{ #category : #converting }
APTreeNodeModel >> resetMyChildrenIn: aTree [

	| oldChildren |
	oldChildren := children copy.
	children := nil.
	aTree getAndSetChildenFor: self.
	self openChildrenThatCorrespondToOpenChildrenOf: oldChildren.
]

{ #category : #converting }
APTreeNodeModel >> resetMyChildrenIn: aTree andAddThemTo: aCollection [

	opened
		ifTrue: [ self resetMyChildrenIn: aTree.
			children
				do: [ :each | 
					aCollection add: each.
					each
						resetMyChildrenIn: aTree andAddThemTo: aCollection ] ]
		ifFalse: [ aTree getChildrenNodesFor: self ].
	^ aCollection
]

{ #category : #converting }
APTreeNodeModel >> value [
	^value
]

{ #category : #converting }
APTreeNodeModel >> value: aValue [ 
	value := aValue
]
