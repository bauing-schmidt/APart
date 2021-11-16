"
APInterfaceListAspectBuilder ist die spezielle Builder-Klasse für Subklassen von APartList.
"
Class {
	#name : #APInterfaceListAspectBuilder,
	#superclass : #APInterfaceAspectBuilder,
	#category : #'APart BasicParts'
}

{ #category : #API }
APInterfaceListAspectBuilder >> aspectBuildRedirectionKey [

	^#selectionInList
]

{ #category : #API }
APInterfaceListAspectBuilder >> createListWithMultiSelectionModel [

	| selInList |
	selInList := (APListSelectionMulti new)
				selectionIndexHolder: (self createAdaptorWithSubjectFor: #selectionIndexes);
				yourself.
	self createStandardAspectsForSelectionInList: selInList.
	^selInList
]

{ #category : #API }
APInterfaceListAspectBuilder >> createListWithSingleSelectionModel [

	| selInList |
	selInList := (APListSelection new)
				selectionIndexHolder: (self createAdaptorWithSubjectFor: #selectionIndex);
				yourself.
	self createStandardAspectsForSelectionInList: selInList.
	^selInList
]

{ #category : #API }
APInterfaceListAspectBuilder >> createStandardAspectsForSelectionInList: selInList [

	selInList
		listHolder: (self setSubjectInAdaptor: (APAspectAdaptor forAspect: #list)).
	interface description
		createAspectNamed: #listHolder use: selInList listHolder;
		createAspectNamed: #selectionIndexHolder
			use: selInList selectionIndexHolder;
		createAspectNamed: #selection
			use: (self createAdaptorWithSubjectFor: #selection).
	^selInList
]

{ #category : #API }
APInterfaceListAspectBuilder >> postBuildComponentKey: aListViewKey in: aView [

	aView installRequestSelectionChangedActionFrom: interface
		forSequenceViewKey: aListViewKey.
	aView installDoubleClickActionFrom: interface forSequenceViewKey: aListViewKey.
	aView installRightClickActionFrom: interface forSequenceViewKey: aListViewKey.
	aView installFocusInActionFrom: interface forSequenceViewKey: aListViewKey.
	self partKey = aListViewKey
		ifTrue: [self updateListItemRepresentationFor: aListViewKey in: aView]
]

{ #category : #API }
APInterfaceListAspectBuilder >> updateListItemRepresentationFor: aListViewKey in: aView [

	| clientsToUpdate |
	clientsToUpdate := aView notNil
				ifTrue: [IdentitySet with: aView]
				ifFalse: [IdentitySet withAll: self registeredClients].
	clientsToUpdate do: 
			[:client |
			client
				itemStringRepresentationBlock: self part itemStringRepresentationBlock
				itemIconRepresentationBlock: self part itemIconRepresentationBlock
				forListViewKey: aListViewKey]
]
