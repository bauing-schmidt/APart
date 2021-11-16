"
I describe properties of a child of a box layout
"
Class {
	#name : #ApedBoxLayoutChildPart,
	#superclass : #ApedLayoutChildPart,
	#instVars : [
		'expand',
		'fill',
		'padding'
	],
	#category : #'APart Form Editor-Layout Child Parts'
}

{ #category : #accessing }
ApedBoxLayoutChildPart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(expand fill padding).
		
	fill := false.
	expand := false.
		
	self addDependentToAspects
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> expand [
	^ expand
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> expand: anObject [
	expand := anObject
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> fill [
	^ fill
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> fill: anObject [
	fill := anObject
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> initOnJson: aJsonObj [
	
	super initOnJson: aJsonObj.
	
	expand := (aJsonObj at: #expand ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	fill := (aJsonObj at: #fill ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	padding := (aJsonObj at: #padding ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedBoxLayoutChildPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#expand -> self expand.
		#fill -> self fill.
		#padding -> self padding.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> padding [
	^ padding
]

{ #category : #accessing }
ApedBoxLayoutChildPart >> padding: anObject [
	padding := anObject
]
