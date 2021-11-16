"
APRsLineCorridorNorth is a line corridor heading to the North.
"
Class {
	#name : #APRsLineCorridorNorth,
	#superclass : #APRsLineCorridorY,
	#category : #'APart Roassal Support-Paths'
}

{ #category : #API }
APRsLineCorridorNorth class >> lineOrientationKey [

	^#lineOrientationNorth
]

{ #category : #private }
APRsLineCorridorNorth >> adaptFirstAreaToPrevious: previousAreas [
	"Ein Korridor in Richtung Norden kann von unten her niemals früher beginnen als beim äußersten unteren Rand des horizontalen Korridors, der zu ihm geführt hat.
	Diese Anpassung vermeidet u.U. den späteren Schnitt mit einem Rechteck, das vom Süden her überlappt."

	| previousBottom firstArea |
	previousAreas isEmpty ifTrue: [^self].
	previousBottom := previousAreas first bottom.
	2 to: previousAreas size
		do: [:i | previousBottom := (previousAreas at: i) bottom max: previousBottom].
	firstArea := areas first.
	firstArea bottom < previousBottom
		ifTrue: [firstArea corner y: (previousBottom max: firstArea top)]
]

{ #category : #private }
APRsLineCorridorNorth >> endingPointForArea: a [

	^(a left midpoint: a right) @ a top
]

{ #category : #API }
APRsLineCorridorNorth >> goEastTo: x bottom: y [

	| refArea newArea |
	refArea := self firstArea.
	newArea := refArea left @ refArea top corner: x @ y.
	nextCorridor := APRsLineCorridorEast withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorNorth >> goEastTo: x height: h [

	^self goEastTo: x bottom: self firstArea top + h
]

{ #category : #API }
APRsLineCorridorNorth >> goWestTo: x bottom: y [

	| refArea newArea |
	refArea := self firstArea.
	newArea := x @ refArea top corner: refArea right @ y.
	nextCorridor := APRsLineCorridorWest withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorNorth >> goWestTo: x height: h [

	^self goWestTo: x bottom: self firstArea top + h
]

{ #category : #API }
APRsLineCorridorNorth >> shrinkArea: a toLimitsOf: rectToAvoid [
	"If there is a neighbour area that stays connected, we may keep the shrunk area"
	| newAreaTop |
	
	newAreaTop := rectToAvoid bottom.
	(nextCorridor notNil and: [nextCorridor firstArea bottom > newAreaTop]) 
		ifTrue: [ a origin y: newAreaTop]
		ifFalse: [self shrinkToZeroWidth: a].


]

{ #category : #private }
APRsLineCorridorNorth >> startingPointForArea: a [

	^(a left midpoint: a right) @ a bottom
]
