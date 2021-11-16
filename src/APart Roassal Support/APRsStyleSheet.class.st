"
I provide dictionary of named styles
"
Class {
	#name : #APRsStyleSheet,
	#superclass : #Object,
	#instVars : [
		'styles'
	],
	#category : #'APart Roassal Support-Styles'
}

{ #category : #accessing }
APRsStyleSheet class >> default [ 

	^ self new
	
	
]

{ #category : #'API styles' }
APRsStyleSheet >> add: styleName as: anAPTrDecoratorStyle [

	styles at: styleName put: anAPTrDecoratorStyle
]

{ #category : #initialization }
APRsStyleSheet >> initialize [

	super initialize.
	styles := Dictionary new
]

{ #category : #'API styles' }
APRsStyleSheet >> styleFor: styleName [ 

	^ (styles at: styleName) copy
]

{ #category : #'API styles' }
APRsStyleSheet >> styleSetNamed: styleName [ 

	| styleSet |
	styleSet := styles at: styleName.
	(styleSet isKindOf: APRsStyleSet) ifFalse: [ self pdmError: #PdmErrorNoStyleSet].
	^styleSet
]
