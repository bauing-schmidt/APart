"
APxSubCanvasPartSwitchExamplePart demonstriert:
- Einsatz eines APSwitchingPart zum Umschalten zwischen verschiedenen Sub-Parts
"
Class {
	#name : #APxSubCanvasPartSwitchExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'demoSwitchingPart'
	],
	#category : #'APart Examples-SubCanvasPartSwitch'
}

{ #category : #accessing }
APxSubCanvasPartSwitchExamplePart >> demoSwitchingPart [

	^demoSwitchingPart
]

{ #category : #'initialize-release' }
APxSubCanvasPartSwitchExamplePart >> initializeActions [

	partInterface description
		createAction: #switchToTreeView
		do: [demoSwitchingPart currentPartKey: #treeView]
		if: (APCondition on: [demoSwitchingPart currentPartKey ~= #treeView]
				ifNot: #alreadyInTreeView).
	partInterface description
		createAction: #switchToListView
		do: [demoSwitchingPart currentPartKey: #listView]
		if: (APCondition on: [demoSwitchingPart currentPartKey ~= #listView]
				ifNot: #alreadyInListView).
	partInterface description
		createAction: #switchToNoView
		do: [demoSwitchingPart currentPartKey: nil]
		if: (APCondition on: [demoSwitchingPart currentPartKey ~= nil]
				ifNot: #alreadyInNoView)
]

{ #category : #'initialize-release' }
APxSubCanvasPartSwitchExamplePart >> initializeValues [

	super initializeValues.
	demoSwitchingPart := APSwitchingPart onPart: self key: #demoSwitchingPart.
	demoSwitchingPart
		add: #treeView
		class: APartTree
		postInit: 
			[:gtc |
			gtc displayRoot: true.
			gtc root: APxTreeNode exampleTreeRoot.
			gtc getChildrenBlock: [:each | each children]].
	demoSwitchingPart
		add: #listView
		class: APartList
		postInit: [:glc | glc list: APxTreeNode exampleTreeRoot bottomChildren]
]
