"
The following comment was copied from the original comments of ExampleTreeNode

==========================================================

ExampleTreeNode dient als TreeNode in verschiedenen Beispielen.
"
Class {
	#name : #APxTreeNode,
	#superclass : #APTreeNodeModel,
	#instVars : [
		'name'
	],
	#category : #'APart Examples-Support'
}

{ #category : #'instance creation' }
APxTreeNode class >> deepFromDescriptionArray: aDescriptionArray [

	| result |
	(aDescriptionArray size between: 1 and: 2) ifFalse: [self error: 'error in description array size'].
	result := (self new)
				name: aDescriptionArray first;
				yourself.
	aDescriptionArray size = 1 ifTrue: [^result].
	(aDescriptionArray at: 2)
		do: [:each | result addChild: (self deepFromDescriptionArray: each)].
	^result
]

{ #category : #'instance creation' }
APxTreeNode class >> deepFromDescriptionArray: aDescriptionArray on: aPart [

	| result |
	(aDescriptionArray size between: 1 and: 2) ifFalse: [self error: 'error in description array size'].
	result := (self new)
				name: aDescriptionArray first;
				yourself.
	aDescriptionArray size = 1 ifTrue: [^result].
	(aDescriptionArray at: 2)
		do: [:each | result addChild: (self deepFromDescriptionArray: each on: aPart)].
	^result
]

{ #category : #'instance creation' }
APxTreeNode class >> exampleTreeRoot [
	"self exampleTreeRoot"
	| treeDescriptionArray |
	treeDescriptionArray := #('Root'
		#(
			#('Element 0')
			#( 'Group 1' 
				#(
					#('Element 1-1') 
					#('Element 2-1')
				)
			)
			#( 'Group 2' 
				#(
					#('Element 2-1')
					#('Element 2-2')
					#('Group 2-1' 
						#(
							#('Element 2-1-1')
							#('Element 2-1-2')
						)
					)
				)
			)
			#( 'Group 3' 
				#(
					#('Group 3-1' 
						#(
							#('Group 3-1-1' 
								#(
									#('Element 3-1-2-1')
								)
							)
							#('Element 3-1-2')
						)
					)
				)
			)
		)
	).
	
	^self deepFromDescriptionArray: treeDescriptionArray.
]

{ #category : #'instance creation' }
APxTreeNode class >> exampleTreeRoot2 [
	"self exampleTreeRoot2"
	| treeDescriptionArray |
	treeDescriptionArray := #('Root'
		#(
			#('Group 1'
				#( 
					#( 'Group 2' 
						#(
							#('Group 3'
								#(
									#('Element 1')
								)
							) 
						)
					)
				)
			)
		)
	).
	
	
	^self deepFromDescriptionArray: treeDescriptionArray.
]

{ #category : #accessing }
APxTreeNode >> addChild: aChild [

	children add: aChild.
	aChild parent: self.
]

{ #category : #accessing }
APxTreeNode >> bottomChildren [

	| bottomChildren |
	bottomChildren := OrderedCollection new.
	self deepChildrenDo: [ :aChild | aChild children isEmpty ifTrue: [bottomChildren add: aChild]].
	^bottomChildren.
]

{ #category : #accessing }
APxTreeNode >> deepChildrenDo: aBlock [

	aBlock value: self.
	self children do: [ : aChild | aChild deepChildrenDo: aBlock]
]

{ #category : #printing }
APxTreeNode >> displayString [

	^name
]

{ #category : #'initialize-release' }
APxTreeNode >> initialize [
	"Initialize a newly created instance. This method must answer the receiver."

	super initialize.
	name := nil.
	^self
]

{ #category : #testing }
APxTreeNode >> isGroup [

	^children notEmpty
]

{ #category : #testing }
APxTreeNode >> isLeaf [

	^children isEmpty
]

{ #category : #accessing }
APxTreeNode >> name [

	^name
]

{ #category : #accessing }
APxTreeNode >> name: aValue [

	name := aValue
]

{ #category : #printing }
APxTreeNode >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: name;
		nextPutAll: ' ,';
		nextPutAll: children size asString;
		nextPutAll: ' children)'
]

{ #category : #accessing }
APxTreeNode >> value [ 

	^ self name
]
