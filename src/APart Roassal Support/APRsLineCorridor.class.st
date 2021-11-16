"
APRsLineCorridor is a helper for APRsPathFinder. A line corridor is a rectangle with a given orientation, either X or Y. The whole corridor can be separated in stripes (in direction of orientation) in order to spare specific areas. A line corridor may have a neighbour directly connected (see nextCorridor). Connected corridors always have the opposite orientation. All joined corridors finally define the whole area available for a line path, whereas the respective spared areads per corridor are to be respected.

The base class tries to implement everything independent of orientation. Only specific functions are routed to orientation-specific subclasses by means of defined subclass responsibilities.
"
Class {
	#name : #APRsLineCorridor,
	#superclass : #Object,
	#instVars : [
		'title',
		'areas',
		'nextCorridor',
		'isUnreachable',
		'initialBottom',
		'initialTop',
		'initialRight',
		'initialLeft'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #API }
APRsLineCorridor class >> lineOrientationKey [

	self subclassResponsibility
]

{ #category : #'instance creation' }
APRsLineCorridor class >> withArea: anArea [

	^self new initOn: anArea
]

{ #category : #'instance creation' }
APRsLineCorridor class >> withArea: anArea title: aTitle [

	^(self withArea: anArea)
		title: aTitle;
		yourself
]

{ #category : #private }
APRsLineCorridor >> adaptFirstAreaToPrevious: previousAreas [
	"Siehe Kommentare in den Implementationen der Subklassen"

	self subclassResponsibility
]

{ #category : #private }
APRsLineCorridor >> applyOwnAxisValueFrom: sourcePoint to: targetPoint [

	self subclassResponsibility
]

{ #category : #API }
APRsLineCorridor >> areas [

	^areas
]

{ #category : #private }
APRsLineCorridor >> basicResetToInitialBounds [

	self subclassResponsibility
]

{ #category : #API }
APRsLineCorridor >> bestPathFromPoint: aPoint avoiding: rectsToAvoid [

	areas do: 
			[:a |
			| connectionPoint currentEndingPoint |
			(self isZeroSizeArea: a)
				ifFalse: 
					[connectionPoint := self startingPointForArea: a.
					self applyOwnAxisValueFrom: aPoint to: connectionPoint.
					currentEndingPoint := self endingPointForArea: a.
					(nextCorridor notNil
						ifTrue: 
							[nextCorridor bestPathFromPoint: currentEndingPoint avoiding: rectsToAvoid]
						ifFalse: [APRsLinePath to: currentEndingPoint orientation: nil])
							ifNotNil: 
								[:best |
								best addFirstPoint: connectionPoint orientation: self lineOrientationKey.
								aPoint isNil
									ifTrue: 
										[best
											finalizeOrientations;
											title: self title].
								^best]]].
	^nil
]

{ #category : #API }
APRsLineCorridor >> chainDo: aBlock [

	aBlock value: self.
	nextCorridor notNil ifTrue: [nextCorridor chainDo: aBlock]
]

{ #category : #API }
APRsLineCorridor >> chainDo: aBlock separatedBy: separatorBlock [

	aBlock value: self.
	nextCorridor notNil
		ifTrue: 
			[separatorBlock value.
			nextCorridor chainDo: aBlock separatedBy: separatorBlock]
]

{ #category : #private }
APRsLineCorridor >> cleanupZeroSizeAreas [

	| areasToKeep |
	areasToKeep := areas reject: [:a | self isZeroSizeArea: a].
	areasToKeep size = areas size ifTrue: [^self].
	areasToKeep isEmpty
		ifTrue: 
			[areas := OrderedCollection with: areas first.
			^self].
	areas := areasToKeep
]

{ #category : #private }
APRsLineCorridor >> cutArea: a avoiding: aRect [

	self subclassResponsibility
]

{ #category : #API }
APRsLineCorridor >> cutCorridorsAvoidingAll: rectsToAvoid adaptToPrevious: previousAreas [

	self adaptFirstAreaToPrevious: previousAreas.
	rectsToAvoid do: 
			[:r |
			(areas select: [:a | a intersects: r])
				do: [:a | self cutArea: a avoiding: r]].
	areas size > 1 ifTrue: [self cleanupZeroSizeAreas].
	nextCorridor isNil ifTrue: [^self].
	(self isZeroSizeArea: areas first)
		ifTrue: 
			[nextCorridor setUnreachable.
			^self].
	nextCorridor cutCorridorsAvoidingAll: rectsToAvoid adaptToPrevious: areas
]

{ #category : #API }
APRsLineCorridor >> directionName [

	| k |
	k := self lineOrientationKey.
	^k copyFrom: #lineOrientation size + 1 to: k size
]

{ #category : #private }
APRsLineCorridor >> endingPointForArea: a [

	self subclassResponsibility
]

{ #category : #API }
APRsLineCorridor >> firstArea [

	^areas first
]

{ #category : #API }
APRsLineCorridor >> firstPathFromPoint: aPoint [

	| a connectionPoint currentEndingPoint firstPath |
	a := areas first.
	connectionPoint := self startingPointForArea: a.
	self applyOwnAxisValueFrom: aPoint to: connectionPoint.
	currentEndingPoint := self endingPointForArea: a.
	firstPath := nextCorridor notNil
				ifTrue: [nextCorridor firstPathFromPoint: currentEndingPoint]
				ifFalse: 
					[APRsLinePath to: currentEndingPoint orientation: nil].
	firstPath addFirstPoint: connectionPoint orientation: self lineOrientationKey.
	^firstPath
]

{ #category : #API }
APRsLineCorridor >> forcePathAvoiding: rectsToAvoid [
	"In der ersten Implementation werden die zu vermeidenden Rechtecke nicht beachtet"

	| p |
	self resetToInitialBounds.
	p := self firstPathFromPoint: nil.
	p
		finalizeOrientations;
		title: self title.
	^p
]

{ #category : #'initialize-release' }
APRsLineCorridor >> initOn: anArea [

	areas := OrderedCollection with: anArea.
	initialTop := anArea top.
	initialBottom := anArea bottom.
	initialLeft := anArea left.
	initialRight := anArea right.
	isUnreachable := false
]

{ #category : #API }
APRsLineCorridor >> initialArea [

	^Rectangle
		left: initialLeft
		right: initialRight
		top: initialTop
		bottom: initialBottom
]

{ #category : #API }
APRsLineCorridor >> isUnreachable [

	^isUnreachable
]

{ #category : #private }
APRsLineCorridor >> isZeroSizeArea: a [

	self subclassResponsibility
]

{ #category : #API }
APRsLineCorridor >> lastCorridor [

	^nextCorridor ifNotNil: [nextCorridor lastCorridor] ifNil: [self]
]

{ #category : #API }
APRsLineCorridor >> lineOrientationKey [

	^self class lineOrientationKey
]

{ #category : #API }
APRsLineCorridor >> nextCorridor [

	^nextCorridor
]

{ #category : #printing }
APRsLineCorridor >> printDetailsOn: s [

	areas size > 0
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: areas size printString;
				nextPutAll: ' areas)'].
	nextCorridor notNil
		ifTrue: 
			[s
				nextPut: ${;
				nextPutAll: self title;
				nextPut: $}]
]

{ #category : #printing }
APRsLineCorridor >> printOn: s [

	super printOn: s.
	self printDetailsOn: s
]

{ #category : #API }
APRsLineCorridor >> resetToInitialBounds [

	self basicResetToInitialBounds.
	nextCorridor notNil ifTrue: [nextCorridor resetToInitialBounds]
]

{ #category : #API }
APRsLineCorridor >> setUnreachable [

	isUnreachable := true.
	nextCorridor notNil ifTrue: [nextCorridor setUnreachable]
]

{ #category : #API }
APRsLineCorridor >> shrinkArea: a toLimitsOf: rectToAvoid [

	self subclassResponsibility 
]

{ #category : #private }
APRsLineCorridor >> shrinkToZeroHeight: aRect [

	| centeredY |
	centeredY := aRect top midpoint: aRect bottom.
	aRect origin y: centeredY.
	aRect corner y: centeredY
]

{ #category : #private }
APRsLineCorridor >> shrinkToZeroWidth: aRect [

	| centeredX |
	centeredX := aRect left midpoint: aRect right.
	aRect origin x: centeredX.
	aRect corner x: centeredX
]

{ #category : #private }
APRsLineCorridor >> startingPointForArea: a [

	self subclassResponsibility
]

{ #category : #API }
APRsLineCorridor >> title [

	| s |
	s := WriteStream on: String new.
	self chainDo: [:c | s nextPutAll: c directionName]
		separatedBy: [s nextPut: $-].
	^s contents
]
