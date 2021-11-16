Class {
	#name : #APTreeModel,
	#superclass : #Model,
	#instVars : [
		'collection',
		'root',
		'getChildrenBlock',
		'hasChildrenBlock',
		'columns',
		'showHeaders'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'as yet unclassified' }
APTreeModel class >> on: root showRoot: displayIt childrenWith: childBlock [ 

	^self new
		root: root
		displayIt: displayIt
		getChildrenBlock: childBlock
]

{ #category : #adding }
APTreeModel >> addChild: aChild path: aPath after: aNodeOrNil [

	| nodeModel |
	nodeModel := self nodeModelFor: aChild path: aPath.
	self getChildNodesFor: nodeModel.
	aNodeOrNil 
		ifNil: [collection add: nodeModel]
		ifNotNil: [collection add: nodeModel after: aNodeOrNil]
]

{ #category : #accessing }
APTreeModel >> addColumn: aColumn [

	^ columns add: aColumn
]

{ #category : #adding }
APTreeModel >> allParentsFor: anObject [
	| path |
	path := self pathToObject: anObject.
	(path isEmpty or: [ path size = 1 ])
		ifTrue: [ ^ OrderedCollection new ].
	^ path allButLast
]

{ #category : #adding }
APTreeModel >> at: anIndex [ 

	^(collection at: anIndex) value
]

{ #category : #adding }
APTreeModel >> at: anIndex put: anObject [ 

	self aPartError: #fobidden
]

{ #category : #adding }
APTreeModel >> childOf: targetObject containing: anObject into: aCollection [

	| targetChildren |
	(self hasChildrenFor: targetObject) ifFalse: [^self].
	targetChildren := self childrenFor: targetObject.
	aCollection addLast: targetObject.
	targetChildren do:
		[:each |
		each = anObject ifTrue: [^aCollection add: anObject; yourself].
		self childOf: each containing: anObject into: aCollection.
		aCollection last = anObject ifTrue: [^self]].
	aCollection removeLast.
]

{ #category : #adding }
APTreeModel >> childrenAt: aSelectionIndex [ 

	^ self root childrenAt: aSelectionIndex 
]

{ #category : #adding }
APTreeModel >> childrenFor: aValue [ 

	aValue ifNil: [^ Array new].
	^hasChildrenBlock ifNil: [getChildrenBlock value: aValue]
		ifNotNil: [(hasChildrenBlock value: aValue)
				ifTrue: [getChildrenBlock value: aValue]
				ifFalse: [^ Array new]]
]

{ #category : #adding }
APTreeModel >> clear [ 

	self root clear
]

{ #category : #adding }
APTreeModel >> collection [
	^ collection 
]

{ #category : #accessing }
APTreeModel >> columns [ 

	^ columns 
]

{ #category : #adding }
APTreeModel >> directRootChildren [

	^ (collection notEmpty and: [ root = (self at: 1) ])
		ifTrue: [ OrderedCollection with: root ]
		ifFalse: [ self childrenFor: root ]
]

{ #category : #adding }
APTreeModel >> expand: anIndex [ 
	"Expand the element at anIndex if it is not expanded yet. 
	Also expand children that were expanded when this node was contracted."

	| tRoot childHolders toBeAdded |
	tRoot := self nodeAt: anIndex.
	(anIndex >= self size or: [(self nodeAt: anIndex + 1) depth <= tRoot depth])
		ifFalse: [^self].
	childHolders := self getAndSetChildenFor: tRoot.
	tRoot opened: true.
	self invalidateAt: anIndex.
	childHolders isEmpty ifTrue: [^self].
	toBeAdded := OrderedCollection new.
	childHolders do: [:each | 	
		self getChildrenNodesFor: each. 
		toBeAdded := each addWithOpenedChildrenTo: toBeAdded].
	self addAll: toBeAdded beforeIndex: anIndex + 1
]

{ #category : #adding }
APTreeModel >> expandFully: anIndex [ 
	"Expand element at anIndex (and all of its children too)"

	| children |
	children := (self nodeAt: anIndex) 
				addAllChildrenTo: OrderedCollection new
				inTree: self.
	self invalidateAt: anIndex.
	children isEmpty ifTrue: [^self].
	self replaceChildrenOfNodeAt: anIndex with: children
]

{ #category : #adding }
APTreeModel >> expandNodeOf: anObject [ 

	| path |
	path := self pathToObject: anObject.
	path isEmpty ifTrue: [^false].	
	path allButLastDo: [ :each | self expand: (collection indexOf: each) ].
	self selectIndex: (collection indexOf: path last).
	^true
]

{ #category : #adding }
APTreeModel >> findFirst: aBlock startingAt: anIndex [

	anIndex to: collection size do: [:index |
		(aBlock value: (collection at: index)) ifTrue: [^index]].
	^ 0
]

{ #category : #adding }
APTreeModel >> firstLevelChildren [

	^(collection notEmpty and:[root = (self at: 1)]) 
		ifTrue: [OrderedCollection with: root]
		ifFalse: [self childrenFor: root]
]

{ #category : #adding }
APTreeModel >> getAndSetChildenFor: aNode [
	
	| childHolders children |
	(children := self childrenFor: aNode value) isEmpty
		ifTrue: [ childHolders := #() ]
		ifFalse: [ childHolders := children
				collect:
					[ :each | self nodeModelFor: each path: (self nextLevelTo: aNode path) ].
			childHolders last
				path: (self lastLevelTo: aNode path) ].
	aNode children: childHolders.
	^ childHolders
]

{ #category : #adding }
APTreeModel >> getChildNodesFor: aTreeNode [

	| result |
	hasChildrenBlock isNil ifTrue: [^self getAndSetChildenFor: aTreeNode].
	result := (hasChildrenBlock value: aTreeNode value) 
				ifTrue: [nil]
				ifFalse: [Array new].
	aTreeNode children: result.
	^result
]

{ #category : #adding }
APTreeModel >> getChildrenBlock: aBlock [ 

	aBlock numArgs ~= 1 ifTrue: [self aPartError: #invalidArgumentsCount].
	getChildrenBlock := aBlock
]

{ #category : #adding }
APTreeModel >> hasChildrenBlock: aBlock [ 

	aBlock numArgs ~= 1 ifTrue: [self aPartError: #invalidArgumentsCount].
	hasChildrenBlock := aBlock
]

{ #category : #adding }
APTreeModel >> hasChildrenFor: anObject [ 

	^hasChildrenBlock 
		ifNil: [(getChildrenBlock value: anObject) notEmpty]
		ifNotNil: [hasChildrenBlock value: anObject]
]

{ #category : #adding }
APTreeModel >> initialize [

	super initialize.
	collection := OrderedCollectionWithDependants new.
	getChildrenBlock := [:ea | ea children].
	
	columns := OrderedCollection new.
	showHeaders := false.

]

{ #category : #adding }
APTreeModel >> invalidateAt: anIndex [ 
	
	self changed: #replace: with: (Array with: anIndex with: anIndex)
]

{ #category : #adding }
APTreeModel >> isInList: anObject [

	^(collection indexOf: anObject) isZero not
]

{ #category : #adding }
APTreeModel >> lastIndexOfChildAt: anIndex [ 

	| rootIndention probe lastIdx |
	rootIndention := (collection at: anIndex) depth.
	probe := anIndex + 1.
	lastIdx := anIndex.
	[probe <= self size]
		whileTrue: 
			[(collection at: probe) depth <= rootIndention
				ifTrue: [probe := self size]
				ifFalse: [lastIdx := probe].
			probe := probe + 1].
	^lastIdx = anIndex
		ifTrue: [0]
		ifFalse: [lastIdx]
]

{ #category : #adding }
APTreeModel >> lastLevelTo: aLevelDescription [ 

	^(self nextLevelTo: aLevelDescription)
		at: aLevelDescription size + 1 put: #lastLine; yourself
]

{ #category : #adding }
APTreeModel >> leafChildrenForSelection: aSelection [

	
]

{ #category : #adding }
APTreeModel >> nextLevelTo: aLevelDescription [ 
	
	| newLevel |
	newLevel := aLevelDescription , #(#line).
	(aLevelDescription isEmpty not and: [aLevelDescription last = #lastLine])
		ifTrue: [newLevel at: aLevelDescription size put: #noLine].
	^newLevel
]

{ #category : #adding }
APTreeModel >> nodeModelFor: anObject [ 

	^ self root nodeModelFor: anObject 
]

{ #category : #adding }
APTreeModel >> nodeModelFor: child path: aPath [ 

	^APTreeNodeModel on: child path: aPath
]

{ #category : #adding }
APTreeModel >> parentIndexOfChildAt: anIndex [ 
	"Detect the index of parent of an element at anIndex. Return zero if parent is invisible root"

	| rootIndention probe parentIdx probeLevel |
	rootIndention := (collection at: anIndex) depth.
	probe := anIndex - 1.
	parentIdx := 0.
	[probe > 0 and: [parentIdx = 0]]
		whileTrue: 
			[probeLevel := (collection at: probe) depth.
			probeLevel < rootIndention ifTrue: [parentIdx := probe].
			probe := probe - 1].
	^parentIdx
]

{ #category : #adding }
APTreeModel >> pathToObject: anObject [
	"Answer a collection that represents the path, from a root object to anObject
	which we can use to navigate to anObject in the tree."

	| path |
	path := OrderedCollection new.
	self directRootChildren
		do: [ :each | self childOf: each containing: anObject into: path ].
	^ path
]

{ #category : #adding }
APTreeModel >> refresh: anObject [ 

	| idx |
	anObject == root ifTrue: [^self refreshRoot].
	idx := 1.
	[idx isZero not]
		whileTrue: 
			[idx := collection findFirst: [:ea | ea value == anObject]
						startingAt: idx.
			idx isZero not
				ifTrue: 
					[self refreshNodeAt: idx.
					idx := idx + 1]]
]

{ #category : #adding }
APTreeModel >> refreshNodeAt: anIndex [ 

	| newChildren |
	newChildren := (collection at: anIndex)
				resetMyChildrenIn: self andAddThemTo: OrderedCollection new.
	self invalidateAt: anIndex.
	self replaceChildrenOfNodeAt: anIndex with: newChildren
]

{ #category : #adding }
APTreeModel >> refreshRoot [

	| index |
	(self isInList: root) ifFalse: [self resetDirectRootChildrenIfNeeded].
	index := 1.
	[index = 0 ] whileFalse: 
		[index := self findFirst: [:each | each depth isZero] startingAt: index.
		index = 0 ifFalse: [self refreshNodeAt: index.
			index := index + 1]]
]

{ #category : #adding }
APTreeModel >> removeAt: anIndex [ 
	
	^anIndex > self size 
		ifTrue: [ SubscriptOutOfBounds signal: anIndex]
		ifFalse: 
			[| parentIndex node |
			node := self nodeAt: anIndex.
			parentIndex := self parentIndexOfChildAt: anIndex.
			"The following has to be converted to something useful"
			self removeFrom: anIndex to: anIndex + node openChildrenCount.
			parentIndex = 0 
				ifFalse: [(self nodeAt: parentIndex) children remove: node]]
]

{ #category : #adding }
APTreeModel >> replaceChildrenOfNodeAt: anIndex with: newChildren [ 
	"If there were no children displayed yet, just add all those found.
	 Also make sure that if it happens that we have less children we deal with it.
	 Once we have displayed some children but not all of them, add those still missing."

	| alreadyDisplayed toBeReplaced |
	alreadyDisplayed := (self lastIndexOfChildAt: anIndex) - anIndex.
	alreadyDisplayed <= 0 ifTrue: 
		[^self 
			addAll: newChildren 
			beforeIndex: anIndex + 1].
	toBeReplaced := alreadyDisplayed min: newChildren size.
	1 to: toBeReplaced do: 
		[:index | 
		collection at: anIndex + index put: (newChildren at: index)].
	self 
		changed: #replace:
		with: (Array 
			with: anIndex
			with: anIndex + toBeReplaced).
	alreadyDisplayed > toBeReplaced ifTrue: 
		[self 
			removeFrom: anIndex + toBeReplaced + 1
			to: anIndex + alreadyDisplayed].
	alreadyDisplayed < newChildren size ifTrue: 
		[self 
			addAll: (newChildren 
				copyFrom: toBeReplaced + 1
				to: newChildren size)
			beforeIndex: anIndex + toBeReplaced + 1]
]

{ #category : #adding }
APTreeModel >> resetDirectRootChildrenIfNeeded [
	self directRootChildren
		keysAndValuesDo: [ :index :each | 
			(collection indexOf: each) = index
				ifFalse: [ ^ self root: root showRoot: false ] ]
]

{ #category : #adding }
APTreeModel >> resetOpened [

	| oldLimit |
	oldLimit := collection size.
	collection := OrderedCollection new.
	(self myDependents isNil and: [oldLimit > 0])
		ifFalse: [self changed: #removeFrom:to: with: { 1. oldLimit}]
]

{ #category : #adding }
APTreeModel >> root [

	^root
]

{ #category : #adding }
APTreeModel >> root: anObject [

	^ self root: anObject showRoot: true
]

{ #category : #adding }
APTreeModel >> root: anObject displayIt: aBoolean getChildrenBlock: aBlock [

	self getChildrenBlock: aBlock.
	self root: anObject showRoot: aBoolean
]

{ #category : #adding }
APTreeModel >> root: anObject showRoot: aBoolean [

	root := anObject.
	self resetOpened.
	anObject isNil
		ifTrue: [ ^ self ].
	aBoolean
		ifTrue: [ self addChild: root path: #() after: nil ]
		ifFalse: [ (self childrenFor: root)
				do: [ :ea | self addChild: ea path: #() after: nil ] ]
]

{ #category : #adding }
APTreeModel >> selectIndex: anIndex [

	self changed: #selection with: anIndex.
]

{ #category : #accessing }
APTreeModel >> showHeaders [ 

	^ showHeaders
]

{ #category : #accessing }
APTreeModel >> showHeaders: anObject [

	showHeaders := anObject
]

{ #category : #adding }
APTreeModel >> size [ 

	^ collection size
]

{ #category : #accessing }
APTreeModel >> useDefaultColumns [ 

	^ columns isEmpty
]
