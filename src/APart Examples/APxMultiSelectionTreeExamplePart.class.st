"
APxMultiSelectionTreeExamplePart demonstriert:
- Definition eines Baums mit Mehrfachselektion
- Reaktion auf Änderungen an der Mehrfachselektion
"
Class {
	#name : #APxMultiSelectionTreeExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'groupsTree',
		'selectedNodesList',
		'consolidatingSelections'
	],
	#category : #'APart Examples-MultiSelectionTree'
}

{ #category : #accessing }
APxMultiSelectionTreeExamplePart >> consolidatingSelections [

	^consolidatingSelections
]

{ #category : #accessing }
APxMultiSelectionTreeExamplePart >> consolidatingSelections: anObject [

	consolidatingSelections := anObject.
	self groupsTree executeTrigger: #selectionChanged.
]

{ #category : #'initialize-release' }
APxMultiSelectionTreeExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #consolidatingSelections;
		createAspectNamed: #groupsTree;
		createAspectNamed: #selectedNodesList
]

{ #category : #accessing }
APxMultiSelectionTreeExamplePart >> groupsTree [

	^groupsTree
]

{ #category : #accessing }
APxMultiSelectionTreeExamplePart >> groupsTree: anObject [

	groupsTree := anObject
]

{ #category : #'initialize-release' }
APxMultiSelectionTreeExamplePart >> initializeActions [

	partInterface description
		createAction: #deselectAll
		do: [groupsTree selectionIndexes: OrderedCollection new]
		if: (APCondition on: [groupsTree selection notNil] ifNot: #nothingSelected)
]

{ #category : #'initialize-release' }
APxMultiSelectionTreeExamplePart >> initializeValues [

	groupsTree := APartTree
				onPart: self
				key: #groupsTree
				preInit: [:ctx | ctx isMultiSelection: true].
	groupsTree
		trigger: #selectionChanged do: 
					[consolidatingSelections
						ifFalse: [selectedNodesList list: groupsTree selections]
						ifTrue: [selectedNodesList list: groupsTree consolidatedTopSelections]].
	groupsTree displayRoot: true.
	groupsTree root: APxTreeNode exampleTreeRoot.
	groupsTree getChildrenBlock: [:each | each children].
	selectedNodesList := APartList onPart: self
				key: #selectedNodesList.
	selectedNodesList
		setStatefulConditionOn: (APCondition on: [false] ifNot: #alwaysDisabled).
	consolidatingSelections := false
]

{ #category : #accessing }
APxMultiSelectionTreeExamplePart >> selectedNodesList [

	^selectedNodesList
]

{ #category : #accessing }
APxMultiSelectionTreeExamplePart >> selectedNodesList: anObject [

	selectedNodesList := anObject
]
