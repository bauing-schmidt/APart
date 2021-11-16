"
APartTree repräsentiert ein generisch verwendbares Tree-Model.
"
Class {
	#name : #APartTree,
	#superclass : #APartAbstractSequence,
	#instVars : [
		'root',
		'displayRoot',
		'getChildrenBlock',
		'treeModel'
	],
	#category : #'APart BasicParts'
}

{ #category : #API }
APartTree >> aspectBuilderClass [

	^APInterfaceTreeAspectBuilder
]

{ #category : #'as yet unclassified' }
APartTree >> at: aSelectionIndex [ 

	^ (self childAt: aSelectionIndex) value
]

{ #category : #'as yet unclassified' }
APartTree >> childAt: aSelectionIndex [ 

	^ self root childAt: aSelectionIndex
]

{ #category : #accessing }
APartTree >> clear [ 

	self treeModel clear.
	self treeModel valueChanged.
]

{ #category : #SelectionInTree }
APartTree >> consolidatedTopSelections [

	| consolidatedSelections |
	consolidatedSelections := self selections.
	self selections do: 
			[:each |
			| selParents |
			selParents := treeModel allParentsFor: each.
			(self selections anySatisfy: [:sel | selParents includes: sel])
				ifTrue: [consolidatedSelections remove: each ifAbsent: []]].
	^consolidatedSelections
]

{ #category : #'as yet unclassified' }
APartTree >> defaultTreeModel [ 

	^ APTreeModel
		on: root
		showRoot: displayRoot
		childrenWith: [:n | n children]
]

{ #category : #'initialize-release' }
APartTree >> defineAspects [

	| selInList |
	partInterface usePartChannel.
	selInList := partInterface createAspectNamed: #selectionInTree
				build: 
					[:builder |
						| subject | 
						subject := self isMultiSelection
							ifTrue: [builder createTreeWithMultiSelectionModel]
							ifFalse: [builder createTreeWithSingleSelectionModel].
						(APAspectAdaptor subject: subject sendsUpdates: true)
							getSelector: #selection
							setSelector: #selection:
							aspect: #selectionIndex].
	^selInList
]

{ #category : #accessing }
APartTree >> displayRoot [

	^displayRoot
]

{ #category : #accessing }
APartTree >> displayRoot: anObject [

	displayRoot := anObject
]

{ #category : #accessing }
APartTree >> doWithIndex: aBlock [ 

	treeModel collection doWithIndex: aBlock 

]

{ #category : #accessing }
APartTree >> getChildrenBlock [

	^getChildrenBlock
]

{ #category : #accessing }
APartTree >> getChildrenBlock: anObject [

	getChildrenBlock := anObject.
	treeModel ifNotNil: [
		treeModel getChildrenBlock: getChildrenBlock.
"		treeModel refreshRoot."
	].
]

{ #category : #API }
APartTree >> hasTreeModel [

	^treeModel notNil
]

{ #category : #SelectionInTree }
APartTree >> includes: anObject [

	treeModel ifNil: [^false].
	^(treeModel pathToObject: anObject) notEmpty
		or: [(self indexOf: anObject) ~= 0]
]

{ #category : #API }
APartTree >> indexOf: anObject [ 

	^ (self root indexOf: anObject) ifNil: [ 0 ]
]

{ #category : #API }
APartTree >> itemCount [

	^treeModel ifNotNil: [:tm | tm size] ifNil: [0]
]

{ #category : #accessing }
APartTree >> refresh [ 

	self treeModel valueChanged
]

{ #category : #API }
APartTree >> refreshRoot [
	"#listHolder aspect update should not be held until the end of the current execution, otherwise a selection index that is set afterward will be reset"

	treeModel notNil
		ifTrue: 
			[treeModel refreshRoot.
			partInterface
				changedAspectValue: #listHolder
				suppressListeners: false
				bypassUpdatesHold: true]
]

{ #category : #accessing }
APartTree >> root [

	^treeModel root
]

{ #category : #accessing }
APartTree >> root: anObject [

	self selectionIndex: OrderedCollection new.
	
	self treeModel root: anObject showRoot: self displayRoot.
]

{ #category : #accessing }
APartTree >> selection [

	^self isMultiSelection
		ifTrue: [ self selections isEmpty ifTrue: [nil] ifFalse: [self selections first] ]
		ifFalse: [ selectionIndex isEmpty ifTrue: [nil] ifFalse: [ self at: selectionIndex ] ]
]

{ #category : #SelectionInTree }
APartTree >> selection: anObject [
	"expandFound: is not enough, because this method cant find the top elements"

	super selection: anObject.
	anObject ifNotNil: [ 
		treeModel expandNodeOf: anObject ]
]

{ #category : #'as yet unclassified' }
APartTree >> selectionIndex: newIndex [

	| newSingleIndex |
	self isMultiSelection
		ifTrue: 
			[| newIndexColl |
			newIndexColl := OrderedCollection new.
			newIndex isNotEmpty ifTrue: [newIndexColl add: newIndex].
			^self selectionIndexes: newIndexColl].
		
	newSingleIndex := newIndex isCollection 
		ifFalse: [ 
			newIndex <= self itemCount
				ifTrue: [newIndex]
				ifFalse: [0] ]
		ifTrue: [ 
			(newIndex notEmpty and: [newIndex first <= self itemCount])
				ifTrue: [newIndex]
				ifFalse: [ #() ]  ].
	selectionIndex = newSingleIndex
		ifFalse: 
			[selectionIndex := newIndex.
			self changedAspectValue: #selectionIndexHolder suppressListeners: true.
			self holdSelectionChangedTrigger
				ifFalse: [self partInterface executeTrigger: #selectionChanged]]
]

{ #category : #accessing }
APartTree >> treeModel [

	^ treeModel ifNil: [ treeModel := self defaultTreeModel ]
]
