Class {
	#name : #APTreeSelection,
	#superclass : #APListSelection,
	#category : #'APart Basic-Support'
}

{ #category : #initialization }
APTreeSelection >> isReleased [

	^ false
]

{ #category : #initialization }
APTreeSelection >> privNewListHolder [
	^ APTreeModel new asValueHolder
]

{ #category : #initialization }
APTreeSelection >> selection: aValue [

	aValue ifNil: [ ^ self setSelectionIndexAndAnnounceIfChangedTo: 0 ].
	self setSelectionIndexAndAnnounceIfChangedTo: (aValue)
]

{ #category : #initialization }
APTreeSelection >> tree [
	"Answer the receiver's tree."

	^listHolder value
]

{ #category : #initialization }
APTreeSelection >> tree: aTree [
	"Set the receiver's tree."

	listHolder value: aTree
]

{ #category : #initialization }
APTreeSelection >> treeHolder [
	"Answer the ListHolder (which holds a tree)"

	^listHolder
]
