Class {
	#name : #GtkAPartTreeTableAdapter,
	#superclass : #GtkTreeTableAdapter,
	#category : #'APart Pharo'
}

{ #category : #building }
GtkAPartTreeTableAdapter >> addModelTo: gtkTreeView [

	(self identityHash ->widget) traceCrAs: #addModelTo.
	^ super addModelTo: gtkTreeView.
]

{ #category : #building }
GtkAPartTreeTableAdapter >> connectToGtkSignals: gtkWidget [
	
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

{ #category : #private }
GtkAPartTreeTableAdapter >> doRecreateStore: gtkTreeView [

	gtkTreeView model: (self newTreeStoreFrom: self items).

	"if we are working with Apart tree model, we want to restore the nodes expansion state"
	(self items noneSatisfy: [ :each | each isKindOf: APTreeNodeModel ]) 
		ifTrue: [ ^ true ].
	
	GRunLoop forceDefer: [ 
		widget ifNotNil: [ 
	self items ifNotEmpty: [
		self recalculatePaths: self rootNode].
	self expandOpenNodes: self items. ] ].
]

{ #category : #releasing }
GtkAPartTreeTableAdapter >> unsubscribe [

	| aSelection |
	
	(self identityHash ->widget) traceCrAs: #unsubscribe.

	self unsubscirbeSelectionMode.
	aSelection := self presenter selection observablePropertyNamed: #selection.
	aSelection
		unsubscribe: self";
		unsubscribeOuterContextReceiver: self". 
	(self presenter observablePropertyNamed: #roots) unsubscribe: self.
	(self presenter observablePropertyNamed: #showColumnHeaders) 
		unsubscribe: self.
	super unsubscribe.
	
	widget := nil.
]

{ #category : #updating }
GtkAPartTreeTableAdapter >> updatePresenterSelection [
	
	self innerWidgetDo: [ :w |
		self rowsSelected: w allSelected ]
]
