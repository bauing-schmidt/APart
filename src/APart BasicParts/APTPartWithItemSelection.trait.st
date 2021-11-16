"
Use me for selections based on item identity only, there are no indexes available. The selection may be configured such that it allows single or multi selection or both, depending on called API.
"
Trait {
	#name : #APTPartWithItemSelection,
	#instVars : [
		'permitMultiSelection',
		'selectedItems'
	],
	#category : #'APart BasicParts'
}

{ #category : #'API selection' }
APTPartWithItemSelection >> deselectAllItems [

	selectedItems do: [:item | self deselectItem: item]
]

{ #category : #'API selection' }
APTPartWithItemSelection >> deselectAllItemsDoing: doBlock [

	selectedItems do: [:item | 
		self deselectItem: item.
		doBlock value: item
	]
]

{ #category : #'API selection' }
APTPartWithItemSelection >> deselectItem: appItem [

	^self deselectItem: appItem doing: nil

]

{ #category : #'API selection' }
APTPartWithItemSelection >> deselectItem: appItem doing: itemBlock [

	^ (selectedItems remove: appItem ifAbsent: []) ifNotNil: [:item |
		item isSelected: false.
		itemBlock ifNotNil: [itemBlock value: item].
		true
	] ifNil: [
		false
	]

]

{ #category : #'API selection' }
APTPartWithItemSelection >> hasSingleSelection [
	
	^selectedItems size = 1
]

{ #category : #'API selection' }
APTPartWithItemSelection >> hasSingleSelection: appItem [
	
	^selectedItems size = 1 and: [selectedItems anyOne = appItem]

]

{ #category : #initialization }
APTPartWithItemSelection >> initializeSelection [

	selectedItems := IdentitySet new.
]

{ #category : #'API selection' }
APTPartWithItemSelection >> moveSelectionTo: appItem deselectDoing: deselectDoBlock selectDoing: selectDoBlock [

	(appItem isNil or: [appItem isSelected])
		ifTrue: [ ^ nil ].
	self
		deselectAllItemsDoing: deselectDoBlock;
	 	selectItem: appItem doing: selectDoBlock.
	^ appItem
]

{ #category : #'API selection' }
APTPartWithItemSelection >> multiSelection [
	"Array or nil"
	
	^self permitMultiSelection ifTrue: [selectedItems ifNotEmpty: [selectedItems asArray]]
]

{ #category : #accessing }
APTPartWithItemSelection >> permitMultiSelection [

	^ permitMultiSelection ifNil: [false]
]

{ #category : #accessing }
APTPartWithItemSelection >> permitMultiSelection: anObject [

	permitMultiSelection := anObject
]

{ #category : #'API selection' }
APTPartWithItemSelection >> selectAllItems: itemColl [

	permitMultiSelection
		ifFalse: [self pdmError: #MultiSelectionNotPermittedForPart].
	selectedItems do: [ :currentSelectedItem | 
		"we need to repaint the old selection"
		currentSelectedItem prepareHierarchyForRebuild
	].
	selectedItems := itemColl.


]

{ #category : #'API selection' }
APTPartWithItemSelection >> selectItem: appItem [

	^self selectItem: appItem doing: appItem onSelectionBlock

]

{ #category : #'API selection' }
APTPartWithItemSelection >> selectItem: appItem doing: itemBlock [

	(selectedItems includes: appItem)
		ifTrue: [^false].
	selectedItems add: appItem.
	appItem isSelected: true.
	itemBlock ifNotNil: [itemBlock value: appItem].
	self holdSelectionChangedTrigger
		ifFalse: [self partInterface executeTrigger: #selectionChanged].
	^true


]

{ #category : #'API selection' }
APTPartWithItemSelection >> selectionCollection [
	"Universal answer for all types of selection"
	
	^selectedItems asArray
]

{ #category : #'API selection' }
APTPartWithItemSelection >> singleSelection [

	^self hasSingleSelection ifTrue: [selectedItems anyOne]
]
