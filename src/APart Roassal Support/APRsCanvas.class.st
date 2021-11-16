"
In APart, using a roassal canvas needs some more information always connected directly to the canvas. The subclass extends the roassal original with these data.
"
Class {
	#name : #APRsCanvas,
	#superclass : #RSCanvas,
	#instVars : [
		'partInterface',
		'inPlaceEditConnector',
		'focusShape',
		'updateEnabled',
		'isUpdating'
	],
	#category : #'APart Roassal Support-Canvas'
}

{ #category : #'instance creation' }
APRsCanvas class >> on: aPart [ 
	
	^ self new 
		partInterface: aPart partInterface;
		yourself
]

{ #category : #accessing }
APRsCanvas >> defaultEncompassingRectangle [

	^ Rectangle origin: 0@0 extent: 0@0.
]

{ #category : #accessing }
APRsCanvas >> encompassingRectangle [

	^ super encompassingRectangle.
]

{ #category : #accessing }
APRsCanvas >> inPlaceEditConnector [
	^ inPlaceEditConnector
]

{ #category : #accessing }
APRsCanvas >> inPlaceEditor [
	^ inPlaceEditConnector ifNotNil: [:c | c connectedEditor]
]

{ #category : #initialization }
APRsCanvas >> initialize [

	super initialize.
	camera := APRsCamera new
		canvas: self;
		yourself.
			
	camera originMode: #topLeft.
	isUpdating := false.
	updateEnabled := true.
		
	self resetInPlaceEditConnector
]

{ #category : #accessing }
APRsCanvas >> isUpdating [

	^ isUpdating
]

{ #category : #accessing }
APRsCanvas >> partInterface [
	^ partInterface
]

{ #category : #accessing }
APRsCanvas >> partInterface: anObject [
	partInterface := anObject
]

{ #category : #accessing }
APRsCanvas >> partsEncompassingRectangle [

	self partInterface ifNil: [ ^ self defaultEncompassingRectangle ].
	
	self partInterface description ifNil: [ ^ self defaultEncompassingRectangle ].
	
	^ (self partInterface description
		aspectFor: #encompassingRectangle 
		ifAbsent: [  self defaultEncompassingRectangle ]) value
]

{ #category : #API }
APRsCanvas >> removeAllNonFixedShapes [

	[shapes notEmpty] whileTrue: [ 
		shapes removeLast
	].

]

{ #category : #API }
APRsCanvas >> removeAllShapes [

	fixedShapes removeAll.
	self removeAllNonFixedShapes.

]

{ #category : #accessing }
APRsCanvas >> resetInPlaceEditConnector [

	inPlaceEditConnector := APRsInPlaceEditConnector new
]

{ #category : #accessing }
APRsCanvas >> setFocus: aBoolean [
	
 	aBoolean ifFalse: [ 
		focusShape ifNotNil: [
			self removeShape: focusShape.
			focusShape := nil
		].
		^self
	].
	focusShape := RSBox new
		color: ((Color fromHexString: '2A579A') alpha: 0.5);
		extent: 50@5 .
	self addFixedShape: focusShape.

		
	
]

{ #category : #accessing }
APRsCanvas >> signalUpdate [

	updateEnabled ifFalse: [ ^ self ]. 
	isUpdating := true.

	focusShape ifNotNil: [ 
		focusShape position: (self extent x half@0).
		focusShape width: self extent x.
	].
	super signalUpdate.
	isUpdating := false.

]

{ #category : #accessing }
APRsCanvas >> updateEnabled [

	^ updateEnabled
]

{ #category : #accessing }
APRsCanvas >> updateEnabled: anObject [

	updateEnabled := anObject
]

{ #category : #accessing }
APRsCanvas >> visibleRectangle [
	^ Rectangle 
		origin: self camera position 
		extent: self extent / self camera scale.
]
