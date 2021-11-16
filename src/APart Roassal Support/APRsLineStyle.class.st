"
I am a decorator style defining the appearance of an APTrShapeWrapper that needs a style for a simple line.
"
Class {
	#name : #APRsLineStyle,
	#superclass : #APRsDecoratorStyle,
	#instVars : [
		'lineColor',
		'backgroundColor',
		'lineWidth',
		'dashes',
		'cornerRadius'
	],
	#category : #'APart Roassal Support-Styles'
}

{ #category : #API }
APRsLineStyle >> applyStyleTo: aWrapper [
	
	aWrapper applyLineStyle: self.
]

{ #category : #accessing }
APRsLineStyle >> arrowHeadClass [
	"Compatibility for subclass"
	
	^nil
]

{ #category : #accessing }
APRsLineStyle >> arrowLineWidth [
	"Compatibility with subclass"
	
	^ self lineWidth
]

{ #category : #accessing }
APRsLineStyle >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
APRsLineStyle >> backgroundColor: anObject [
	backgroundColor := anObject
]

{ #category : #accessing }
APRsLineStyle >> cornerRadius [
	^ cornerRadius
]

{ #category : #accessing }
APRsLineStyle >> cornerRadius: anObject [
	cornerRadius := anObject
]

{ #category : #accessing }
APRsLineStyle >> dashes [
	^ dashes
]

{ #category : #accessing }
APRsLineStyle >> dashes: anObject [
	dashes := anObject
]

{ #category : #initialization }
APRsLineStyle >> initialize [

	super initialize.
	lineColor := Color gray: 0.7.
	backgroundColor := Color transparent.
	lineWidth := 2.
	cornerRadius := 5.
	dashes := nil.
]

{ #category : #API }
APRsLineStyle >> isLineStyle [ 

	^true
]

{ #category : #accessing }
APRsLineStyle >> lineColor [
	^ lineColor
]

{ #category : #accessing }
APRsLineStyle >> lineColor: anObject [
	lineColor := anObject
]

{ #category : #accessing }
APRsLineStyle >> lineWidth [
	^ lineWidth
]

{ #category : #accessing }
APRsLineStyle >> lineWidth: anObject [
	lineWidth := anObject
]

{ #category : #accessing }
APRsLineStyle >> linkConnectionStyle [
	"Compatibility with subclass"
	
	^ APRsConnectionLineStyle defaultConnectionStyle 
]

{ #category : #accessing }
APRsLineStyle >> roundCorners [
	"Compatibility with subclass"
	
	^ false
]

{ #category : #accessing }
APRsLineStyle >> shortcutCorners [
	"Compatibility with subclass"
	
	^ false
]
