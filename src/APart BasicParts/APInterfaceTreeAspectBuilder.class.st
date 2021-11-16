"
APInterfaceTreeAspectBuilder ist die spezielle Builder-Klasse für Subklassen von APartTree.
"
Class {
	#name : #APInterfaceTreeAspectBuilder,
	#superclass : #APInterfaceAspectBuilder,
	#category : #'APart BasicParts'
}

{ #category : #API }
APInterfaceTreeAspectBuilder >> aspectBuildRedirectionKey [

	^#selectionInTree
]

{ #category : #API }
APInterfaceTreeAspectBuilder >> createStandardAspectsForSelectionInTree: selInTree [

	selInTree listHolder: (self
				setSubjectInAdaptor: (APAspectAdaptor forAspect: #treeModel)).
	interface description
		createAspectNamed: #listHolder use: selInTree listHolder;
		createAspectNamed: #selectionIndexHolder
			use: selInTree selectionIndexHolder;
		yourself.
	"createAspectNamed: #selection
			use: (self createAdaptorWithSubjectFor: #selection);"
	^selInTree
]

{ #category : #API }
APInterfaceTreeAspectBuilder >> createTreeWithMultiSelectionModel [

	| selInTree |
	selInTree := (APTreeSelectionMulti new)
				selectionIndexHolder: (self createAdaptorWithSubjectFor: #selectionIndexes);
				yourself.
	self createStandardAspectsForSelectionInTree: selInTree.
	^selInTree
]

{ #category : #API }
APInterfaceTreeAspectBuilder >> createTreeWithSingleSelectionModel [

	| selInTree |
	selInTree := (APTreeSelection new)
				selectionIndexHolder: (self createAdaptorWithSubjectFor: #selectionIndex);
				yourself.
	self createStandardAspectsForSelectionInTree: selInTree.
	^selInTree
]

{ #category : #API }
APInterfaceTreeAspectBuilder >> postBuildComponentKey: aTreeViewKey in: aView [

	^ APartPlatform current postBuildTreeKey: aTreeViewKey in: aView interface: interface builder: self
]

{ #category : #API }
APInterfaceTreeAspectBuilder >> updateTreeItemRepresentationFor: aTreeViewKey in: aView [

	| clientsToUpdate |
	clientsToUpdate := aView notNil
				ifTrue: [IdentitySet with: aView]
				ifFalse: [IdentitySet withAll: self registeredClients].
	clientsToUpdate do: 
			[:client |
			client
				itemStringRepresentationBlock: self part itemStringRepresentationBlock
				itemIconRepresentationBlock: self part itemIconRepresentationBlock
				forTreeViewKey: aTreeViewKey]
]
