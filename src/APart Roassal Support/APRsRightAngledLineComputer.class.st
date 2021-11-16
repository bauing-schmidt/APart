"
APRsRightAngledLineComputer computes a line path between 2 rectangles without using the given startPoint and endPoint. Instead, it computes the attachment points for the given rectangles and only uses straight horizontal or vertical line segments. Furthermore, the computation tries to avoid crossing rectangular areas that already exist in the area between the 2 rectangles that shall be connected.


"
Class {
	#name : #APRsRightAngledLineComputer,
	#superclass : #APRsLineComputer,
	#instVars : [
		'endRect',
		'startRect',
		'hierarchy'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #'instance creation' }
APRsRightAngledLineComputer class >> on: aHierarchy style: aConnectionLineStyle startRect: aStartRect endRect: anEndRect [

	^self basicNew initOn: aHierarchy style: aConnectionLineStyle startRect: aStartRect endRect: anEndRect
]

{ #category : #private }
APRsRightAngledLineComputer >> areaToCheckForRectanglesToAvoid [

	^(startRect left min: endRect left) @ (startRect top min: endRect top)
		corner: (startRect right max: endRect right)
				@ (startRect bottom max: endRect bottom)
]

{ #category : #API }
APRsRightAngledLineComputer >> directionName [

	self subclassResponsibility
]

{ #category : #'initialize-release' }
APRsRightAngledLineComputer >> initOn: aHierarchy style: aConnectionLineStyle startRect: aStartRect endRect: anEndRect [

	hierarchy := aHierarchy.
	connectionLineStyle := aConnectionLineStyle.
	startRect := aStartRect.
	endRect := anEndRect.
	self initialize
]

{ #category : #API }
APRsRightAngledLineComputer >> pathTitleForPath: aLinePath [

	self subclassResponsibility
]

{ #category : #API }
APRsRightAngledLineComputer >> rectanglesToAvoid [

	^self rectanglesToAvoidByShapeSearch
]

{ #category : #private }
APRsRightAngledLineComputer >> rectanglesToAvoidByShapeSearch [

	| areaToCheck rectsToExclude toAvoid |
	areaToCheck := self areaToCheckForRectanglesToAvoid.
	rectsToExclude := Array with: startRect with: endRect.
	toAvoid := OrderedCollection new.
	hierarchy trachelCanvas shapes do: 
			[:sh |
			| r |
			(self shallIgnoreShapeElement: sh element)
				ifFalse: 
					[r := sh encompassingRectangle.
					(rectsToExclude contains: [:toExclude | toExclude contains: r])
						ifFalse: [(r intersects: areaToCheck) ifTrue: [toAvoid add: r]]]].
	^toAvoid
]

{ #category : #private }
APRsRightAngledLineComputer >> shallIgnoreShapeElement: aShapeElement [

	^false
]

{ #category : #API }
APRsRightAngledLineComputer >> shapesForLinePath: aLinePath [

	self subclassResponsibility
]
