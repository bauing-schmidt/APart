"
EN:APTrApplicationItem is the abstract base class for an application object that is required when building an APTrShapeNode.
An ApplicationItem mediates between the business logic and concrete trachel shapes (held in ShapeWrapper objects):
- It takes over the initialization of APTrShapePart objects by building their concrete ShapeWrapper.
- As a representative of the APTrShapePart objects, it interprets the contents of the shapes in order to determine values for the new creation or for the change of application objects.

An ApplicationItem represents business logic. Therefore, it makes sense to mirror the variance of the business logic in the class structure of the items. In contrast, the class variance of the ShapePart hierarchy can be limited to general basic types (e.g. node, link).

DE:APTrApplicationItem ist die abstrakte Basisklasse für ein Anwendungsobjekt, das beim Aufbau eines APTrShapeNode benötigt wird.
Ein ApplicationItem vermittelt zwischen der Geschäftslogik und konkreten Trachel-Shapes (gehalten in ShapeWrapper-Objekten):
- Es übernimmt die Initialisierung von APTrShapePart-Objekten, indem es deren konkrete ShapeWrapper aufbaut. 
- Stellvertretend für die APTrShapePart-Objekte interpretiert es die Inhalte der Shapes, um daraus Werte für die Neuanlage bzw. für die Änderung von Anwendungsobjekten zu ermitteln.

Ein ApplicationItem repräsentiert Geschäftslogik. Von daher ist es sinnvoll, die Varianz der Geschäftslogik in der Klassenstruktur der Items zu spiegeln. Demgegenüber kann sich die Klassenvarianz der ShapePart-Hierarchie auf generelle Grundtypen beschränken (z.B. Node, Link).
"
Class {
	#name : #APRsApplicationItem,
	#superclass : #Object,
	#category : #'APart Roassal Support-Items'
}

{ #category : #'instance creation' }
APRsApplicationItem class >> create [

	^self new initialize
]

{ #category : #API }
APRsApplicationItem >> createShapePartOnClass: aShapePartClass under: aParentPart [
	^ self
		createShapePartOnClass: aShapePartClass
		under: aParentPart
		at: nil
]

{ #category : #API }
APRsApplicationItem >> createShapePartOnClass: aShapePartClass under: aParentPart at: aPoint [
	^ self
		createShapePartOnClass: aShapePartClass
		under: aParentPart
		preInit: #yourself
		at: aPoint
]

{ #category : #API }
APRsApplicationItem >> createShapePartOnClass: aShapePartClass under: aParentPart preInit: extraPreInitBlock at: aPoint [
	| shapePart |
	shapePart := aShapePartClass
		onPart: aParentPart
		key: (self keyForShapePartUnder: aParentPart)
		preInit: [ :p | self preInitShapePart: p with: extraPreInitBlock ].
	^ shapePart
		connectWrappersWithCanvasesAt: aPoint;
		yourself
]

{ #category : #API }
APRsApplicationItem >> createShapePartUnder: aParentPart [

	^ self createShapePartOnClass: self shapePartClass under: aParentPart
]

{ #category : #API }
APRsApplicationItem >> estimatedSizeUsing: aDecorator [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> indexInParent [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> joinShapePart: aShapePart [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> keyForShapePartUnder: aParentPart [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> onSelectionBlock [
	"Default, may be overwritten"
	
	^ [ :item |  ]
]

{ #category : #API }
APRsApplicationItem >> parentItem [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> preInitShapePart: p with: extraPreInitBlock [
	p joinAppItem: self.
	 extraPreInitBlock value: p 
]

{ #category : #'initialize-release' }
APRsApplicationItem >> setupAllWrappers [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> shapePart [

	self subclassResponsibility
]

{ #category : #API }
APRsApplicationItem >> shapePartClass [

	self subclassResponsibility 
]
