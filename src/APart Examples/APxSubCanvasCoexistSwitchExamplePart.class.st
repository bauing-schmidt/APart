"
APxSubCanvasCoexistSwitchExamplePart demonstrates using APSwitchingPart to provide an active part concept, with support to aspect and action paths.
"
Class {
	#name : #APxSubCanvasCoexistSwitchExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'groupsTree',
		'groupEditPart',
		'elementEditPart',
		'selectedItem',
		'switchingPart'
	],
	#category : #'APart Examples-SubCanvasCoexistSwitch'
}

{ #category : #'initialize-release' }
APxSubCanvasCoexistSwitchExamplePart >> defineAspects [

	partInterface description
		createAspectNamed: #groupsTree;
		createAspectNamed: #switchingPartName redirectTo: #(#switchingPart #name)
]

{ #category : #accessing }
APxSubCanvasCoexistSwitchExamplePart >> elementEditPart [

	^switchingPart subPartAt: #elementEditPart ifNone: []
]

{ #category : #accessing }
APxSubCanvasCoexistSwitchExamplePart >> groupEditPart [

	^switchingPart subPartAt: #groupEditPart ifNone: []
]

{ #category : #accessing }
APxSubCanvasCoexistSwitchExamplePart >> groupsTree [

	^groupsTree
]

{ #category : #'initialize-release' }
APxSubCanvasCoexistSwitchExamplePart >> initializeActions [

	self trigger: #requestForClose
		do: 
			[| promptAnswer |
			self isDirty
				ifTrue: 
					[(APConfirmationYesNo onPart: self)
						title: #DatenVerwerfen;
						message: #FrageDatenVerwerfen;
						trigger: #confirmYes
							do: 
								[selectedItem isLeaf
									ifTrue: [self elementEditPart reset]
									ifFalse: [self groupEditPart reset].
								promptAnswer := true];
						trigger: #confirmNo do: [promptAnswer := false];
						openClientPrompt.
					promptAnswer]
				ifFalse: [true]]
]

{ #category : #'initialize-release' }
APxSubCanvasCoexistSwitchExamplePart >> initializeValues [

	super initializeValues.
	groupsTree := APartTree onPart: self key: #groupsTree.
	groupsTree
		displayRoot: false;
		root: APxTreeNode exampleTreeRoot;
		getChildrenBlock: [:each | each children];
		trigger: #requestSelectionChange
			do: 
				[| promptAnswer |
				self isDirty
					ifTrue: 
						[(APConfirmationYesNo onPart: self)
							title: #DatenVerwerfen;
							message: #FrageDatenVerwerfen;
							trigger: #confirmYes do: [promptAnswer := true];
							trigger: #confirmNo do: [promptAnswer := false];
							openClientPrompt.
						promptAnswer]
					ifFalse: [true]];
		trigger: #selectionChanged
			do: 
				[selectedItem := groupsTree selection.
				selectedItem notNil
					ifTrue: 
						[selectedItem isLeaf
							ifTrue: 
								[self elementEditPart selectedElement: selectedItem.
								switchingPart currentPartKey: #elementEditPart]
							ifFalse: 
								[self groupEditPart selectedGroup: selectedItem.
								switchingPart currentPartKey: #groupEditPart]]
					ifFalse: [switchingPart currentPartKey: nil].
				self rootUpdate].
	switchingPart := APSwitchingPart onPart: self key: #switchingPart.
	switchingPart releaseInactivePart: false.
	APxSubCanvasElementEditPart onPart: switchingPart key: #elementEditPart.
	APxSubCanvasGroupEditPart onPart: switchingPart key: #groupEditPart
]

{ #category : #testing }
APxSubCanvasCoexistSwitchExamplePart >> isDirty [

	selectedItem := groupsTree selection.
	^selectedItem notNil and: 
			[selectedItem isLeaf
				ifTrue: [self elementEditPart isDirty]
				ifFalse: [self groupEditPart isDirty]]
]

{ #category : #accessing }
APxSubCanvasCoexistSwitchExamplePart >> switchingPart [

	^switchingPart
]
