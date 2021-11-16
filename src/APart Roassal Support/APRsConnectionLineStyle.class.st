"
I am a decorator style defining the appearance of an APTrShapeWrapper for complex connection lines.
"
Class {
	#name : #APRsConnectionLineStyle,
	#superclass : #APRsLineStyle,
	#instVars : [
		'arrowHeadClass',
		'linkConnectionStyle',
		'roundCorners',
		'shortcutCorners'
	],
	#category : #'APart Roassal Support-Styles'
}

{ #category : #API }
APRsConnectionLineStyle class >> defaultConnectionStyle [

	^self supportedConnectionStyles first
]

{ #category : #API }
APRsConnectionLineStyle class >> supportedConnectionStyles [

	^#(#connectionStyleDirect #connectionStyleRectangular #connectionStyleRectangularCached) 
]

{ #category : #API }
APRsConnectionLineStyle >> applyStyleTo: aLabelWrapper [
	super applyStyleTo: aLabelWrapper.
	aLabelWrapper applyConnectionLineStyle: self.
]

{ #category : #accessing }
APRsConnectionLineStyle >> arrowHeadClass [
	^ arrowHeadClass
]

{ #category : #accessing }
APRsConnectionLineStyle >> arrowHeadClass: anObject [
	arrowHeadClass := anObject
]

{ #category : #API }
APRsConnectionLineStyle >> arrowLineWidth [
	^lineWidth
]

{ #category : #initialization }
APRsConnectionLineStyle >> initialize [

	super initialize.
	cornerRadius := 7.
	linkConnectionStyle := self class defaultConnectionStyle.
	arrowHeadClass := nil.
	roundCorners := false.
	shortcutCorners := false
]

{ #category : #accessing }
APRsConnectionLineStyle >> linkConnectionStyle [
	^ linkConnectionStyle
]

{ #category : #accessing }
APRsConnectionLineStyle >> linkConnectionStyle: anObject [
	linkConnectionStyle := anObject
]

{ #category : #accessing }
APRsConnectionLineStyle >> roundCorners [
	^ roundCorners
]

{ #category : #accessing }
APRsConnectionLineStyle >> roundCorners: anObject [
	roundCorners := anObject
]

{ #category : #accessing }
APRsConnectionLineStyle >> shortcutCorners [
	^ shortcutCorners
]

{ #category : #accessing }
APRsConnectionLineStyle >> shortcutCorners: anObject [
	shortcutCorners := anObject
]
