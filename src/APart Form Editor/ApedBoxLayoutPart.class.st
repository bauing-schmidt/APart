"
I describe a box layout properties
"
Class {
	#name : #ApedBoxLayoutPart,
	#superclass : #ApedLayoutPart,
	#instVars : [
		'direction',
		'spacing',
		'borderWidth',
		'homogeneous',
		'directionsList',
		'name'
	],
	#category : #'APart Form Editor-Layout Parts'
}

{ #category : #accessing }
ApedBoxLayoutPart class >> iconName [

	^#tboxlayout
]

{ #category : #accessing }
ApedBoxLayoutPart class >> layoutName [ 

	^ 'Box'
]

{ #category : #visiting }
ApedBoxLayoutPart >> accept: anApedVisitor [

	anApedVisitor visitBoxLayout: self
]

{ #category : #'initialize-release' }
ApedBoxLayoutPart >> aspectsEnumeration [

	| enum |
	
	enum := APEnumeration named: #directionsEnumeration.

	#(vertical horizontal) do: [ :each | 
		enum addEntry: (APEnumEntry on: enum key: each value: each  ) ].
	
	^enum
]

{ #category : #accessing }
ApedBoxLayoutPart >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
ApedBoxLayoutPart >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #accessing }
ApedBoxLayoutPart >> direction [
	^ direction
]

{ #category : #accessing }
ApedBoxLayoutPart >> direction: anObject [
	direction := anObject
]

{ #category : #'initialize-release' }
ApedBoxLayoutPart >> directionsEnumeration [

	| enum |
	
	enum := APEnumeration named: #direction.

	#(vertical horizontal) do: [ :each | 
		enum addEntry: (APEnumEntry on: enum key: each value: each  ) ].
	
	^enum
]

{ #category : #accessing }
ApedBoxLayoutPart >> homogeneous [
	^ homogeneous
]

{ #category : #accessing }
ApedBoxLayoutPart >> homogeneous: anObject [
	homogeneous := anObject
]

{ #category : #serialization }
ApedBoxLayoutPart >> initOnJson: aJsonObj [
	
	super initOnJson: aJsonObj.
	
	name := (aJsonObj at: #name ifAbsent: [ 'Box' ]).
	direction value: (aJsonObj at: #direction ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	spacing := (aJsonObj at: #spacing ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	borderWidth := (aJsonObj at: #borderWidth ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	homogeneous := (aJsonObj at: #homogeneous ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #'initialize-release' }
ApedBoxLayoutPart >> initializeValues [

	super initializeValues.

	directionsList := APartList onPart: self key: #directionsList.
	direction := APEnumerationValuePart onPart: self key: #direction.
	direction enumeration: self directionsEnumeration.
	name := 'Box'.
	
	self partInterface description createAspectNamed: #name.
	
	partInterface description 
		createAspectNamed: #direction.
	self direction value: #horizontal.
		
    partInterface description 
		createAspectNamed: #directionsValue
			redirectTo: #(direction value).
			
    partInterface description 
		createAspectNamed: #directionsList
			redirectTo: #(direction enumerationTextList).
	
	self partInterface description createAspectNamed: #spacing.
	spacing := 0.	
		
	self partInterface description createAspectNamed: #borderWidth.
	borderWidth := 0.
	
	self partInterface description createAspectNamed: #homogeneous.
	homogeneous := false.
	
	self addDependentToAspects
]

{ #category : #serialization }
ApedBoxLayoutPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#name -> self name.
		#direction -> self direction value.
		#spacing -> self spacing.
		#borderWidth -> self borderWidth.
		#homogeneous -> self homogeneous.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedBoxLayoutPart >> labelString [ 
	
	^self name
]

{ #category : #accessing }
ApedBoxLayoutPart >> name [

	^ name
]

{ #category : #accessing }
ApedBoxLayoutPart >> name: anObject [

	name := anObject
]

{ #category : #accessing }
ApedBoxLayoutPart >> previewLayout [ 

	| aLayout | 
	
	aLayout := direction value = #vertical 
		ifTrue: [ SpBoxLayout newVertical ]
		ifFalse: [ SpBoxLayout newHorizontal ].
	
	aLayout borderWidth: self borderWidth.
	self homogeneous 
		ifTrue: [ aLayout beHomogeneous  ]
		ifFalse: [ aLayout beNotHomogeneous ].
		
	aLayout spacing: self spacing.
	
	self children do: [ :aChild |
		| aChildLayout |
		aChildLayout := aChild previewLayout.
		aChildLayout ifNotNil: [  
			aLayout add: aChildLayout expand: aChild layoutChild expand fill: aChild layoutChild fill padding: aChild layoutChild padding ] ].

	^ aLayout
	
]

{ #category : #accessing }
ApedBoxLayoutPart >> spacing [
	^ spacing
]

{ #category : #accessing }
ApedBoxLayoutPart >> spacing: anObject [
	spacing := anObject
]
