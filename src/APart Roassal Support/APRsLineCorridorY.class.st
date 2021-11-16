"
APRsLineCorridorY is the base class for all vertical variants of line corridors.
"
Class {
	#name : #APRsLineCorridorY,
	#superclass : #APRsLineCorridor,
	#category : #'APart Roassal Support-Paths'
}

{ #category : #private }
APRsLineCorridorY >> applyOwnAxisValueFrom: sourcePoint to: targetPoint [

	sourcePoint notNil ifTrue: [targetPoint y: sourcePoint y]
]

{ #category : #private }
APRsLineCorridorY >> basicResetToInitialBounds [

	areas := OrderedCollection with: (initialLeft @ areas first top
						corner: initialRight @ areas first bottom)
]

{ #category : #private }
APRsLineCorridorY >> cutArea: a avoiding: rectToAvoid [
	"We already know that there must be an intersection. Result of shrinking might be a smaller or an empty area"

	rectToAvoid left <= a left
		ifTrue: 
			[rectToAvoid right >= a right ifTrue: [^self shrinkArea: a toLimitsOf: rectToAvoid].
			a origin x: rectToAvoid right.
			^self].
	rectToAvoid right < a right
		ifTrue: [areas add: (rectToAvoid right @ a top corner: a right @ a bottom)].
	a corner x: rectToAvoid left
]

{ #category : #private }
APRsLineCorridorY >> isZeroSizeArea: a [

	^a width = 0
]
