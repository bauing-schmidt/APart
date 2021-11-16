"
I extend the roassal camera with a convenience API.
"
Class {
	#name : #APRsCamera,
	#superclass : #RSCamera,
	#category : #'APart Roassal Support-Canvas'
}

{ #category : #convertion }
APRsCamera >> extent [ 

	^ extent
]

{ #category : #convertion }
APRsCamera >> focusOnCenterScaled [

]

{ #category : #convertion }
APRsCamera >> focusOnCenterScaled: aFactor [
	| sc rec |
	canvas numberOfShapes = 0 ifTrue: [ ^ self ].
	rec := canvas encompassingRectangle.
	self translateTo: rec center.
	sc := aFactor / ((rec extent) max: 1 @ 1).
	sc := (sc x < sc y) ifTrue: [sc x] ifFalse: [ sc y ].
	self scale: sc.
	^ sc
]

{ #category : #convertion }
APRsCamera >> fromPixelToSpace: aPoint [

	^ AthensAffineTransform new
		translateBy: self position;
		scaleBy: 1 / self scale;
		"translateBy: (self canvas extent / 2) negated;"
		transform: aPoint
]

{ #category : #convertion }
APRsCamera >> fromSpaceToPixel: aPoint [

	^ AthensAffineTransform new
	"	translateBy: self canvas extent / 2;"
		scaleBy: self scale;
		translateBy: self position negated;
		transform: aPoint
	
]

{ #category : #convertion }
APRsCamera >> privExtent: aRect [

	extent := aRect
]

{ #category : #convertion }
APRsCamera >> zoomToFit: anExtent rectangle: rect [
	| sc |
	sc := anExtent / (self class maxExtentFor: rect).
	sc := sc x min: sc y.
	self 
		translateTo: rect floatCenter;
		scale: sc.
]
