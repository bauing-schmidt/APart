"
APxTreeExamplePart demonstriert:
- Verwendung eines APartTree für hierarchische Daten in einem Baum
- Ändern der Selektion im Baum
- Adressieren von Elementen im Baum
- Enablement des Baums
- Ändern des Knotenumfangs
- Ändern von Konten im Baum
"
Class {
	#name : #APxTreeExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'groupsTree',
		'showOnlyGroups',
		'treeExampleAccessor'
	],
	#category : #'APart Examples-Tree'
}

{ #category : #'initialize-release' }
APxTreeExamplePart >> defineAspects [

	partInterface description
		createAspectNamed: #showOnlyGroups;
		createAspectNamed: #groupsTree " redirectTo: #(#groupsTree #selectionInTree)"
]

{ #category : #accessing }
APxTreeExamplePart >> groupsTree [

	^groupsTree
]

{ #category : #'initialize-release' }
APxTreeExamplePart >> initializeActions [

	partInterface description
		createAction: #removeSelection
		do: 
			[| parent |
			parent := groupsTree selection parent.
			parent removeChild: groupsTree selection.
			groupsTree treeModel removeAt: groupsTree selectionIndex.
			groupsTree treeModel refresh: parent]
		if: (APCondition
				on: [groupsTree selection notNil]
				ifNot: #nothingOrRootSelected).
	partInterface description createAction: #selectNext
		do: 
			[| currentIndex leveChildren |
			currentIndex := groupsTree selectionIndex.
			leveChildren := groupsTree treeModel childrenAt: currentIndex.
			currentIndex last >= leveChildren size
				ifTrue: [groupsTree selectionIndex: currentIndex allButLast, { 1 } ]
				ifFalse: [groupsTree selectionIndex: currentIndex allButLast, { currentIndex last + 1 }].
			].
	partInterface description createAction: #selectPrevious
		do: 
			[| currentIndex leveChildren |
			currentIndex := groupsTree selectionIndex.
			leveChildren := groupsTree treeModel childrenAt: currentIndex.
			currentIndex last = 1
				ifTrue: [groupsTree selectionIndex: currentIndex allButLast, { leveChildren size } ]
				ifFalse: [groupsTree selectionIndex: currentIndex allButLast, { currentIndex last - 1 }].
			].
	partInterface description createAction: #replaceTree
		do: 
			[| treeRoot |
			treeExampleAccessor == #exampleTreeRoot
				ifTrue: 
					[treeRoot := APxTreeNode exampleTreeRoot2.
					treeExampleAccessor := #exampleTreeRoot2]
				ifFalse: 
					[treeRoot := APxTreeNode exampleTreeRoot.
					treeExampleAccessor := #exampleTreeRoot].
			groupsTree root: treeRoot.
			groupsTree treeModel refreshRoot.
			groupsTree treeModel expandFully: 1.
			groupsTree selectionIndex: 3]
]

{ #category : #'initialize-release' }
APxTreeExamplePart >> initializeValues [

	super initializeValues.
	groupsTree := APartTree onPart: self key: #groupsTree.
	groupsTree
		displayRoot: false;
		root: APxTreeNode exampleTreeRoot;
		getChildrenBlock: [:each | each children];
		itemStringRepresentationBlock: 
				[:item | item name asText allBold];
		itemIconRepresentationBlock: 
				[:item |
				item isGroup
					ifTrue: [self iconNamed: #linkeddocs]
					ifFalse: [self iconNamed: #projektkarte_blau]];
		trigger: #selectionChanged
			do: 
				[Transcript
					show: groupsTree selection displayString;
					show: ' selected';
					cr];
		trigger: #doubleClick
			do: 
				[(APWarningPrompt onPart: self key: #warning)
					title: #DoubleClicked;
					message: groupsTree selection asString;
					openClientPrompt];
		trigger: #itemExpanded
			withArgumentDo: 
				[:arg |
				Transcript
					show: 'Item Expanded: ' , arg asString;
					cr];
		trigger: #itemCollapsed
			withArgumentDo: 
				[:arg |
				Transcript
					show: 'Item Collapsed: ' , arg asString;
					cr].
	treeExampleAccessor := #exampleTreeRoot
]

{ #category : #accessing }
APxTreeExamplePart >> showOnlyGroups [

	^showOnlyGroups
]

{ #category : #accessing }
APxTreeExamplePart >> showOnlyGroups: anObject [

	showOnlyGroups := anObject.
	groupsTree getChildrenBlock: (showOnlyGroups
				ifTrue: [[:treeNode | treeNode children reject: [:x | x children isEmpty]]]
				ifFalse: [[:treeNode | treeNode children]]).
	groupsTree treeModel refreshRoot.
	self rootUpdate
]

{ #category : #accessing }
APxTreeExamplePart >> treeExampleAccessor [

	^treeExampleAccessor
]

{ #category : #accessing }
APxTreeExamplePart >> treeExampleAccessor: anObject [

	treeExampleAccessor := anObject
]
