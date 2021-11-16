Class {
	#name : #APListSelectionMulti,
	#superclass : #APListSelection,
	#category : #'APart Basic-Support'
}

{ #category : #actions }
APListSelectionMulti >> clearAll [
	selectionIndexHolder value: self emptySelection
]

{ #category : #actions }
APListSelectionMulti >> emptySelection [
	^ self selectionIndexHolder value species new
]

{ #category : #actions }
APListSelectionMulti >> privNewSelectionHolder [

	^ OrderedCollection new asValueHolder
]

{ #category : #actions }
APListSelectionMulti >> selectAll [
	| newSelectionIndexes |
	newSelectionIndexes := self emptySelection.
	newSelectionIndexes addAll: (1 to: listHolder value size).
	selectionIndexHolder value: newSelectionIndexes
]

{ #category : #actions }
APListSelectionMulti >> selection: aValue [
	self selectionIndexes: aValue
]

{ #category : #actions }
APListSelectionMulti >> selectionHolder [
	^ (APAspectAdaptor subject: self sendsUpdates: true)
		getSelector: #selections
		setSelector: #selections:
		aspect: #selectionIndex
]

{ #category : #actions }
APListSelectionMulti >> selectionIndex: pathCollection [
	self selectionIndexes: pathCollection
]

{ #category : #actions }
APListSelectionMulti >> selectionIndexes [

	^ selectionIndexHolder value
]

{ #category : #actions }
APListSelectionMulti >> selectionIndexes: aSequence [

	listHolder changed: #selectionChanging.
	selectionIndexHolder value: aSequence.
	listHolder changed: #selectionChanged
]

{ #category : #actions }
APListSelectionMulti >> selections [

	| list selections indices |
	selections := Set new.
	indices := selectionIndexHolder value.
	list := listHolder value.
	indices do: 
			[:eachIndex |
			(eachIndex between: 1 and: list size)
				ifTrue: [selections add: (list at: eachIndex)]].
	^selections asOrderedCollection
]

{ #category : #actions }
APListSelectionMulti >> selections: aCollection [
	| newSelectionIndexes currentList index |
	newSelectionIndexes := self emptySelection.
	currentList := listHolder value.
	aCollection
		do: [ :val | 
			(index := currentList indexOf: val ifAbsent: [  ]) == nil
				ifFalse: [ newSelectionIndexes add: index ] ].
	self selectionIndexes: newSelectionIndexes
]

{ #category : #actions }
APListSelectionMulti >> update: anAspect with: aParameter from: anObject [

	anObject == selectionIndexHolder
		ifTrue: [ ^ self changed: #selectionIndex ].
	(anObject == listHolder
		and: [ (#(#selectionChanged #selectionChanging) includes: anAspect) not ])
		ifTrue: [ | arrayPair newSelectionIndexes |
			newSelectionIndexes := aParameter ifNotNil: [ aParameter first ].
			(newSelectionIndexes notNil
				and: [ newSelectionIndexes isCollection
						and: [ newSelectionIndexes allSatisfy: #isInteger ] ])
				ifTrue: [ arrayPair := aParameter.
					selectionIndexHolder setValue: newSelectionIndexes ]
				ifFalse: [ arrayPair := nil.
					selectionIndexHolder setValue: self emptySelection ].
			self changed: #list.
			selectionIndexHolder changed: #value with: arrayPair ]
]
