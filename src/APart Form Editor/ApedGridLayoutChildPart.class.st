"
I describe properties of a child of a grid layout
"
Class {
	#name : #ApedGridLayoutChildPart,
	#superclass : #ApedLayoutChildPart,
	#instVars : [
		'x',
		'y',
		'spanX',
		'spanY'
	],
	#category : #'APart Form Editor-Layout Child Parts'
}

{ #category : #accessing }
ApedGridLayoutChildPart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(x y spanX spanY).
		
	self addDependentToAspects
]

{ #category : #accessing }
ApedGridLayoutChildPart >> initOnJson: aJsonObj [
	
	super initOnJson: aJsonObj.
	
	x := (aJsonObj at: #x ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	y := (aJsonObj at: #y ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	spanX := (aJsonObj at: #spanX ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	spanY := (aJsonObj at: #spanY ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedGridLayoutChildPart >> initializeValues [ 

	super initializeValues.
	
	x := y := spanX := spanY := 1
]

{ #category : #accessing }
ApedGridLayoutChildPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#x -> self x.
		#y -> self y.
		#spanX -> self spanX.
		#spanY -> self spanY.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedGridLayoutChildPart >> position [ 

	^ self safeX @ self safeY
]

{ #category : #accessing }
ApedGridLayoutChildPart >> safeSpanX [ 

	self spanX ifNil: [ ^ 1 ].
	
	^ self spanX asInteger max: 1
	
]

{ #category : #accessing }
ApedGridLayoutChildPart >> safeSpanY [

	self spanY ifNil: [ ^ 1 ].
	
	^ self spanY asInteger max: 1
	
]

{ #category : #accessing }
ApedGridLayoutChildPart >> safeX [ 

	self x ifNil: [ ^ 1 ].
	
	^ self x asInteger max: 1
	
]

{ #category : #accessing }
ApedGridLayoutChildPart >> safeY [ 

	self y ifNil: [ ^ 1 ].
	
	^ self y asInteger max: 1
	
]

{ #category : #accessing }
ApedGridLayoutChildPart >> span [ 

	^ self safeSpanX @ self safeSpanY
]

{ #category : #accessing }
ApedGridLayoutChildPart >> spanX [
	^ spanX
]

{ #category : #accessing }
ApedGridLayoutChildPart >> spanX: anObject [
	spanX := anObject
]

{ #category : #accessing }
ApedGridLayoutChildPart >> spanY [
	^ spanY
]

{ #category : #accessing }
ApedGridLayoutChildPart >> spanY: anObject [
	spanY := anObject
]

{ #category : #accessing }
ApedGridLayoutChildPart >> x [
	^ x
]

{ #category : #accessing }
ApedGridLayoutChildPart >> x: anObject [
	x := anObject
]

{ #category : #accessing }
ApedGridLayoutChildPart >> y [
	^ y
]

{ #category : #accessing }
ApedGridLayoutChildPart >> y: anObject [
	y := anObject
]
