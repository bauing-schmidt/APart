"
I describe a general layout properties
"
Class {
	#name : #ApedLayoutPart,
	#superclass : #ApedPartWithMemento,
	#instVars : [
		'children',
		'layoutChild',
		'parentLayout'
	],
	#category : #'APart Form Editor-Layout Parts'
}

{ #category : #testing }
ApedLayoutPart class >> canBeRoot [ 

	^ self isNode not
]

{ #category : #testing }
ApedLayoutPart class >> isNode [ 

	^ false
]

{ #category : #accessing }
ApedLayoutPart class >> layoutName [ 

	self subclassResponsibility 
]

{ #category : #'instance creation' }
ApedLayoutPart class >> onPart: aPart key: aKey onJson: aJsonObj [

	| className aClass | 
	
	className := aJsonObj at: #className ifAbsent: [ self pdmError: #PdmInvalidJsonObject].
	aClass := self withAllSubclasses detect: [ :each | each name = className ] ifNone: [ self pdmError: #PdmInvalidJsonObject ].

	^ (aClass onPart: aPart key: aKey) initOnJson: aJsonObj
]

{ #category : #accessing }
ApedLayoutPart >> addChild: newLayout [ 

	self children add: newLayout.
	newLayout parentLayout: self.
	
	newLayout layoutChild: (self layoutChildFor: newLayout).

]

{ #category : #accessing }
ApedLayoutPart >> addChild: newLayout layoutChild: aLayoutChild [

	self children add: newLayout.
	newLayout parentLayout: self.
	
	aLayoutChild ifNotNil: [ 
		newLayout layoutChild: aLayoutChild ]

]

{ #category : #adding }
ApedLayoutPart >> addDependentToAspects [

		self partInterface description aspects do:[:a| 	
				a subAdaptor dependents ifEmpty:[
					a subAdaptor addDependent: self]]	
]

{ #category : #accessing }
ApedLayoutPart >> allElementIDs [ 

	| result |
	
	result := self elementIDs asOrderedCollection.
	
	self children do: [ :each | 
		result addAll: each allElementIDs ].

	^ result
]

{ #category : #accessing }
ApedLayoutPart >> canAddChild [

	^ self children size < self maximalChildrenCount

	
]

{ #category : #accessing }
ApedLayoutPart >> childClass [ 

	^ ApedBoxLayoutChildPart
]

{ #category : #accessing }
ApedLayoutPart >> children [ 

	^ children ifNil: [ children := OrderedCollection new ]
]

{ #category : #accessing }
ApedLayoutPart >> elementIDs [ 

	^ Array new
]

{ #category : #accessing }
ApedLayoutPart >> form [ 

	self parentPart ifNil: [ ^ nil ].
	self parentPart isFormPart ifTrue: [ ^ self parentPart ].
	^ self parentPart form
]

{ #category : #serialization }
ApedLayoutPart >> initOnJson: aJsonObj [
		
	| layoutChildJson jsonChildren |	
"	children := (aJsonObj at: #children ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
"	layoutChildJson := (aJsonObj at: #layoutChild ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

	self removeSubPartForKey: #layoutChild.

	layoutChild := ApedLayoutChildPart onPart: self key: #layoutChild onJson: layoutChildJson.

	jsonChildren := (aJsonObj at: #children ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]). 

	jsonChildren do: [ :aChild |
		self materializeLayoutFrom: aChild andAddTo: self ].


]

{ #category : #accessing }
ApedLayoutPart >> initializeValues [ 

	| aLayoutClass |

	super initializeValues.
	
	aLayoutClass := parentLayout
		ifNil: [ ApedLayoutChildPart ]
		ifNotNil: [ self childClass ].
		
	layoutChild := aLayoutClass onPart: self key: #layoutChild 
]

{ #category : #testing }
ApedLayoutPart >> isNode [ 

	^ false
]

{ #category : #serialization }
ApedLayoutPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := { 
		#className -> self className.
		#children -> self children.
		#layoutChild -> self layoutChild.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedLayoutPart >> labelString [ 

	^ self class layoutName
]

{ #category : #accessing }
ApedLayoutPart >> layoutChild [ 

	^ layoutChild
]

{ #category : #accessing }
ApedLayoutPart >> layoutChild: aLayoutChild [

	layoutChild := aLayoutChild
]

{ #category : #accessing }
ApedLayoutPart >> layoutChildFor: aLayout [ 
	
	aLayout removeSubPartForKey: #childClass.
	^ self childClass onPart: aLayout key: #childClass 
]

{ #category : #serialization }
ApedLayoutPart >> materializeLayoutFrom: aJsonObject andAddTo: aLayout [

	| newLayout jsonChildren  | 
	
	newLayout := ApedLayoutPart onPart: self key: UUID new onJson: aJsonObject.  	
	jsonChildren := (aJsonObject at: #children ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]). 
	
	aLayout ifNotNil: [ 
		aLayout addChild: newLayout layoutChild: nil ].
	
	^ newLayout


]

{ #category : #serialization }
ApedLayoutPart >> materializeLayoutFrom: aJsonObject andAddTo: aLayout parent: aParentPart [

	| newLayout jsonChildren  | 
	
	newLayout := ApedLayoutPart onPart: aParentPart key: UUID new onJson: aJsonObject.  	
	jsonChildren := (aJsonObject at: #children ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]). 
	
	aLayout ifNotNil: [ 
		aLayout addChild: newLayout layoutChild: nil ].
	
	^ newLayout


]

{ #category : #accessing }
ApedLayoutPart >> maximalChildrenCount [ 

	^ SmallInteger maxVal
]

{ #category : #accessing }
ApedLayoutPart >> parentLayout [
	^ parentLayout
]

{ #category : #accessing }
ApedLayoutPart >> parentLayout: anObject [
	parentLayout := anObject.
	
]

{ #category : #accessing }
ApedLayoutPart >> presenterRemoved: anAspect [ 

	"nothing to do"
]

{ #category : #accessing }
ApedLayoutPart >> removeChild: aLayout [

	self children remove: aLayout.
	aLayout parentLayout: nil.
]

{ #category : #updating }
ApedLayoutPart >> update: anObject [


]

{ #category : #accessing }
ApedLayoutPart >> visitLayout: aLayout [ 

]

{ #category : #accessing }
ApedLayoutPart >> withChildrenDo: aBlock [ 

	aBlock value: self.
	self children do: [ :each | each withChildrenDo: aBlock ]
]
