Class {
	#name : #APListSelection,
	#superclass : #APModel,
	#instVars : [
		'selectionIndexHolder',
		'listHolder'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APListSelection class >> adapt: aMonolithicModel aspect: aSymbol list: listSymbol selection: selectionSymbol [
	"Create an instance of the receiver that adapts updates from 
	aMonolithicModel using aSymbol as aspect. Send listSymbol to 
	aMololithicModel to get the list and notify aMonolithicModel that the 
	selection has changed by sending selectionSymbol. This message is 
	useful for converting applications that were written using 
	SelectionInListViews into applications that use SelectionInLists."

	| ls |
	ls := self new.
	ls
		listHolder:
			((APAspectAdaptor subject: aMonolithicModel sendsUpdates: true)
				forAspect: listSymbol).
	ls selectionIndexHolder
		dependentBlock: [ aMonolithicModel perform: selectionSymbol with: ls selection ].
	((APAspectAdaptor subject: aMonolithicModel sendsUpdates: true)
		forAspect: aSymbol) dependentBlock: [ ls changed: #list ].
	^ ls
]

{ #category : #'instance creation' }
APListSelection class >> with: aList [

	| ls |
	ls := self new.
	ls list: aList.
	^ls
]

{ #category : #initialization }
APListSelection >> initialize [
	self listHolder: self privNewListHolder.
	self selectionIndexHolder: self privNewSelectionHolder.
]

{ #category : #initialization }
APListSelection >> list [

	^ listHolder value
]

{ #category : #initialization }
APListSelection >> list: anObject [

	listHolder value: anObject
]

{ #category : #initialization }
APListSelection >> listHolder [

	^ listHolder
]

{ #category : #initialization }
APListSelection >> listHolder: aValueModel [

	listHolder removeDependent: self.
	listHolder := aValueModel.
	listHolder addDependent: self
]

{ #category : #initialization }
APListSelection >> privNewListHolder [

	^ OrderedCollectionWithDependants new asValueHolder.

]

{ #category : #initialization }
APListSelection >> privNewSelectionHolder [
	^ 0 asValueHolder
]

{ #category : #initialization }
APListSelection >> privUpdateToIndex: newIndex [
	| oldIndex |
	(newIndex isNil or: [ newIndex isInteger not ])
		ifTrue: [ oldIndex := nil.
			selectionIndexHolder setValue: 0 ]
		ifFalse: [ oldIndex := self selectionIndex.
			selectionIndexHolder setValue: newIndex ].
	self changed: #list.
	selectionIndexHolder changed: #value with: oldIndex
]

{ #category : #initialization }
APListSelection >> selection [

	| selectionIndex |
	
	selectionIndex := selectionIndexHolder value.
	
	^ selectionIndex = 0
		ifTrue: [ nil ]
		ifFalse: [ listHolder value at: selectionIndex ]
]

{ #category : #initialization }
APListSelection >> selection: aValue [

	aValue ifNil: [ ^ self setSelectionIndexAndAnnounceIfChangedTo: 0 ].
	self setSelectionIndexAndAnnounceIfChangedTo: (listHolder value indexOf: aValue ifAbsent: [ 0 ])
]

{ #category : #initialization }
APListSelection >> selectionHolder [

	^ (APAspectAdaptor subject: self sendsUpdates: true)
		getSelector: #selection
		setSelector: #selection:
		aspect: #selectionIndex
]

{ #category : #initialization }
APListSelection >> selectionIndex [

	^ selectionIndexHolder value
]

{ #category : #initialization }
APListSelection >> selectionIndex: aValue [

	selectionIndexHolder value = aValue ifTrue: [ ^ self ].
	
	listHolder changed: #selectionChanging.
	selectionIndexHolder value: aValue.
	listHolder changed: #selectionChanged 
]

{ #category : #initialization }
APListSelection >> selectionIndexHolder [

	^ selectionIndexHolder
]

{ #category : #initialization }
APListSelection >> selectionIndexHolder: aValueHolder [
	selectionIndexHolder removeDependent: self.
	selectionIndexHolder := aValueHolder.
	selectionIndexHolder addDependent: self
]

{ #category : #initialization }
APListSelection >> setSelectionIndexAndAnnounceIfChangedTo: anInteger [

	selectionIndexHolder value = anInteger
		ifTrue: [ selectionIndexHolder value: anInteger ]
		ifFalse: [ self selectionIndex: anInteger ] 
]

{ #category : #initialization }
APListSelection >> update: anAspect with: aParameter from: anObject [
	anObject = selectionIndexHolder
		ifTrue: [ ^ self changed: #selectionIndex ].
	(anObject = listHolder and: [ anAspect = #value ])
		ifTrue: [ self privUpdateToIndex: aParameter ]
]
