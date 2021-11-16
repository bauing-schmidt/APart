"
I'm calculating the encompassing rectangle of the whole shape hierarchy and manage updates of it
"
Class {
	#name : #APRsCoverageCalculator,
	#superclass : #Object,
	#instVars : [
		'encompassingRectangle'
	],
	#category : #'APart Roassal Support-Support'
}

{ #category : #accessing }
APRsCoverageCalculator >> encompassingRectangle [
	^ encompassingRectangle
]

{ #category : #accessing }
APRsCoverageCalculator >> encompassingRectangle: anObject [
	encompassingRectangle := anObject
]

{ #category : #initialization }
APRsCoverageCalculator >> initialize [

	super initialize.
	
	encompassingRectangle := Rectangle origin: 0@0 corner: 0@0.
]

{ #category : #initialization }
APRsCoverageCalculator >> reset [ 
	"To avoid the rectangle endlessly growing "
	
	encompassingRectangle := Rectangle origin: 0@0 corner: 0@0.
]

{ #category : #accessing }
APRsCoverageCalculator >> wrapperChanged: aWrapper [

	aWrapper position ifNotNil: [ 
		encompassingRectangle := encompassingRectangle merge: aWrapper boundingBox ].

]

{ #category : #accessing }
APRsCoverageCalculator >> wrapperChanged: aWrapper position: newPos [

	newPos ifNotNil: [ 
		encompassingRectangle := encompassingRectangle merge: aWrapper boundingBox ].
]
