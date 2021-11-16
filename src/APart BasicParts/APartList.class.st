"
APartList repräsentiert ein generisch verwendbares Listenmodell.
"
Class {
	#name : #APartList,
	#superclass : #APartAbstractSequence,
	#instVars : [
		'list'
	],
	#category : #'APart BasicParts'
}

{ #category : #private }
APartList class >> interfaceClass [

	^APListInterface
]

{ #category : #API }
APartList >> add: anEntry [

	| oldSelections |
	oldSelections := self selections.
	list add: anEntry.
	self list: list.
	self selections: oldSelections.
]

{ #category : #API }
APartList >> addAll: objCol [

	| oldSelections |
	oldSelections := self selections.
	list addAll: objCol.
	self list: list.
	self selections: oldSelections.
]

{ #category : #API }
APartList >> addAll: objCol after: anObject [

	| oldSelections |
	oldSelections := self selections.
	objCol reverseDo: [: obj | list add: obj after: anObject].
	self list: list.
	self selections: oldSelections.
]

{ #category : #API }
APartList >> adjustSelectionOn: otherListContext [

	self selections: otherListContext selections
]

{ #category : #API }
APartList >> aspectBuilderClass [

	^APInterfaceListAspectBuilder
]

{ #category : #SelectionInList }
APartList >> at: anIndex [

	^ list at: anIndex
]

{ #category : #'initialize-release' }
APartList >> defineAspects [

	| selInList |
	partInterface usePartChannel.
	selInList := partInterface createListHolderAspectNamed: #selectionInList
				build: 
					[:builder |
					self isMultiSelection
						ifTrue: [builder createListWithMultiSelectionModel]
						ifFalse: [builder createListWithSingleSelectionModel]].
	partInterface  description createAllAspectsNamed: #(#displayList #selectionDisplay).
	^selInList
]

{ #category : #'combobox-supprt' }
APartList >> displayList [

	^self list collect: 
			[:each |
			itemStringRepresentationBlock
				ifNil: [each displayString]
				ifNotNil: [:b | b value: each]]
]

{ #category : #accessing }
APartList >> doWithIndex: aBlock [ 

	list doWithIndex: aBlock 

]

{ #category : #'API aspects' }
APartList >> exposeListAspect [

	self parentInterface description createAspectNamed: key
]

{ #category : #SelectionInList }
APartList >> indexOf: anObject [

	^ list indexOf: anObject
]

{ #category : #'initialize-release' }
APartList >> initializeValues [

	list := OrderedCollectionWithDependants new.
	super initializeValues.
]

{ #category : #'API inspector' }
APartList >> inspectorSubObjectList [

	^OrderedCollectionWithDependants with: #OrderedCollectionWithDependants -> list
]

{ #category : #API }
APartList >> itemCount [

	^list size
]

{ #category : #accessing }
APartList >> itemStringRepresentationBlock [
		
	^ itemStringRepresentationBlock
]

{ #category : #accessing }
APartList >> itemStringRepresentationBlock: anObject [

	itemStringRepresentationBlock := anObject.
	partInterface aspectBuilder updateListItemRepresentationFor: self listKey
		in: nil
]

{ #category : #SelectionInList }
APartList >> list [

	^list
]

{ #category : #SelectionInList }
APartList >> list: aList [

	"#listHolder aspect update should not be held until the end of the current execution, otherwise a selection index that is set afterward will be reset"
	list := aList.
	selectionIndex := 0.
	selectionIndexes := OrderedCollection new.
	partInterface
		changedAspectValue: #listHolder
		suppressListeners: false
		bypassUpdatesHold: true.
	self changedAspectValues: #(#selectionDisplay #displayList)
]

{ #category : #API }
APartList >> listKey [

	^key
]

{ #category : #'initialize-release' }
APartList >> release [

	super release.
	list := nil.
]

{ #category : #API }
APartList >> removeAll [ 

	self removeAllSuchThat: [ :each | true ]
]

{ #category : #API }
APartList >> removeAll: aCollection [

	| oldSelections |
	oldSelections := self selections.
	[list removeAll: aCollection] ensure: 
			[self list: list.
			self selections: (oldSelections reject: [:e | aCollection includes: e])]
]

{ #category : #API }
APartList >> removeAll: aCollection ifAbsent: aBlock [

	| oldSelections |
	oldSelections := self selections.
	[list removeAll: aCollection ifAbsent: aBlock] ensure: 
			[self list: list.
			self selections: (oldSelections reject: [:e | aCollection includes: e])]
]

{ #category : #API }
APartList >> removeAllSuchThat: aBlock [

	| oldSelections |
	oldSelections := self selections.
	[list removeAllSuchThat: aBlock] ensure: 
			[self list: list.
			self selections: (oldSelections reject: [:e | aBlock value: e])]
]

{ #category : #'initialize-release' }
APartList >> revert [ 
	
	"do nothing, for API compatibility with the APartFilteredList"
]

{ #category : #'combobox-supprt' }
APartList >> selectionDisplay [

	^itemStringRepresentationBlock
		ifNil: [self selection displayString]
		ifNotNil: [:b | b value: self selection]
]

{ #category : #'combobox-supprt' }
APartList >> selectionDisplay: aString [

	self isMultiSelection
		ifTrue: [self error: 'calling selectionDisplay on a multi selection list'].
	^self selectionIndex: (self displayList indexOf: aString ifAbsent: [0])
]

{ #category : #accessing }
APartList >> selectionIndex: newIndex [

	super selectionIndex: newIndex.
	self changedAspectValue: #selectionDisplay
]
