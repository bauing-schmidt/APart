"
I describe a grid layout properties
"
Class {
	#name : #ApedGridLayoutPart,
	#superclass : #ApedLayoutPart,
	#instVars : [
		'borderWidth',
		'columnSpacing',
		'rowSpacing',
		'columnHomogeneous',
		'rowHomogeneous',
		'name'
	],
	#category : #'APart Form Editor-Layout Parts'
}

{ #category : #accessing }
ApedGridLayoutPart class >> iconName [

	^#tgridlayout
]

{ #category : #accessing }
ApedGridLayoutPart class >> layoutName [ 

	^ 'Grid'
]

{ #category : #accessing }
ApedGridLayoutPart >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
ApedGridLayoutPart >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #accessing }
ApedGridLayoutPart >> childClass [ 

	^ ApedGridLayoutChildPart
]

{ #category : #accessing }
ApedGridLayoutPart >> columnHomogeneous [
	^ columnHomogeneous
]

{ #category : #accessing }
ApedGridLayoutPart >> columnHomogeneous: anObject [
	columnHomogeneous := anObject
]

{ #category : #accessing }
ApedGridLayoutPart >> columnSpacing [
	^ columnSpacing
]

{ #category : #accessing }
ApedGridLayoutPart >> columnSpacing: anObject [
	columnSpacing := anObject
]

{ #category : #serialization }
ApedGridLayoutPart >> initOnJson: aJsonObj [
	
	super initOnJson: aJsonObj.
	
	name := (aJsonObj at: #name ifAbsent: [ 'Grid']).
	borderWidth := (aJsonObj at: #borderWidth ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	columnSpacing := (aJsonObj at: #columnSpacing ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	rowSpacing := (aJsonObj at: #rowSpacing ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	columnHomogeneous := (aJsonObj at: #columnHomogeneous ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	rowHomogeneous := (aJsonObj at: #rowHomogeneous ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #'initialize-release' }
ApedGridLayoutPart >> initializeValues [

	super initializeValues.
	
	name := 'Grid'.	
	self partInterface description createAspectNamed: #name.
	
	self partInterface description createAspectNamed: #borderWidth.
	borderWidth := SpGridLayout defaultBorderWidth.

	self partInterface description createAspectNamed: #columnSpacing.
	columnSpacing := SpGridLayout defaultColumnSpacing.

	self partInterface description createAspectNamed: #rowSpacing.
	rowSpacing := SpGridLayout defaultRowSpacing.
	
	self partInterface description createAspectNamed: #columnHomogeneous.
	columnHomogeneous := false.

	self partInterface description createAspectNamed: #rowHomogeneous.
	rowHomogeneous := false.
	
	self addDependentToAspects

]

{ #category : #serialization }
ApedGridLayoutPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#name -> self name.
		#borderWidth -> self borderWidth.
		#columnSpacing -> self columnSpacing.
		#rowSpacing -> self rowSpacing.
		#columnHomogeneous -> self columnHomogeneous.
		#rowHomogeneous -> self rowHomogeneous.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedGridLayoutPart >> labelString [ 
	
	^self name
]

{ #category : #accessing }
ApedGridLayoutPart >> name [

	^ name
]

{ #category : #accessing }
ApedGridLayoutPart >> name: anObject [

	name := anObject
]

{ #category : #'initialize-release' }
ApedGridLayoutPart >> previewLayout [ 

	| aLayout |
	aLayout := SpGridLayout new.

	aLayout borderWidth: self borderWidth.
	aLayout columnSpacing: self columnSpacing.
	aLayout rowSpacing: self rowSpacing.
	aLayout columnHomogeneous: self columnHomogeneous.
	aLayout rowHomogeneous: self rowHomogeneous.
	
	self children do: [ :aChild |
		| aChildLayout |
		aChildLayout := aChild previewLayout.
		aChildLayout ifNotNil: [  
			
			aLayout add: aChildLayout at: (aChild layoutChild position) span: (aChild layoutChild span)] ].
		
	^ aLayout	
]

{ #category : #accessing }
ApedGridLayoutPart >> rowHomogeneous [
	^ rowHomogeneous
]

{ #category : #accessing }
ApedGridLayoutPart >> rowHomogeneous: anObject [
	rowHomogeneous := anObject
]

{ #category : #accessing }
ApedGridLayoutPart >> rowSpacing [
	^ rowSpacing
]

{ #category : #accessing }
ApedGridLayoutPart >> rowSpacing: anObject [
	rowSpacing := anObject
]
