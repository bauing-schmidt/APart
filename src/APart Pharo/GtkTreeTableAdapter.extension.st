Extension { #name : #GtkTreeTableAdapter }

{ #category : #'*APart Pharo' }
GtkTreeTableAdapter >> connectToGtkSignals: gtkWidget [
	
	gtkWidget connectSelectionChanged: [ 
		self backendUpdatingDo: [ 
			self updatePresenterSelection ] ].
	gtkWidget connectRowActivated: [ :path | 
		self presenter doActivateAtPath: path toArray ].
	
	"if we are working with Apart tree model, we want to inform it about the nodes expansion state to preserve it during model change"
	(self model isKindOf: APartTreeTablePresenter)
		ifFalse: [ ^ true ].
	
	gtkWidget connectRowExpanded: [ :iter :path | (self rootNode childAt: path) opened: true ].
	gtkWidget connectRowCollapsed: [ :iter :path | (self rootNode childAt: path) opened: false ]
]

{ #category : #'*APart Pharo' }
GtkTreeTableAdapter >> doRecreateStore: gtkTreeView [
	
	gtkTreeView model: (self newTreeStoreFrom: self items).

	"if we are working with Apart tree model, we want to restore the nodes expansion state"
	(self items noneSatisfy: [ :each | each isKindOf: APTreeNodeModel ]) 
		ifTrue: [ ^ true ].
		
	self items ifNotEmpty: [
		self recalculatePaths: self rootNode].
	self expandOpenNodes: self items.
]

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
