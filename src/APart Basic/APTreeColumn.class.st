Class {
	#name : #APTreeColumn,
	#superclass : #Object,
	#instVars : [
		'title',
		'evaluation',
		'expandable',
		'width',
		'sortFunction'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APTreeColumn class >> evaluated: aValuable [

	^ self new 
		evaluated: aValuable;
		yourself
]

{ #category : #'instance creation' }
APTreeColumn class >> title: aString [

	^ self new 
		title: aString;
		yourself
]

{ #category : #'instance creation' }
APTreeColumn class >> title: aString evaluated: aValuable [

	^ self new 
		title: aString;
		evaluated: aValuable;
		yourself
]

{ #category : #spec }
APTreeColumn >> asSpecColumn [ 

	| specColumn |
	specColumn := self specColumnClass new 
		title: title;
		evaluated: evaluation;
		sortFunction: sortFunction;
		title: title;
		width: width;
		yourself.
	
	self isExpandable 
		ifTrue: [ specColumn beExpandable ]
		ifFalse: [ specColumn beNotExpandable ].
		
	^ specColumn 
		
		 
]

{ #category : #api }
APTreeColumn >> beExpandable [
	"Indicate that this column may be expanded if requested by the rendering.
	 This will cause the column to take as much width as it is given.
	 By default, all columns are expandable."

	expandable := true
]

{ #category : #api }
APTreeColumn >> beNotExpandable [
	"Indicate that this column will not be expanded when requested by the rendering.
	 This will cause the column to have a fixed width (often calculated by the width of its 
	 elements)."

	expandable := false
]

{ #category : #api }
APTreeColumn >> evaluated: aBlock [
	"Define how the column will evaluate the element of the table/tree model 
	 (See `SpAbstractListPresenter>>#items:) to get the value to display in this 
	 column.
	 `aBlock` receives one orgument (the element to evaluate) and it needs to answer an 
	 object of the type expected by the type of the column (See SpTableColumn subclasses)"

	evaluation := aBlock
]

{ #category : #api }
APTreeColumn >> evaluation [
	"Answer the evaluation block to transform the table element (See `SpAbstractListPresenter>>#items:`)
	 into a value to display in this column"

	^ evaluation
]

{ #category : #initialization }
APTreeColumn >> initialize [

	super initialize.
	self beExpandable
]

{ #category : #testing }
APTreeColumn >> isComposite [
	"Answer if this is a composite column"

	^ false
]

{ #category : #testing }
APTreeColumn >> isEditable [
	"Answer if this column is editable"

	^ false
]

{ #category : #testing }
APTreeColumn >> isExpandable [
	"Answer if this column is expandable"

	"if width is defined, it cannot be expandable (because column with take the defined width)"
	^ expandable and: [ self width isNil ]
]

{ #category : #testing }
APTreeColumn >> isSortable [
	"Answer if this column is sortable"

	^ self sortFunction notNil
]

{ #category : #private }
APTreeColumn >> readObject: anObject [ 

	^ self evaluation cull: anObject
]

{ #category : #api }
APTreeColumn >> sortFunction [
	"Answer the a sort function to apply to the values of this column in order to sort elements. 
	 If not defined, most table column types will not allow the table sorting capabilities. 
	 This is not the case of `SpStringTableColumn` which defines a sorting by default (but you can 
	 disable it anyway, see `SpStringTableColumn>>#beNotSortable`."

	^ sortFunction
]

{ #category : #api }
APTreeColumn >> sortFunction: aBlockOrSortFunction [
	"Set the sort function to apply to the values of this column in order to sort elements.
	 `aBlockOrSortFunction` is a block that receives two arguments to compare or an instace of 
	 `SortFunction`. "

	sortFunction := aBlockOrSortFunction
]

{ #category : #spec }
APTreeColumn >> specColumnClass [ 

	^ self subclassResponsibility
]

{ #category : #api }
APTreeColumn >> title [
	"Answer the header title of this column."

	^ title
]

{ #category : #api }
APTreeColumn >> title: aString [
	"Set the header title of this column."

	title := aString
]

{ #category : #api }
APTreeColumn >> width [
	"Answer the fixed width of this column (or nil if column is expandable, 
	 see `SpTableColumn>>#beExpandable`)"

	^ width
]

{ #category : #api }
APTreeColumn >> width: aNumber [
	"Set the width of a column to `aNumber`. 
	 Note that setting width to a value will make this column not expandable. 
	 (See `SpTableColumn>>#beNotExpandable`"

	width := aNumber
]
