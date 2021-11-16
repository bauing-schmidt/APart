"
APRsLineCorridorEast is a line corridor heading to the East.


"
Class {
	#name : #APRsLineCorridorEast,
	#superclass : #APRsLineCorridorX,
	#category : #'APart Roassal Support-Paths'
}

{ #category : #API }
APRsLineCorridorEast class >> lineOrientationKey [

	^#lineOrientationEast
]

{ #category : #private }
APRsLineCorridorEast >> adaptFirstAreaToPrevious: previousAreas [
	"Ein Korridor in Richtung Osten kann von links her niemals früher beginnen als beim äußersten linken Rand des vertikalen Korridors, der zu ihm geführt hat.
	Diese Anpassung vermeidet u.U. den späteren Schnitt mit einem Rechteck, das vom Westen her überlappt."

	| previousLeft firstArea |
	previousAreas isEmpty ifTrue: [^self].
	previousLeft := previousAreas first left.
	2 to: previousAreas size
		do: [:i | previousLeft := (previousAreas at: i) left min: previousLeft].
	firstArea := areas first.
	firstArea left < previousLeft
		ifTrue: [firstArea origin x: (previousLeft min: firstArea right)]
]

{ #category : #private }
APRsLineCorridorEast >> endingPointForArea: a [

	^a right @ (a top midpoint: a bottom)
]

{ #category : #API }
APRsLineCorridorEast >> goNorthTo: y left: x [

	| refArea newArea |
	refArea := self firstArea.
	newArea := x @ y corner: refArea right @ refArea bottom.
	nextCorridor := APRsLineCorridorNorth withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorEast >> goNorthTo: y width: w [

	^self goNorthTo: y left: self firstArea right - w
]

{ #category : #API }
APRsLineCorridorEast >> goSouthTo: y left: x [

	| refArea newArea |
	refArea := self firstArea.
	newArea := x @ refArea top corner: refArea right @ y.
	nextCorridor := APRsLineCorridorSouth withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorEast >> goSouthTo: y width: w [

	^self goSouthTo: y left: self firstArea right - w
]

{ #category : #API }
APRsLineCorridorEast >> shrinkArea: a toLimitsOf: rectToAvoid [
	"If there is a neighbour area that stays connected, we may keep the shrunk area"
	| newAreaRight |
	
	newAreaRight := rectToAvoid left.
	(nextCorridor notNil and: [ nextCorridor firstArea left < newAreaRight ]) 
		ifTrue: [ a corner x: newAreaRight]
		ifFalse: [self shrinkToZeroHeight: a].
	
]

{ #category : #private }
APRsLineCorridorEast >> startingPointForArea: a [

	^a left @ (a top midpoint: a bottom)
]
