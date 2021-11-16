Class {
	#name : #APTreeStringColumn,
	#superclass : #APTreeColumn,
	#instVars : [
		'sortable'
	],
	#category : #'APart Basic-Support'
}

{ #category : #spec }
APTreeStringColumn >> asSpecColumn [ 

	^ super asSpecColumn
		isSortable: sortable;
		yourself
]

{ #category : #api }
APTreeStringColumn >> beNotSortable [

	self isSortable: false
]

{ #category : #api }
APTreeStringColumn >> beSortable [

	self isSortable: true
]

{ #category : #initialization }
APTreeStringColumn >> initialize [ 

	super initialize.
	sortable := false
]

{ #category : #testing }
APTreeStringColumn >> isSortable [

	^ sortable
]

{ #category : #private }
APTreeStringColumn >> isSortable: aBoolean [ 

	sortable := aBoolean
]

{ #category : #api }
APTreeStringColumn >> sortFunction [

	^ super sortFunction ifNil: [ self evaluation ascending ]
]

{ #category : #api }
APTreeStringColumn >> sortFunction: aBlockOrSortFunction [
	"Set the sort function to apply to the values of this column in order to sort elements.
	 `aBlockOrSortFunction` is a block that receives two arguments to compare or an instace of 
	 `SortFunction`. "

	super sortFunction: aBlockOrSortFunction.
	self isSortable: aBlockOrSortFunction notNil
]

{ #category : #spec }
APTreeStringColumn >> specColumnClass [ 

	^ SpStringTableColumn 
]
