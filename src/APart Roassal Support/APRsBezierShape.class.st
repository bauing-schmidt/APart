"
I am a subclass to support dashes on the drawn line.
"
Class {
	#name : #APRsBezierShape,
	#superclass : #RSBezier,
	#instVars : [
		'dashes'
	],
	#category : #'APart Roassal Support-Shapes'
}

{ #category : #private }
APRsBezierShape >> basicEncompassingRectangle [

	^Rectangle origin: listOfPoints first corner: listOfPoints last
]

{ #category : #accessing }
APRsBezierShape >> center [

	^ self basicEncompassingRectangle center
]

{ #category : #accessing }
APRsBezierShape >> dashes [
	^ dashes
]

{ #category : #accessing }
APRsBezierShape >> dashes: anObject [
	dashes := anObject
]

{ #category : #drawing }
APRsBezierShape >> drawOn: athensCanvas [

	athensCanvas pathTransform restoreAfter: [ | p |
		
		athensCanvas setShape: self path.
		p := (athensCanvas setStrokePaint: self themedColor) width: width.
		dashes ifNotNil: [ :d | p dashes: dashes offset: 0].
		athensCanvas draw  ]
]
