"
APRsLineComputer is the abstract base class for all variants of line computer classes. Main task is computation of line paths between 2 points, see category API

"
Class {
	#name : #APRsLineComputer,
	#superclass : #Object,
	#instVars : [
		'connectionLineStyle',
		'positionFrom',
		'positionTo'
	],
	#category : #'APart Roassal Support-Paths'
}

{ #category : #API }
APRsLineComputer >> addDebugShapesTo: compositeShape [

	self subclassResponsibility
]

{ #category : #API }
APRsLineComputer >> computeLinePathFrom: startPos to: endPos [

	positionFrom := startPos.
	positionTo := endPos.
	"(startPos = Point zero and: [(endPos ifNil: [Point zero]) = startPos])
		ifTrue: [ ^ APRsLinePath new]."
	^self privateComputeLinePath
]

{ #category : #API }
APRsLineComputer >> pathPaintPolicy [

	^APRsPathPaintPolicy on: connectionLineStyle
		
]

{ #category : #private }
APRsLineComputer >> privateComputeLinePath [

	self subclassResponsibility
]

{ #category : #accessing }
APRsLineComputer >> roundCorners [

	^connectionLineStyle roundCorners
]

{ #category : #API }
APRsLineComputer >> updateSimpleOrComposedLinePosition [
	"Für Subklassen ist hier eventuell eine Reinitialisierung nötig"
]
