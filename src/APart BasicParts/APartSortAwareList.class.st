"
APartSortAwareList verfeinert die Liste um die Sortierfähigkeiten.

Instance Variables:
	sortAspect	<Symbol>		wird über die Spaltensymbole eines DataSet definiert
	sortDirection	<Symbol>		entweder #ascending oder #descending


"
Class {
	#name : #APartSortAwareList,
	#superclass : #APartList,
	#instVars : [
		'sortAspect',
		'sortDirection'
	],
	#category : #'APart BasicParts'
}

{ #category : #API }
APartSortAwareList >> addAll: objCol after: anObject [
	"for convenience the call will be directed to normal addAll: if the list is already sorted"

	self isSorted ifFalse: [^super addAll: objCol after: anObject].
	self addAll: objCol
]

{ #category : #'initialize-release' }
APartSortAwareList >> initializeValues [

	super initializeValues.
	sortDirection := #ascending
]

{ #category : #testing }
APartSortAwareList >> isSorted [

	^list isKindOf: SortedCollection
]

{ #category : #API }
APartSortAwareList >> listHolder [

	^self
]

{ #category : #accessing }
APartSortAwareList >> sortAspect [

	^sortAspect
]

{ #category : #accessing }
APartSortAwareList >> sortAspect: anObject [

	sortAspect := anObject
]

{ #category : #accessing }
APartSortAwareList >> sortDirection [

	^sortDirection
]

{ #category : #accessing }
APartSortAwareList >> sortDirection: anObject [

	sortDirection := anObject
]
