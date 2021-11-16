"
I compute a line orientation key that describes the order of compass directions to be followed when drawing a rectangular line from a start rectangle to a destination rectangle.
"
Class {
	#name : #APRsPathFinder,
	#superclass : #Object,
	#instVars : [
		'lineOrientationKey',
		'corridorChains',
		'fullCoveredArea',
		'pathTitleToBreakOnCheck',
		'pathTitleToBreakOnMatch',
		'connectionLineStyle',
		'restrictToOutletEast'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #'API position' }
APRsPathFinder class >> computeOrientationKeyFrom: startRect toEast: endRectEast orSouth: endRectSouth minOverlap: minOverlap [

	(self
		isRect: startRect
		overlappingHorizontallyWith: endRectSouth
		minOverlap: minOverlap)
			ifTrue: 
				[^startRect top <= endRectSouth top
					ifTrue: [#lineOrientationSouth]
					ifFalse: [#lineOrientationNorth]].
	(self
		isRect: startRect
		overlappingVerticallyWith: endRectEast
		minOverlap: minOverlap)
			ifTrue: 
				[^startRect left <= endRectEast left
					ifTrue: [#lineOrientationEast]
					ifFalse: [#lineOrientationWest]].
	startRect left < endRectSouth left
		ifTrue: 
			[^startRect top < endRectEast top
				ifTrue: [#lineOrientationSouthEast]
				ifFalse: [#lineOrientationNorthEast]].
	^startRect top < endRectSouth top
		ifTrue: [#lineOrientationSouthWest]
		ifFalse: [#lineOrientationNorthWest]
]

{ #category : #'instance creation' }
APRsPathFinder class >> from: aStartRect toEast: anEndRectEast orSouth: anEndRectSouth lineStyle: aConnectionLineStyle restrictToOutlet: aSymbolOrNil [

	^ self new
		initOn: aConnectionLineStyle
		from: aStartRect
		toEast: anEndRectEast
		orSouth: anEndRectSouth
		restrictToOutlet: aSymbolOrNil
]

{ #category : #'API position' }
APRsPathFinder class >> isRect: rect1 overlappingHorizontallyWith: rect2 minOverlap: minOverlap [
	"true when given rects overlap in horizontal direction only, according to given minimum"

	| overlapToUse |
	overlapToUse := minOverlap min: rect1 width.
	rect1 right - overlapToUse < rect2 left ifTrue: [^false].
	^rect2 right - overlapToUse >= rect1 left
]

{ #category : #'API position' }
APRsPathFinder class >> isRect: rect1 overlappingVerticallyWith: rect2 minOverlap: minOverlap [

	| overlapToUse |
	overlapToUse := minOverlap min: rect1 height.
	rect1 bottom - overlapToUse < rect2 top ifTrue: [^false].
	^rect2 bottom - overlapToUse >= rect1 top
]

{ #category : #API }
APRsPathFinder class >> minBoxOverlapByDecorator: aDecorator [

	^aDecorator cornerRadius + 1
]

{ #category : #private }
APRsPathFinder >> allAreasDo: aBlock [

	corridorChains do: [:cc | cc chainDo: [:c | c areas do: aBlock]]
]

{ #category : #private }
APRsPathFinder >> computeCornerSpace [

	^(2 * connectionLineStyle cornerRadius + connectionLineStyle arrowLineWidth) asFloat
]

{ #category : #API }
APRsPathFinder >> corridorChains [

	^corridorChains
]

{ #category : #private }
APRsPathFinder >> debugBeforeCheckOn: c [

	pathTitleToBreakOnCheck
		ifNotNil: 
			[| currentCorridorTitle |
			currentCorridorTitle := self pathTitleForPath: c.
			currentCorridorTitle = pathTitleToBreakOnCheck ifTrue: [self halt]]
]

{ #category : #private }
APRsPathFinder >> debugBreakOnMatch: p [

	pathTitleToBreakOnMatch
		ifNotNil: 
			[(pathTitleToBreakOnMatch match: (self pathTitleForPath: p))
				ifTrue: [self halt]]
]

{ #category : #API }
APRsPathFinder >> directionName [

	^lineOrientationKey copyFrom: #lineOrientation size + 1
		to: lineOrientationKey size
]

{ #category : #API }
APRsPathFinder >> findPathAvoiding: rectsToAvoid [

	corridorChains do: 
			[:cc |
			self debugBeforeCheckOn: cc.
			(cc bestPathFromPoint: nil avoiding: rectsToAvoid)
				ifNotNil: 
					[:bestPath |
					self debugBreakOnMatch: bestPath.
					^bestPath]].
	^corridorChains first forcePathAvoiding: rectsToAvoid
]

{ #category : #API }
APRsPathFinder >> fullCoveredArea [

	^fullCoveredArea
]

{ #category : #'initialize-release' }
APRsPathFinder >> initOn: aConnectionLineStyle from: aStartRect toEast: anEndRectEast orSouth: anEndRectSouth restrictToOutlet: aSymbolOrNil [

	aSymbolOrNil ifNotNil: [ :s | s = #east ifTrue: [ restrictToOutletEast := true ] ].
	connectionLineStyle := aConnectionLineStyle.
	self
		setupCorridorChainsFrom: aStartRect
		toEast: anEndRectEast
		orSouth: anEndRectSouth.
	fullCoveredArea := (aStartRect left min: anEndRectSouth left)
				@ (aStartRect top min: anEndRectSouth top)
					corner: (aStartRect right max: anEndRectSouth right)
							@ (aStartRect bottom max: anEndRectSouth bottom).
	self allAreasDo: 
			[:a |
			| val |
			val := a left.
			fullCoveredArea left > val ifTrue: [fullCoveredArea origin x: val].
			val := a right.
			fullCoveredArea right < val ifTrue: [fullCoveredArea corner x: val].
			val := a top.
			fullCoveredArea top > val ifTrue: [fullCoveredArea origin y: val].
			val := a bottom.
			fullCoveredArea bottom < val ifTrue: [fullCoveredArea corner y: val]]
]

{ #category : #'initialize-release' }
APRsPathFinder >> initialize [ 
	restrictToOutletEast := false
]

{ #category : #API }
APRsPathFinder >> pathTitleForPath: aLinePathOrCorridor [

	^self pathTitleRoot, aLinePathOrCorridor title
]

{ #category : #API }
APRsPathFinder >> pathTitleRoot [

	^self directionName , '-by-'
]

{ #category : #'API debug' }
APRsPathFinder >> pathTitleToBreakOnCheck [

	^pathTitleToBreakOnCheck
]

{ #category : #'API debug' }
APRsPathFinder >> pathTitleToBreakOnCheck: anObject [

	pathTitleToBreakOnCheck := anObject
]

{ #category : #'API debug' }
APRsPathFinder >> pathTitleToBreakOnMatch [

	^pathTitleToBreakOnMatch
]

{ #category : #'API debug' }
APRsPathFinder >> pathTitleToBreakOnMatch: anObject [

	pathTitleToBreakOnMatch := anObject
]

{ #category : #printing }
APRsPathFinder >> printOn: s [

	super printOn: s.
	lineOrientationKey notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: lineOrientationKey;
				nextPut: $)]
]

{ #category : #accessing }
APRsPathFinder >> restrictToOutletEast [
	^ restrictToOutletEast
]

{ #category : #accessing }
APRsPathFinder >> restrictToOutletEast: anObject [
	restrictToOutletEast := anObject
]

{ #category : #'initialize-release' }
APRsPathFinder >> setupCorridorChainsFrom: aStartRect toEast: anEndRectEast orSouth: anEndRectSouth [

	lineOrientationKey := self class
				computeOrientationKeyFrom: aStartRect
				toEast: anEndRectEast
				orSouth: anEndRectSouth
				minOverlap: connectionLineStyle cornerRadius + 1.
	corridorChains := APRsLineCorridorChain
				corridorsFor: lineOrientationKey
				from: aStartRect
				toEast: anEndRectEast
				orSouth: anEndRectSouth
				cornerSpace: self computeCornerSpace
				restrictToOutletEast: restrictToOutletEast 
]
