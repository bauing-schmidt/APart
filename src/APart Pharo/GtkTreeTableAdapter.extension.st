Extension { #name : #GtkTreeTableAdapter }

{ #category : #'*APart Pharo' }
GtkTreeTableAdapter >> expandOpenNodes: nodeColl [

	nodeColl do:[:node| node opened ifTrue:[self expandPath: node path. 
		node children ifNotEmpty: [:c| self expandOpenNodes: c ]]]
]

{ #category : #'*APart Pharo' }
GtkTreeTableAdapter >> recalculatePaths: node [

	node parent ifNil:[node path: #()].
	node children doWithIndex:[:c :i| c path: (c parent path copyWith: i). c children ifNotEmpty:[ self recalculatePaths: c] ]
]

{ #category : #'*APart Pharo' }
GtkTreeTableAdapter >> rootNode [

	^self items first parent 
]
