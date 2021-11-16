"
I describe a layout node properties
"
Class {
	#name : #ApedNodeLayoutPart,
	#superclass : #ApedLayoutPart,
	#instVars : [
		'presenterId',
		'elementKey'
	],
	#category : #'APart Form Editor-Layout Parts'
}

{ #category : #accessing }
ApedNodeLayoutPart class >> iconName [

	^#empty
]

{ #category : #testing }
ApedNodeLayoutPart class >> isNode [ 

	^ true
]

{ #category : #accessing }
ApedNodeLayoutPart class >> layoutName [ 

	^ 'Node'
]

{ #category : #accessing }
ApedNodeLayoutPart >> elementIDs [ 

	^ { presenterId value }
]

{ #category : #accessing }
ApedNodeLayoutPart >> elementKey [

	^ elementKey
]

{ #category : #accessing }
ApedNodeLayoutPart >> elementKey: anObject [

	elementKey := anObject
]

{ #category : #'initialize-release' }
ApedNodeLayoutPart >> idsEnumeration [

	^ self rootPart elementIDsEnumeration
	
]

{ #category : #serialization }
ApedNodeLayoutPart >> initOnJson: aJsonObj [
	
	super initOnJson: aJsonObj.
	
	presenterId value: (aJsonObj at: #presenterId ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #'initialize-release' }
ApedNodeLayoutPart >> initializeValues [

	super initializeValues.
	
	presenterId := APEnumerationValuePart onPart: self key: #presenterId.
	presenterId enumeration: self idsEnumeration.
	
	partInterface description createAspectNamed: #presenterId.
   partInterface description createAspectNamed: #presenterIdValue redirectTo: #(presenterId value).
   partInterface description createAspectNamed: #presenterIdList redirectTo: #(presenterId enumerationTextList).

	self addDependentToAspects
]

{ #category : #'initialize-release' }
ApedNodeLayoutPart >> isNode [ 

	^ true
]

{ #category : #serialization }
ApedNodeLayoutPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#presenterId -> self presenterId value.
	}.
	
	^ assocs 
]

{ #category : #'initialize-release' }
ApedNodeLayoutPart >> labelString [ 

	^ self presenterId value asString
]

{ #category : #accessing }
ApedNodeLayoutPart >> maximalChildrenCount [

	^ 0
]

{ #category : #accessing }
ApedNodeLayoutPart >> presenterId [
	^ presenterId
]

{ #category : #accessing }
ApedNodeLayoutPart >> presenterId: anObject [
	presenterId := anObject
]

{ #category : #'initialize-release' }
ApedNodeLayoutPart >> presenterRemoved: anId [ 

	self presenterId value = anId ifTrue: [ self presenterId: nil ]
]

{ #category : #'initialize-release' }
ApedNodeLayoutPart >> previewLayout [ 

	^ self presenterId value 
		ifNotNil: [ :val | 
			(self form elementWithID: val) layoutRepresentation ]
		ifNil: [ nil ].
]
