"
APRsLineCorridorSouth is a line corridor heading to the South.


"
Class {
	#name : #APRsLineCorridorSouth,
	#superclass : #APRsLineCorridorY,
	#category : #'APart Roassal Support-Paths'
}

{ #category : #API }
APRsLineCorridorSouth class >> lineOrientationKey [

	^#lineOrientationSouth
]

{ #category : #private }
APRsLineCorridorSouth >> adaptFirstAreaToPrevious: previousAreas [
	"Ein Korridor in Richtung Süden kann von oben her niemals früher beginnen als beim äußersten oberen Rand des horizontalen Korridors, der zu ihm geführt hat.
	Diese Anpassung vermeidet u.U. den späteren Schnitt mit einem Rechteck, das vom Norden her überlappt."

	| previousTop firstArea |
	previousAreas isEmpty ifTrue: [^self].
	previousTop := previousAreas first top.
	2 to: previousAreas size
		do: [:i | previousTop := (previousAreas at: i) top min: previousTop].
	firstArea := areas first.
	firstArea top < previousTop
		ifTrue: [firstArea origin y: (previousTop min: firstArea bottom)]
]

{ #category : #private }
APRsLineCorridorSouth >> endingPointForArea: a [

	^(a left midpoint: a right) @ a bottom
]

{ #category : #API }
APRsLineCorridorSouth >> goEastTo: x height: h [

	^self goEastTo: x top: self firstArea bottom - h
]

{ #category : #API }
APRsLineCorridorSouth >> goEastTo: x top: y [

	| refArea newArea |
	refArea := self firstArea.
	newArea := refArea left @ y corner: x @ refArea bottom.
	nextCorridor := APRsLineCorridorEast withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorSouth >> goWestTo: x height: h [

	^self goWestTo: x top: self firstArea bottom - h
]

{ #category : #API }
APRsLineCorridorSouth >> goWestTo: x top: y [

	| refArea newArea |
	refArea := self firstArea.
	newArea := x @ y corner: refArea right @ (refArea bottom max: y).
	nextCorridor := APRsLineCorridorWest withArea: newArea.
	^nextCorridor
]

{ #category : #API }
APRsLineCorridorSouth >> shrinkArea: a toLimitsOf: rectToAvoid [
	"If there is a neighbour area that stays connected, we may keep the shrunk area"
	| newAreaBottom |
	
	newAreaBottom := rectToAvoid top.
	(nextCorridor notNil and: [nextCorridor firstArea top < newAreaBottom]) 
		ifTrue: [ a corner y: newAreaBottom ]
		ifFalse: [self shrinkToZeroWidth: a].
	
]

{ #category : #private }
APRsLineCorridorSouth >> startingPointForArea: a [

	^(a left midpoint: a right) @ a top
]
