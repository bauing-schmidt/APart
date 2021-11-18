Extension { #name : #GtkTreeTableAdapter }

{ #category : #'*APart Patches' }
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

{ #category : #'*APart Patches' }
GtkTreeTableAdapter >> doRecreateStore: gtkTreeView [
	
	gtkTreeView model: (self newTreeStoreFrom: self items).

	"if we are working with Apart tree model, we want to restore the nodes expansion state"
	(self items noneSatisfy: [ :each | each isKindOf: APTreeNodeModel ]) 
		ifTrue: [ ^ true ].
		
	self items ifNotEmpty: [
		self recalculatePaths: self rootNode].
	self expandOpenNodes: self items.
]
