"
Use me for selections based on item indexes. The selection type is either single or multi selection.
"
Trait {
	#name : #APTPartWithIndexedSelection,
	#instVars : [
		'isMultiSelection',
		'selectionIndex',
		'selectionIndexes'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APTPartWithIndexedSelection >> errorMultiSelection [ 

	self aPartError: #multipleSelectionNotPossible
]

{ #category : #accessing }
APTPartWithIndexedSelection >> holdSelectionChangedTrigger [
 
	^ false
]

{ #category : #accessing }
APTPartWithIndexedSelection >> initializeSelection [

	selectionIndex := self isMultiSelection 
	ifTrue: [OrderedCollection new]
	ifFalse: [0].
	selectionIndexes := OrderedCollection new.

]

{ #category : #accessing }
APTPartWithIndexedSelection >> isMultiSelection [

	^isMultiSelection == true
]

{ #category : #accessing }
APTPartWithIndexedSelection >> isMultiSelection: aBoolean [

	isMultiSelection := aBoolean
]

{ #category : #accessing }
APTPartWithIndexedSelection >> itemCount [

	self explicitRequirement
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selection [

	^self isMultiSelection
		ifTrue: [ self selections isEmpty ifTrue: [nil] ifFalse: [self selections first] ]
		ifFalse: [ selectionIndex = 0 ifTrue: [nil] ifFalse: [ self at: selectionIndex ] ]
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selection: anObject [

	| idx |
	anObject ifNil: [ ^self selectionIndex: 0 ].
	(idx := self indexOf: anObject) = 0
		ifTrue: [self aPartError: #objectNotFound].
	self selectionIndex: idx.
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selectionIndex [

	^selectionIndex
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selectionIndex: newIndex [

	| newSingleIndex |
	self isMultiSelection
		ifTrue: 
			[| newIndexColl |
			newIndexColl := OrderedCollection new.
			newIndex > 0 ifTrue: [newIndexColl add: newIndex].
			^self selectionIndexes: newIndexColl].
	newSingleIndex := newIndex <= self itemCount
				ifTrue: [newIndex]
				ifFalse: [0].
	selectionIndex = newSingleIndex
		ifTrue: [^self].
	selectionIndex := newIndex.
	self changedAspectValue: #selectionIndexHolder suppressListeners: true.
	self holdSelectionChangedTrigger
		ifFalse: [self partInterface executeTrigger: #selectionChanged]
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selectionIndexes [

	^self isMultiSelection
		ifTrue: [ selectionIndexes ]
		ifFalse: [ self singleSelectionIndexes ]
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selectionIndexes: newIndexColl [

	self isMultiSelection
		ifTrue: 
			[selectionIndexes = newIndexColl
				ifFalse: 
					[selectionIndexes := newIndexColl asOrderedCollection.
					self changedAspectValue: #selectionIndexHolder suppressListeners: true.
					self holdSelectionChangedTrigger
						ifFalse: [self partInterface executeTrigger: #selectionChanged]]]
		ifFalse: 
			[newIndexColl size > 1 ifTrue: [^self errorMultiSelection].
			self
				selectionIndex: (newIndexColl isEmpty ifTrue: [0] ifFalse: [newIndexColl any])]
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selections [

	^self isMultiSelection
		ifTrue: [selectionIndexes collect: [:each | self at: each]]
		ifFalse: [ 
			self selection 
				ifNil: [ Array new ] 
				ifNotNil: [ :aSelection | Array with: aSelection ] ]
]

{ #category : #accessing }
APTPartWithIndexedSelection >> selections: objects [

	| indexColl remainingObjects |
	(objects size > 1 and: [ self isMultiSelection not ]) ifTrue: [ 
		^ self errorMultiSelection ]. 

	indexColl := OrderedCollection new.
	objects isEmpty ifTrue: [ ^ self selectionIndexes: objects ].
	remainingObjects := IdentitySet withAll: objects.
	remainingObjects doWithIndex: [ :item :i | 
		| foundIndex |
		foundIndex := self indexOf: item.
		foundIndex ifNotNil: [ indexColl add: foundIndex ] ].
	self selectionIndexes: indexColl
]

{ #category : #accessing }
APTPartWithIndexedSelection >> singleSelectionIndexes [

	^selectionIndex = 0 
		ifTrue: [ Array new ] 
		ifFalse: [ Array with: selectionIndex ] 
]

{ #category : #accessing }
APTPartWithIndexedSelection >> sortedSelectionIndexes [

	^self selectionIndexes asSortedCollection
]
