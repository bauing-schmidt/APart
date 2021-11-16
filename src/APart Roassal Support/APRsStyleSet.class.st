"
I am a container for different types of styles 
"
Class {
	#name : #APRsStyleSet,
	#superclass : #APRsDecoratorStyle,
	#instVars : [
		'styles'
	],
	#category : #'APart Roassal Support-Styles'
}

{ #category : #'instance creation' }
APRsStyleSet class >> with: styleNames in: styleSheet [

	^ self new 
		initializeFrom: styleNames in: styleSheet
]

{ #category : #'instance creation' }
APRsStyleSet class >> withAll: styles [

	"this style set creation method should be avoided"

	| styleSet | 
	styleSet := self new.
	styleSet styles addAll: styles.
	^ styleSet
]

{ #category : #API }
APRsStyleSet >> applyStyleTo: aWrapperOrCanvas [
	"We inherit, but don not directly apply styles"
	
	self shouldNotImplement 
]

{ #category : #API }
APRsStyleSet >> findLabelStyle [

	^ styles detect: [ :s | s isLabelStyle ] ifNone: [  ]
]

{ #category : #API }
APRsStyleSet >> findLineStyle [

	^ styles detect: [ :s | s isLineStyle ] ifNone: [  ]
]

{ #category : #initialization }
APRsStyleSet >> initialize [ 

	super initialize.
	styles := Set new.
]

{ #category : #initialization }
APRsStyleSet >> initializeFrom: styleNames in: styleSheet [

	styleNames do: [ :styleName |
		styles add: (styleSheet styleFor: styleName) ]
]

{ #category : #accessing }
APRsStyleSet >> styles [
	^ styles
]

{ #category : #accessing }
APRsStyleSet >> styles: anObject [
	styles := anObject
]
