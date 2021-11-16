"
APRsLinePath contains the list of all points of a specific line path along with other abstract data that are needed for finally drawing the line.
"
Class {
	#name : #APRsLinePath,
	#superclass : #Object,
	#instVars : [
		'title',
		'points',
		'orientations'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #'instance creation' }
APRsLinePath class >> empty [

	^self new initialize
]

{ #category : #'instance creation' }
APRsLinePath class >> to: lastPoint orientation: lastOrientation [

	^(self empty)
		addFirstPoint: lastPoint orientation: lastOrientation;
		yourself
]

{ #category : #API }
APRsLinePath >> addFirstPoint: aPoint orientation: anOrientation [
	"Hinzugefügt wird immer am Anfang der Collection, weil der Algorithmus den Pfad vom Ende her aufbaut.
	Die Orientation an Indexposition i bezeichnet die Richtung der Linie von points at: i nach points at: i + 1.
	Die Orientation für den letzten Index ist initial nil. Für die spätere Weiterverarbeitung wird das jedoch noch geändert, siehe #finalizeOrientations"

	points addFirst: aPoint.
	orientations addFirst: anOrientation
]

{ #category : #API }
APRsLinePath >> extendStartingPointTo: orientation by: offset [
	"Entweder neuen Punkt in der gegebenen Richtung einfügen oder, falls der Pfad schon mit dieser Richtung beginnt, den ersten Punkt entsprechend verschieben"

	| p |
	p := points first.
	(orientations at: 2) = orientation
		ifFalse: 
			[p := p copy.
			points addFirst: p.
			orientations at: 1 put: orientation.
			orientations addFirst: nil].
	orientation = #lineOrientationEast ifTrue: [^p x: p x - offset].
	orientation = #lineOrientationWest ifTrue: [^p x: p x + offset].
	orientation = #lineOrientationSouth ifTrue: [^p y: p y - offset].
	orientation = #lineOrientationNorth ifTrue: [^p y: p y + offset].
	self aPartError: #lineOrientationUndefined text: 'Undefined line orientation: ' , orientation printString
]

{ #category : #API }
APRsLinePath >> finalizeOrientations [

	orientations last isNil
		ifTrue: [orientations addFirst: orientations removeLast]
]

{ #category : #'initialize-release' }
APRsLinePath >> initialize [

	points := OrderedCollection new.
	orientations := OrderedCollection new.
	title := String new
]

{ #category : #API }
APRsLinePath >> isEmpty [

	^points size < 2
]

{ #category : #API }
APRsLinePath >> lastCorners [

	^Array with: (points at: points size - 1) with: points last
]

{ #category : #accessing }
APRsLinePath >> orientations [

	^orientations
]

{ #category : #API }
APRsLinePath >> pathSteps [

	| pathSteps |
	pathSteps := OrderedCollection new: points size.
	1 to: points size
		do: [:i | pathSteps add: (orientations at: i) -> (points at: i)].
	^pathSteps
]

{ #category : #API }
APRsLinePath >> points [

	^points
]

{ #category : #printing }
APRsLinePath >> printOn: s [

	super printOn: s.
	title notNil
		ifTrue: 
			[s
				nextPutAll: ' "';
				nextPutAll: title;
				nextPut: $"]
]

{ #category : #API }
APRsLinePath >> resetPoints [

	self initialize
]

{ #category : #accessing }
APRsLinePath >> title [

	^title
]

{ #category : #accessing }
APRsLinePath >> title: anObject [

	title := anObject
]
