"
APRsPathPaintPolicy provides an API to create all graphical shapes for a given line path:
* #shapesForPathSteps:nodeFrom:nodeTo:

For decorating the line path, it uses a given APRsConnectionLineStyle.
"
Class {
	#name : #APRsPathPaintPolicy,
	#superclass : #Object,
	#instVars : [
		'connectionLineStyle'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #'instance creation' }
APRsPathPaintPolicy class >> on: aConnectionLineStyle [

	^self basicNew initOn: aConnectionLineStyle
]

{ #category : #private }
APRsPathPaintPolicy class >> oppositeOrientationOf: orientation [

	orientation = #lineOrientationEast ifTrue: [^#lineOrientationWest].
	orientation = #lineOrientationWest ifTrue: [^#lineOrientationEast].
	orientation = #lineOrientationSouth ifTrue: [^#lineOrientationNorth].
	^orientation = #lineOrientationNorth ifTrue: [#lineOrientationSouth]
]

{ #category : #private }
APRsPathPaintPolicy >> cornerShapeOnCorner: p2 fromBefore: p1 toBehind: p3 [

	p1 = p3 ifTrue: [^nil].
	connectionLineStyle roundCorners
		ifTrue: [
			| shape |
			shape := APRsBezierShape new
				controlPoints: (Array with: p1 with: p2 with: p3);
				color: connectionLineStyle lineColor;
				width: connectionLineStyle arrowLineWidth;
				model: #(#rectangularLine #corner);
				yourself.
			connectionLineStyle dashes 
				ifNotNil: [ shape dashArray: connectionLineStyle dashes ].
			^ shape ].
	^self straightLineShapeFrom: p1 to: p3 orientation: #corner
]

{ #category : #accessing }
APRsPathPaintPolicy >> dashes [

	^connectionLineStyle dashes
]

{ #category : #'initialize-release' }
APRsPathPaintPolicy >> initOn: aConnectionLineStyle [

	connectionLineStyle := aConnectionLineStyle.

]

{ #category : #private }
APRsPathPaintPolicy >> insetLineEndPoint: p by: defaultDelta orientation: orientationKey checkUnderflow: oppositePoint [

	^self
		insetLineStartPoint: p
		by: defaultDelta
		orientation: (self class oppositeOrientationOf: orientationKey)
		checkUnderflow: oppositePoint
]

{ #category : #private }
APRsPathPaintPolicy >> insetLineStartPoint: p by: defaultDelta orientation: orientationKey checkUnderflow: oppositePoint [

	| delta lineSize |
	delta := defaultDelta.
	(orientationKey = #lineOrientationEast
		or: [orientationKey = #lineOrientationWest])
			ifTrue: 
				[lineSize := (p x - oppositePoint x) abs.
				lineSize < delta ifTrue: [delta := lineSize].
				orientationKey = #lineOrientationEast ifTrue: [^p leftBy: delta].
				^p rightBy: delta].
	(orientationKey = #lineOrientationSouth
		or: [orientationKey = #lineOrientationNorth])
			ifTrue: 
				[lineSize := (p y - oppositePoint y) abs.
				lineSize < delta ifTrue: [delta := lineSize].
				orientationKey = #lineOrientationSouth ifTrue: [^p upBy: delta].
				^p downBy: delta].
	^p
]

{ #category : #private }
APRsPathPaintPolicy >> linesWithShapedCornersForPathSteps: steps nodeFrom: nodeStart nodeTo: nodeEnd [

	| resultShapes radius orientation cornerFrom lineFrom lineTo |

	resultShapes := OrderedCollection new: steps size * 2.
	radius := connectionLineStyle cornerRadius.
	cornerFrom := steps first value.
	lineTo := nil.
	orientation := nil.
	2 to: steps size
		do: 
			[:i |
			| cornerTo |
			cornerTo := (steps at: i) value.
			orientation := (steps at: i) key.
			lineFrom := cornerFrom.
			lineTo notNil
				ifTrue: 
					[lineFrom := self
								insetLineEndPoint: lineFrom
								by: radius
								orientation: orientation
								checkUnderflow: cornerTo.
					"Ein Corner geht immer vom Endpunkt der Linie im vorherigen Schleifendurchgang aus
					und endet dort, wo die neue Linie beginnen wird."
					(self cornerShapeOnCorner: cornerFrom fromBefore: lineTo toBehind: lineFrom)
						ifNotNil: [:cornerShape | resultShapes add: cornerShape]].
			lineTo := i < steps size
						ifTrue: 
							[self
								insetLineStartPoint: cornerTo
								by: radius
								orientation: orientation
								checkUnderflow: lineFrom]
						ifFalse: [cornerTo].
			resultShapes add: (self
						straightLineShapeFrom: lineFrom
						to: lineTo
						orientation: orientation).
			cornerFrom := cornerTo].
	^resultShapes
]

{ #category : #API }
APRsPathPaintPolicy >> shapesForPathSteps: steps nodeFrom: nodeStart nodeTo: nodeEnd [

	| resultShapes |
	(connectionLineStyle roundCorners or: [connectionLineStyle shortcutCorners])
		ifTrue: 
			[^self
				linesWithShapedCornersForPathSteps: steps
				nodeFrom: nodeStart
				nodeTo: nodeEnd].
	resultShapes := OrderedCollection new: steps size.
	2 to: steps size
		do: 
			[:i |
			resultShapes add: (self
						straightLineShapeFrom: (steps at: i - 1) value
						to: (steps at: i) value
						orientation: (steps at: i) key)].
	^resultShapes
]

{ #category : #private }
APRsPathPaintPolicy >> straightLineShapeFrom: pointFrom to: pointTo orientation: orientation [

	| s |
	s := RSLine new
				startPoint: pointFrom;
				endPoint: pointTo;
				width: connectionLineStyle arrowLineWidth;
				color: connectionLineStyle lineColor;
				strokePaint: connectionLineStyle lineColor;
				model: (Array with: #rectangularLine with: orientation);
				yourself.
	self dashes ifNotNil: [:d | s dashes: d].
	^s
]
