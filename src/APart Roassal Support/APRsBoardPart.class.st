"
Abstract base class for all parts with documaps roassal support (Drs)
"
Class {
	#name : #APRsBoardPart,
	#superclass : #APart,
	#instVars : [
		'canvas',
		'visibleCanvasSizeComputer',
		'visibleCanvasSize',
		'zoom',
		'coverageCalculator',
		'knownRoots',
		'locale'
	],
	#category : #'APart Roassal Support-Parts'
}

{ #category : #private }
APRsBoardPart class >> interfaceClass [

	^APRsPartInterface
]

{ #category : #'API events' }
APRsBoardPart >> activateItem: appItem at: position aspect: targetAspect [
	"Default: no action"
]

{ #category : #adding }
APRsBoardPart >> addPrototypeOf: aPrototypeClass from: appItem [

	| prototype aKey |
	
	aKey := aPrototypeClass name.
	
	self subPartAt: aKey ifNone: [ 
		prototype := aPrototypeClass onPart: self key: aPrototypeClass name ].
]

{ #category : #accessing }
APRsBoardPart >> adjustCanvasCameraAfterOpen [
	"Default: Keine Aktion"
	
]

{ #category : #'initialize-release' }
APRsBoardPart >> assignShapeElementOn: aShapePart to: trachelShape [

	trachelShape model ifNil: [ trachelShape model: aShapePart ]
]

{ #category : #private }
APRsBoardPart >> blockCanvasUpdates [

	canvas updateEnabled: false
]

{ #category : #API }
APRsBoardPart >> board [

	^self
]

{ #category : #private }
APRsBoardPart >> boardKeyMappings [

	^ Array new
]

{ #category : #private }
APRsBoardPart >> canUpdateCanvas [

	^canvas updateEnabled and: [ canvas isUpdating not]
]

{ #category : #accessing }
APRsBoardPart >> canvas [ 

	^ canvas
]

{ #category : #accessing }
APRsBoardPart >> canvasCamera [

	^ canvas camera
]

{ #category : #API }
APRsBoardPart >> canvasForKey: k [

	k = self mainCanvasKey ifTrue: [^ canvas].
	k = self downscaledCanvasKey ifTrue: [^self downscaledCanvas].
	^nil
]

{ #category : #accessing }
APRsBoardPart >> canvasToCamera: aPoint [ 
	"converts aPoint from canvas coordinates to ones that take into account the current camera shift and zoom level"

	^ (aPoint - self canvasCamera position) * self canvasCamera scale
]

{ #category : #accessing }
APRsBoardPart >> connectedInPlaceEditor [

	^self canvas inPlaceEditConnector connectedEditor
]

{ #category : #accessing }
APRsBoardPart >> coverageCalculator [

	^ coverageCalculator
]

{ #category : #private }
APRsBoardPart >> createCanvas [ 

	canvas := APRsCanvas on: self.
	self canvasCamera
		scale: 1;
		focusOnCenterScaled.
		
]

{ #category : #private }
APRsBoardPart >> defaultDispatcherClass [

	^ APRsBasicDispatcher 
]

{ #category : #'initialize-release' }
APRsBoardPart >> defineAspects [

	partInterface description
		createAllAspectsNamed: {#contextMenu. #encompassingRectangle}
]

{ #category : #API }
APRsBoardPart >> downscaledCanvas [
	"Default is no downscaled canvas"
	
	^nil
]

{ #category : #API }
APRsBoardPart >> downscaledCanvasKey [

	^#downscaledCanvas
]

{ #category : #accessing }
APRsBoardPart >> effectiveCanvasSize [

	^((visibleCanvasSize ifNil: [Point zero]) / zoom) rounded
]

{ #category : #accessing }
APRsBoardPart >> encompassingRectangle [

	^ self canvas encompassingRectangle
	"^ self coverageCalculator encompassingRectangle"
]

{ #category : #'API events' }
APRsBoardPart >> executePrimaryPointToActionFor: appItem at: pos targetAspect: targetAspect [
	"Default: no action"
]

{ #category : #'API events' }
APRsBoardPart >> executeSecondaryPointToActionFor: appItem at: pos targetAspect: targetAspect [
	"Default: no action"
]

{ #category : #accessing }
APRsBoardPart >> inPlaceEditConnector [

	^self canvas inPlaceEditConnector
]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeActions [

	super initializeActions.
	self initializeZoomActions.
	self initializeDispatchers.
]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeContextMenuPart [
	"By default, we dont have a context menu"
]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeDefaultDispatcher [
	
	| d |
	d := self defaultDispatcherClass onPart: self.
	d addKeyMappings: self boardKeyMappings.
	partInterface registerDispatcher: d
]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeDispatchers [

	self initializeDefaultDispatcher.
	self initializeSpecialDispatchers.
]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeSpecialDispatchers [
	"Empty here, override if needed"
	
]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeValues [

	super initializeValues.
	self createCanvas.
	
	coverageCalculator := APRsCoverageCalculator new.
	zoom := 1.
	self initializeContextMenuPart.

]

{ #category : #'initialize-release' }
APRsBoardPart >> initializeZoomActions [

	partInterface description
		createAction: #zoomBy:
			withArgumentDo: [ :factor | self privateZoomTo: zoom * factor ];
		createAction: #zoomTo:
			withArgumentDo: [ :newZoom | self privateZoomTo: newZoom ];
		createAction: #zoomIn do: [ self zoomIn ];
		createAction: #zoomOut do: [ self zoomOut ];
		createAction: #zoomRestore do: [ self zoomRestore ].
				

]

{ #category : #private }
APRsBoardPart >> isCanvasUpdating [

	^canvas isUpdating
]

{ #category : #accessing }
APRsBoardPart >> limitCanvasCamera [

	| cam contentRect cameraRect y |
	
	cam := self canvasCamera.
	contentRect := self encompassingRectangle.
	cameraRect := cam position extent: (canvas extent / cam scale).
			
	y := (cameraRect bottomRight y min: contentRect bottomRight y) - (canvas extent y / cam scale).
	y := contentRect topLeft y max: y.

	self setCameraTopLeftPosition: (cameraRect origin x)@y.
]

{ #category : #accessing }
APRsBoardPart >> locale [

	^ locale ifNil: [
		self rootPart ifNotNil: [:rp | 
			rp == self 
			ifTrue: [nil] 
			ifFalse: [rp locale]]
	]
]

{ #category : #API }
APRsBoardPart >> mainCanvasKey [

	^#mainCanvas
]

{ #category : #utilities }
APRsBoardPart >> pdmProjectDictionary [

	^self rootSystem pdmProjectDictionary
]

{ #category : #utilities }
APRsBoardPart >> pdmStandardNames [

	^self rootSystem pdmStandardNames
]

{ #category : #private }
APRsBoardPart >> privateZoomTo: zoomFactor [

	zoom := self restrictZoomToLimit: zoomFactor.
	self canvasCamera scale: zoom.
	self limitCanvasCamera.

]

{ #category : #API }
APRsBoardPart >> rearrangeAllItems [

	self subclassResponsibility
	
]

{ #category : #accessing }
APRsBoardPart >> registerVisibleCanvasExtent: aPoint [

	| lastSize |
	lastSize := visibleCanvasSize.
	visibleCanvasSize := aPoint.
	lastSize ifNil: [self adjustCanvasCameraAfterOpen]
]

{ #category : #private }
APRsBoardPart >> removeAllShapeParts [

	self subclassResponsibility 
	
]

{ #category : #private }
APRsBoardPart >> restrictZoomToLimit: newZoom [

	^ newZoom min: 3.0 max: 0.05
]

{ #category : #scrolling }
APRsBoardPart >> scrollDown [

	self canvasCamera translateBy: 0@self scrollStep.
	self limitCanvasCamera.
	
	self triggerCanvasUpdate.
]

{ #category : #scrolling }
APRsBoardPart >> scrollStep [

	^ 100 / self canvasCamera scale
]

{ #category : #private }
APRsBoardPart >> scrollToSee: aRectangle [
	
	| top | 
	
	self updateCanvasAfter: [ 
		(self visibleRectangle containsRect: aRectangle)
			ifTrue: [ ^ self ].

		top := aRectangle top.
		top := aRectangle top min: (self encompassingRectangle height - self visibleCanvasSize y ) max: 0.

		self setCameraTopLeftPosition: (0 @ top).
	]

]

{ #category : #scrolling }
APRsBoardPart >> scrollUp [

	self canvasCamera translateBy: 0@self scrollStep negated.
	self limitCanvasCamera.
	
	self triggerCanvasUpdate.
]

{ #category : #private }
APRsBoardPart >> setCameraTopLeftPosition: aPoint [ 

	^ self canvasCamera translateTo: aPoint
]

{ #category : #accessing }
APRsBoardPart >> setCanvasFocus: aBoolean [

	self canvas setFocus: aBoolean.
	self triggerCanvasUpdate.
	
	^ true
]

{ #category : #private }
APRsBoardPart >> singleSelection [ 
	self subclassResponsibility 
	
]

{ #category : #accessing }
APRsBoardPart >> trachelCanvas [

	^ self canvas
]

{ #category : #private }
APRsBoardPart >> triggerCanvasUpdate [

	self isReleased ifTrue: [ 
		"try to do canvas update for an already closed part"
		^ self ].
 
	(visibleCanvasSizeComputer notNil and: [visibleCanvasSize isNil])
		ifTrue: [^self].
	self canUpdateCanvas 
		ifFalse: [ ^self].
	"self sendNotification: #canvasUpdate."
	canvas signalUpdate

]

{ #category : #private }
APRsBoardPart >> unblockCanvasUpdates [

	canvas updateEnabled: true
]

{ #category : #private }
APRsBoardPart >> updateAfterResizeCanvas [

	visibleCanvasSizeComputer notNil
		ifTrue: [self registerVisibleCanvasExtent: visibleCanvasSizeComputer value]
]

{ #category : #API }
APRsBoardPart >> updateCanvasAfter: aBlock [

	self updateCanvasAfter: [:unused | aBlock value] origin: nil executeImmediately: true
]

{ #category : #API }
APRsBoardPart >> updateCanvasAfter: aBlock origin: aKey executeImmediately: shallExecuteNow [
	"In this class, we always execute immediately, because we do not provide background tasks here"
	
	aBlock cull: nil.
	self triggerCanvasUpdate.

]

{ #category : #accessing }
APRsBoardPart >> visibleCanvasSize [

	^visibleCanvasSize
]

{ #category : #accessing }
APRsBoardPart >> visibleCanvasSizeComputer [

	^ visibleCanvasSizeComputer
]

{ #category : #accessing }
APRsBoardPart >> visibleCanvasSizeComputer: anObject [

	visibleCanvasSizeComputer := anObject
]

{ #category : #accessing }
APRsBoardPart >> visibleRectangle [ 

	^ self canvasCamera position extent: self visibleCanvasSize.
]

{ #category : #accessing }
APRsBoardPart >> zoom [

	^ zoom
]

{ #category : #API }
APRsBoardPart >> zoomChangeFactor [

	^ 1.2
]

{ #category : #API }
APRsBoardPart >> zoomIn [

	self privateZoomTo: self zoom * self zoomChangeFactor.
	self triggerCanvasUpdate.

]

{ #category : #API }
APRsBoardPart >> zoomOut [

	self privateZoomTo: self zoom / self zoomChangeFactor.
	self triggerCanvasUpdate.

]

{ #category : #API }
APRsBoardPart >> zoomRestore [

	self privateZoomTo: 1
]
