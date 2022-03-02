Class {
	#name : #ApedSpecCodeVisitor,
	#superclass : #ApedVisitor,
	#instVars : [
		'layoutStream',
		'elementsStream'
	],
	#category : #'APart Form Editor-Visitor'
}

{ #category : #private }
ApedSpecCodeVisitor >> addChildrenOf: aLayoutPart [

	aLayoutPart children do: [ :aChildLayout | 
		layoutStream nextPutAll: 'add: ('.
		self visit: aChildLayout.
		layoutStream
			nextPutAll: ') expand: ';
			nextPutAll: aChildLayout layoutChild expand printString;
			cr;
			nextPutAll: 'fill: ';
			nextPutAll: aChildLayout layoutChild fill printString;
			cr;
			nextPutAll: ';';
			yourself ].

]

{ #category : #private }
ApedSpecCodeVisitor >> addElement: aPart as: aBlock [

	elementsStream
		nextPutAll: 'self additionalSubpresentersMap at: #';
		nextPutAll: aPart presenterId printString;
		nextPutAll: ' put: ('.

	aBlock value.
	elementsStream nextPutAll: ').'
]

{ #category : #private }
ApedSpecCodeVisitor >> addFrameChildrenOf: aLayoutPart [

	aLayoutPart children do: [ :aChildLayout | 
		layoutStream nextPutAll: 'add: ('.
		self visit: aChildLayout.
		layoutStream
			nextPutAll: ')';
			yourself ]
]

{ #category : #visiting }
ApedSpecCodeVisitor >> addGridChildrenOf: aLayoutPart [

	aLayoutPart children do: [ :aChildLayout | 
		layoutStream nextPutAll: 'add: ('.
		self visit: aChildLayout.
		layoutStream
			nextPutAll: ') at: ';
			nextPutAll: aChildLayout layoutChild x printString;
			nextPutAll: '@';
			nextPutAll: aChildLayout layoutChild y printString;
			cr;
			nextPutAll: 'span: ';
			nextPutAll: aChildLayout layoutChild spanX printString;
			nextPutAll: '@';
			nextPutAll: aChildLayout layoutChild spanY printString;
			cr;
			nextPutAll: ';';
			yourself ]
]

{ #category : #accessing }
ApedSpecCodeVisitor >> elementsSource [

	^ (RBParser parseMethod: elementsStream contents) formattedCode
]

{ #category : #accessing }
ApedSpecCodeVisitor >> layoutSource [ 

	^ (RBParser parseMethod: layoutStream contents) formattedCode.

]

{ #category : #'visiting - layouts' }
ApedSpecCodeVisitor >> visitBoxLayout: aLayoutPart [

	| directionConstructor |
	directionConstructor := aLayoutPart direction value = #vertical
		                        ifTrue: [ 'newVertical' ]
		                        ifFalse: [ 'newHorizontal' ].

	layoutStream
		nextPutAll: 'SpBoxLayout ';
		nextPutAll: directionConstructor;
		cr;
		nextPutAll: 'spacing: ';
		nextPutAll: aLayoutPart spacing printString;
		nextPutAll: ';';
		cr;
		nextPutAll: 'borderWidth: ';
		nextPutAll: aLayoutPart borderWidth printString;
		nextPutAll: ';';
		cr;
		nextPutAll: 'homogeneous: ';
		nextPutAll: aLayoutPart homogeneous printString;
		nextPutAll: ';';
		cr.

	self addChildrenOf: aLayoutPart.

	layoutStream
		nextPutAll: 'yourself';
		cr
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitButton: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newButton label: ';
			nextPutAll: aPart label storeString;
			nextPutAll: ' ; enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString.

		aPart icon
			ifNotNil: [ 
				elementsStream
					nextPutAll: ' ; icon: (self iconNamed: ';
					nextPutAll: aPart icon storeString;
			nextPutAll: ') '  ].

		elementsStream nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitCheckBox: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newCheckBox label: ';
			nextPutAll: aPart label storeString;
			nextPutAll: ' ; enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; labelClickable: ';
			nextPutAll: aPart labelClickable storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitColorInput: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: '(self instantiate: APartColorInputPresenter) enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitDropList: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newDropList enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #visiting }
ApedSpecCodeVisitor >> visitForm: aPart [

	layoutStream := WriteStream on: String new.
	elementsStream := WriteStream on: String new.

	layoutStream
		nextPutAll: 'defaultLayout ^';
		cr.

	aPart rootLayout accept: self.

	elementsStream
		nextPutAll: 'initializeFormPresenters ';
		cr.

	aPart elementsList list do: [ :each | each accept: self ]
]

{ #category : #'visiting - layouts' }
ApedSpecCodeVisitor >> visitFrameLayout: aLayoutPart [

	layoutStream
		nextPutAll: '(SpFrameLayout newLabel: ';
		nextPutAll: aLayoutPart label storeString;
		nextPutAll: ')';
		cr.

	self addFrameChildrenOf: aLayoutPart.

	layoutStream
		nextPutAll: 'yourself';
		cr
]

{ #category : #'visiting - layouts' }
ApedSpecCodeVisitor >> visitGridLayout: aLayoutPart [

	layoutStream
		nextPutAll: 'SpGridLayout new ';
		cr;
		nextPutAll: 'borderWidth: ';
		nextPutAll: aLayoutPart borderWidth printString;
		nextPutAll: ';';
		cr;
		nextPutAll: 'columnSpacing: ';
		nextPutAll: aLayoutPart columnSpacing printString;
		nextPutAll: ';';
		cr;
		nextPutAll: 'rowSpacing: ';
		nextPutAll: aLayoutPart rowSpacing printString;
		nextPutAll: ';';
		cr;
		nextPutAll: 'columnHomogeneous: ';
		nextPutAll: aLayoutPart columnHomogeneous printString;
		nextPutAll: ';';
		cr;
		nextPutAll: 'rowHomogeneous: ';
		nextPutAll: aLayoutPart rowHomogeneous printString;
		nextPutAll: ';';
		cr.

	self addGridChildrenOf: aLayoutPart.

	layoutStream
		nextPutAll: 'yourself';
		cr
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitLabel: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newLabel label: ';
			nextPutAll: aPart label storeString;
			nextPutAll: ' ; enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitList: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newList enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - layouts' }
ApedSpecCodeVisitor >> visitNodeLayout: aPart [

	layoutStream
			nextPutAll: '#';
		nextPutAll: aPart presenterId value printString
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitNumberInput: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newNumberInput minimum: ';
			nextPutAll: aPart minimum storeString;
			nextPutAll: ' ; maximum: ';
			nextPutAll: aPart maximum storeString;
			nextPutAll: ' ; climbRate: ';
			nextPutAll: aPart climbRate storeString;
			nextPutAll: ' ; digits: ';
			nextPutAll: aPart digits storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitProgressBar: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newProgressBar enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitRadioButton: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newRadioButton label: ';
			nextPutAll: aPart label storeString;
			nextPutAll: ' ; enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; labelClickable: ';
			nextPutAll: aPart labelClickable storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - layouts' }
ApedSpecCodeVisitor >> visitScrollLayout: aLayoutPart [

	aLayoutPart children ifEmpty: [ 
		layoutStream
			nextPutAll: 'SpScrollableLayout new ';
			cr.
		^ self ].

	layoutStream
		nextPutAll: '(SpScrollableLayout with: (';
		cr.

	self visit: aLayoutPart children first.

	layoutStream
		nextPutAll: '))';
		cr
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitStatusBar: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newStatusBar enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitText: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newText enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; wrapWord: ';
			nextPutAll: aPart wrapWord  storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitTextInput: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newTextInput placeholder: ';
			nextPutAll: aPart placeholder storeString;
			nextPutAll: ' ; enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; editable: ';
			nextPutAll: aPart editable storeString;
			nextPutAll: ' ; bePassword: ';
			nextPutAll: aPart password storeString;
			nextPutAll: ' ; maxLength: ';
			nextPutAll: aPart maxLength storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitTree: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newTree enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]

{ #category : #'visiting - elements' }
ApedSpecCodeVisitor >> visitTreeTable: aPart [

	self addElement: aPart as: [ 
		elementsStream
			nextPutAll: 'self newTreeTable enabled: ';
			nextPutAll: aPart enabled storeString;
			nextPutAll: ' ; help: ';
			nextPutAll: aPart help storeString;
			nextPutAll: ' ; yourself' ]
]
