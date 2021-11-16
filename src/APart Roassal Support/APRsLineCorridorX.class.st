"
APRsLineCorridorX is the base class for all horizontal variants of line corridors.
"
Class {
	#name : #APRsLineCorridorX,
	#superclass : #APRsLineCorridor,
	#category : #'APart Roassal Support-Paths'
}

{ #category : #private }
APRsLineCorridorX >> applyOwnAxisValueFrom: sourcePoint to: targetPoint [

	sourcePoint notNil ifTrue: [targetPoint x: sourcePoint x]
]

{ #category : #private }
APRsLineCorridorX >> basicResetToInitialBounds [

	areas := OrderedCollection with: (areas first left @ initialTop
						corner: areas first right @ initialBottom)
]

{ #category : #private }
APRsLineCorridorX >> cutArea: a avoiding: rectToAvoid [

	rectToAvoid top <= a top
		ifTrue: 
			[rectToAvoid bottom >= a bottom ifTrue: [^self shrinkToZeroHeight: a].
			a origin y: rectToAvoid bottom.
			^self].
	rectToAvoid bottom < a bottom
		ifTrue: [areas add: (a left @ rectToAvoid bottom corner: a right @ a bottom)].
	a corner y: rectToAvoid top
]

{ #category : #private }
APRsLineCorridorX >> isZeroSizeArea: a [

	^a height = 0
]
