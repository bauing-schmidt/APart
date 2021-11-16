Class {
	#name : #ApedColumnsEditorPart,
	#superclass : #APart,
	#traits : 'APTRootPart + APTPartWithLocale',
	#classTraits : 'APTRootPart classTrait + APTPartWithLocale classTrait',
	#instVars : [
		'columnsTree',
		'currentColumn',
		'currentColumnSwitchingPart'
	],
	#category : #'APart Form Editor-Columns'
}

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> addColumnOf: columnClass [

	| newColumn anId |
	
	anId := UUID new.
	
	newColumn := columnClass onPart: currentColumnSwitchingPart key: anId.
	
	self announce: (ApedAddColumnAnnouncement new
		newColumn: newColumn;
		parentColumn: nil).
		
	self privAddColumn: newColumn to: nil.
	
	columnsTree refresh.
	
	^ newColumn
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> currentColumn [
	^ currentColumn
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> currentColumnSwitchingPart [

	^ currentColumnSwitchingPart
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> defineAspects [

	partInterface description createAspectNamed: #columnsTree.
	partInterface description createAspectNamed: #currentColumn.
	partInterface description createAspectNamed: #currentColumnSwitchingPart.
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> initializeActions [ 

	partInterface description createAction: #addStringColumn do: [ 
		self addColumnOf: ApedStringColumnPart ] if: (APCondition true).
	partInterface description createAction: #addImageColumn do: [ 
		self addColumnOf: ApedImageColumnPart ] if: (APCondition true).
	partInterface description createAction: #addCheckBoxColumn do: [ 
		self addColumnOf: ApedCheckBoxColumnPart ] if: (APCondition true).
	partInterface description createAction: #addCompositeColumn do: [ 
		self addColumnOf: ApedCompositeColumnPart ] if: (APCondition true).
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> initializeValues [

	columnsTree := APartTree onPart: self key: #columnsTree.
	columnsTree 
		displayRoot: true;
		root: (ApedRootLayoutTreeNodeModel new);
		getChildrenBlock: [:each | each children].
		
	columnsTree
		itemStringRepresentationBlock: [:each | each value labelString];
"		itemIconRepresentationBlock: [:item ||icon| 
			icon := self getIconForLayout: item value.	
			self iconNamed: icon];"
		trigger: #selectionChanged
			do: [ self switchCurrentColumnToSelection ].

	currentColumn := ApedLayoutPart onPart: self key: #currentColumn.
		
	currentColumnSwitchingPart := APSwitchingPart onPart: self key: #currentColumnSwitchingPart.
	currentColumnSwitchingPart releaseInactivePart: false.
	currentColumnSwitchingPart addSubPart: currentColumn  key: #current.
	currentColumnSwitchingPart privCurrentPartKey: #current.
	
"	self whenColumnAdded: [ :announcement |
		form privAddLayout: announcement newLayout to: announcement parentLayout layoutChild: announcement layoutChild.
		]."
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> privAddColumn: newColumn to: parentColumn [

	| newChildModel |
	
	newChildModel := (ApedLayoutTreeNodeModel new)
				value: newColumn; 			
				yourself.
				
	parentColumn 
		ifNil: [ columnsTree root addChild: newChildModel ]
		ifNotNil: [ (columnsTree treeModel nodeModelFor: parentColumn) addChild: newChildModel. 
			newChildModel parent opened: true].
		
	newColumn children do: [ :aChild |
		self privAddColumn: aChild to: columnsTree ].
		
	^ columnsTree
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> switchCurrentColumnToSelection [

	| selectedPart | 
	
	selectedPart := columnsTree selection.
	
	selectedPart ifNil: [ ^ self ].
	
	currentColumn := selectedPart.
	currentColumn memento: selectedPart copy.
	
	currentColumnSwitchingPart forceSwitchToPart: currentColumn.
		
"	self selectElementForLayout: selectedPart"
]

{ #category : #'initialize-release' }
ApedColumnsEditorPart >> whenColumnAdded: aBlock [ 

	self announcer announcer
		when: ApedAddColumnAnnouncement
		do: aBlock
]
