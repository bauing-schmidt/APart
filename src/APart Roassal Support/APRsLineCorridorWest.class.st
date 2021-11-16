"
APRsLineCorridorWest is a line corridor heading to the West.


"
Class {
	#name : #APRsLineCorridorWest,
	#superclass : #APRsLineCorridorX,
	#category : #'APart Roassal Support-Paths'
}

{ #category : #API }
APRsLineCorridorWest class >> lineOrientationKey [

	^#lineOrientationWest
]

{ #category : #private }
APRsLineCorridorWest >> adaptFirstAreaToPrevious: previousAreas [
	"A corridor heading west never can start at a higher x than the right border of the vertical corridor that lead to its start.
	This adaption avoids that the corridor will later be dropped later because of intersection with a rectangle starting east of it."

	| previousRight firstArea |
	previousAreas isEmpty ifTrue: [^self].
	previousRight := previousAreas first right.
	2 to: previousAreas size
		do: [:i | previousRight := (previousAreas at: i) right max: previousRight].
	firstArea := areas first.
	firstArea right > previousRight
		ifTrue: [firstArea corner x: (previousRight max: firstArea left)]
]

{ #category : #private }
APRsLineCorridorWest >> endingPointForArea: a [

	^a left @ (a top midpoint: a bottom)
]

{ #category : #API }
APRsLineCorridorWest >> goNorthTo: y right: x [

	| refArea newArea |
	refArea := self firstArea.
	newArea := refArea left @ y corner: x @ refArea bottom.
	nextCorridor := APRsLineCorridorNorth withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorWest >> goNorthTo: y width: w [

	^self goNorthTo: y right: self firstArea left + w
]

{ #category : #API }
APRsLineCorridorWest >> goSouthTo: y right: x [

	| refArea newArea |
	refArea := self firstArea.
	newArea := refArea left @ refArea top corner: x @ y.
	nextCorridor := APRsLineCorridorSouth withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorWest >> goSouthTo: y width: w [

	^self goSouthTo: y right: self firstArea left + w
]

{ #category : #API }
APRsLineCorridorWest >> shrinkArea: a toLimitsOf: rectToAvoid [
	"If there is a neighbour area that stays connected, we may keep the shrunk area"
	| newAreaLeft |
	
	newAreaLeft := rectToAvoid right.
	(nextCorridor notNil and: [nextCorridor firstArea right > newAreaLeft])
		ifTrue: [ a origin x: newAreaLeft ]
		ifFalse: [ self shrinkToZeroHeight: a]
]

{ #category : #private }
APRsLineCorridorWest >> startingPointForArea: a [

	^a right @ (a top midpoint: a bottom)
]
