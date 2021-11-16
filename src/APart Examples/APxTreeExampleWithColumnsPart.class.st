Class {
	#name : #APxTreeExampleWithColumnsPart,
	#superclass : #APartExample,
	#instVars : [
		'groupsTree',
		'showOnlyGroups',
		'treeExampleAccessor'
	],
	#category : #'APart Examples-Tree with columns'
}

{ #category : #'initialize-release' }
APxTreeExampleWithColumnsPart >> defineAspects [

	partInterface description
		createAspectNamed: #showOnlyGroups;
		createAspectNamed: #groupsTree " redirectTo: #(#groupsTree #selectionInTree)"
]

{ #category : #accessing }
APxTreeExampleWithColumnsPart >> groupsTree [

	^groupsTree
]

{ #category : #'initialize-release' }
APxTreeExampleWithColumnsPart >> initializeActions [

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
APxTreeExampleWithColumnsPart >> initializeValues [

	| compositeColumn | 

	super initializeValues.
	groupsTree := APartTree onPart: self key: #groupsTree.
	
	compositeColumn := APTreeCompositeColumn new title: 'item'.
		compositeColumn addColumn: ((APTreeImageColumn title: 'icon' evaluated: [:item |
				item isGroup
					ifTrue: [self iconNamed: #glamorousOpen]
					ifFalse: [self iconNamed: #glamorousTable]])  width: 28; beNotExpandable;yourself).	
		compositeColumn addColumn: ((APTreeStringColumn title: 'text' evaluated: [:item | item name ])).

	groupsTree treeModel addColumn: compositeColumn.
	groupsTree treeModel addColumn: ((APTreeCheckBoxColumn title: 'Check' evaluated: [:item | true ]) onDeactivation: [:item | item inspect]).
	
	groupsTree treeModel addColumn: (APTreeStringColumn title: 'text' evaluated: [:item | item name ]).
	
"	groupsTree treeModel
		addColumn: compositeColumn;
		addColumn: (SpStringTableColumn 
			title: 'Number of subclasses' 
			evaluated: [ :class | class asString ])."
		
	groupsTree treeModel showHeaders: true.	
	
	groupsTree
		displayRoot: false;
		root: APxTreeNode exampleTreeRoot;
		getChildrenBlock: [:each | each children];
		itemStringRepresentationBlock: 
				[:item | item name asText allBold];
		itemIconRepresentationBlock: 
				[:item |
				item isGroup
					ifTrue: [self iconNamed: #glamorousOpen]
					ifFalse: [self iconNamed: #glamorousTable]];
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
APxTreeExampleWithColumnsPart >> showOnlyGroups [

	^showOnlyGroups
]

{ #category : #accessing }
APxTreeExampleWithColumnsPart >> showOnlyGroups: anObject [

	showOnlyGroups := anObject.
	groupsTree getChildrenBlock: (showOnlyGroups
				ifTrue: [[:treeNode | treeNode children reject: [:x | x children isEmpty]]]
				ifFalse: [[:treeNode | treeNode children]]).
	groupsTree treeModel refreshRoot.
	self rootUpdate
]

{ #category : #accessing }
APxTreeExampleWithColumnsPart >> treeExampleAccessor [

	^treeExampleAccessor
]

{ #category : #accessing }
APxTreeExampleWithColumnsPart >> treeExampleAccessor: anObject [

	treeExampleAccessor := anObject
]
