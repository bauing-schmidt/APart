"
I describe a frame layout properties
"
Class {
	#name : #ApedFrameLayoutPart,
	#superclass : #ApedLayoutPart,
	#instVars : [
		'label'
	],
	#category : #'APart Form Editor-Layout Parts'
}

{ #category : #accessing }
ApedFrameLayoutPart class >> iconName [

	^#tframelayout
]

{ #category : #accessing }
ApedFrameLayoutPart class >> layoutName [ 

	^ 'Frame'
]

{ #category : #visiting }
ApedFrameLayoutPart >> accept: anApedVisitor [

	anApedVisitor visitFrameLayout: self
]

{ #category : #accessing }
ApedFrameLayoutPart >> childClass [ 

	^ ApedFrameLayoutChildPart
]

{ #category : #'initialize-release' }
ApedFrameLayoutPart >> defineAspects [ 

	partInterface description createAspectNamed: #label.
	self addDependentToAspects
]

{ #category : #serialization }
ApedFrameLayoutPart >> initOnJson: aJsonObj [
	
	super initOnJson: aJsonObj.

	label := (aJsonObj at: #label ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedFrameLayoutPart >> initializeValues [

	super initializeValues.
		
	label := 'Frame'.



]

{ #category : #accessing }
ApedFrameLayoutPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#label -> self label.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedFrameLayoutPart >> label [
	^ label
]

{ #category : #accessing }
ApedFrameLayoutPart >> label: anObject [
	label := anObject
]

{ #category : #accessing }
ApedFrameLayoutPart >> labelString [ 

	^label
]

{ #category : #accessing }
ApedFrameLayoutPart >> maximalChildrenCount [

	^ 1
]

{ #category : #accessing }
ApedFrameLayoutPart >> previewLayout [ 

	| aLayout | 
	
	aLayout := SpFrameLayout new.
	
	aLayout label: self label.
				
	self children do: [ :aChild |
		| aChildLayout |
		aChildLayout := aChild previewLayout.
		aChildLayout ifNotNil: [  
			aLayout add: aChildLayout ] ].

	^ aLayout
	
]
