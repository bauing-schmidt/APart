Class {
	#name : #APTreeCompositeColumn,
	#superclass : #APTreeColumn,
	#instVars : [
		'columns'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APTreeCompositeColumn class >> title: aString withAll: aCollection [

	^ self new
		title: aString;
		addAllColumns: aCollection;
		yourself
]

{ #category : #'instance creation' }
APTreeCompositeColumn class >> with: column [

	^ self new
		addColumn: column;
		yourself
]

{ #category : #'instance creation' }
APTreeCompositeColumn class >> with: column1 with: column2 [ 

	^ self new
		addColumn: column1;
		addColumn: column2;
		yourself
]

{ #category : #'instance creation' }
APTreeCompositeColumn class >> with: column1 with: column2 with: column3 [

	^ self new
		addColumn: column1;
		addColumn: column2;
		addColumn: column3;
		yourself
]

{ #category : #'instance creation' }
APTreeCompositeColumn class >> withAll: aCollection [

	^ self new
		addAllColumns: aCollection;
		yourself
]

{ #category : #api }
APTreeCompositeColumn >> addAllColumns: aCollection [ 
	"Add all columns contained in `aCollection` to the composed columns."
	
	aCollection do: [ :each | self addColumn: each ]
]

{ #category : #api }
APTreeCompositeColumn >> addColumn: aTableColumn [ 
	"Add a column to the composed columns."
	
	columns add: aTableColumn
]

{ #category : #testing }
APTreeCompositeColumn >> asSpecColumn [ 

	^ super asSpecColumn
		addAllColumns: (columns collect: #asSpecColumn);
		yourself
]

{ #category : #api }
APTreeCompositeColumn >> columns [
	"Answer the columns composing this composite."

	^ columns
]

{ #category : #initialization }
APTreeCompositeColumn >> initialize [
	
	super initialize.
	"there will be at least two, if it is composed :)"
	columns := OrderedCollection new: 2
]

{ #category : #testing }
APTreeCompositeColumn >> isComposite [
	"Answer if this is a composite column. 
	 For this class, answer will always be true."

	^ true
]

{ #category : #testing }
APTreeCompositeColumn >> specColumnClass [ 

	^ SpCompositeTableColumn 
]
