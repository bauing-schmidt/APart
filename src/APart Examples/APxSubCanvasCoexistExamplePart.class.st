"
APxSubCanvasCoexistExamplePart demonstriert:
- Koexistenz von Parts, deren Views dynamisch umgeschaltet werden
- Verbergen bzw. Anzeigen von Subviews als Reaktion der View-Seite auf das Aktivieren / Deaktivieren von Parts
"
Class {
	#name : #APxSubCanvasCoexistExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'groupsTree',
		'groupEditPart',
		'elementEditPart',
		'selectedItem'
	],
	#category : #'APart Examples-SubCanvasCoexist'
}

{ #category : #'initialize-release' }
APxSubCanvasCoexistExamplePart >> defineAspects [

	partInterface  description createAspectNamed: #groupsTree
]

{ #category : #accessing }
APxSubCanvasCoexistExamplePart >> elementEditPart [

	^elementEditPart
]

{ #category : #accessing }
APxSubCanvasCoexistExamplePart >> groupEditPart [

	^groupEditPart
]

{ #category : #accessing }
APxSubCanvasCoexistExamplePart >> groupsTree [

	^groupsTree
]

{ #category : #'initialize-release' }
APxSubCanvasCoexistExamplePart >> initializeActions [

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
									ifTrue: [elementEditPart reset]
									ifFalse: [groupEditPart reset].
								promptAnswer := true];
						trigger: #confirmNo do: [promptAnswer := false];
						openClientPrompt.
					promptAnswer]
				ifFalse: [true]]
]

{ #category : #'initialize-release' }
APxSubCanvasCoexistExamplePart >> initializeValues [

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
							ifTrue: [elementEditPart selectedElement: selectedItem]
							ifFalse: [groupEditPart selectedGroup: selectedItem]].
				self rootUpdate].
	elementEditPart := APxSubCanvasElementEditPart
				onPart: self
				key: #elementEditPart
				condition: (APCondition
						on: [selectedItem notNil and: [selectedItem isLeaf]]
						ifNot: #notALeaf).
	groupEditPart := APxSubCanvasGroupEditPart
				onPart: self
				key: #groupEditPart
				condition: (APCondition
						on: [selectedItem notNil and: [selectedItem isGroup]]
						ifNot: #notAGroup)
]

{ #category : #testing }
APxSubCanvasCoexistExamplePart >> isDirty [

	selectedItem := groupsTree selection.
	^selectedItem notNil and: 
			[selectedItem isLeaf
				ifTrue: [elementEditPart isDirty]
				ifFalse: [groupEditPart isDirty]]
]
