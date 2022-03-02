"
I am a description of a button presenter
"
Class {
	#name : #ApedButtonPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#instVars : [
		'label',
		'icon'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedButtonPresenterPart class >> iconName [

	^ #tbutton
]

{ #category : #accessing }
ApedButtonPresenterPart class >> label [ 

	^ 'Button'
]

{ #category : #accessing }
ApedButtonPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitButton: self
]

{ #category : #accessing }
ApedButtonPresenterPart >> icon [
	^ icon
]

{ #category : #accessing }
ApedButtonPresenterPart >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
ApedButtonPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	label := (aJsonObj at: #label ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	icon := (aJsonObj at: #icon ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedButtonPresenterPart >> initializeValues [

	super initializeValues.
	
	self partInterface description 
		createAspectNamed: #label;		
		createAspectNamed: #icon.
	self label: presenterId value.
		
	self addDependentToAspects
	
]

{ #category : #accessing }
ApedButtonPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#label -> self label.
		#icon -> self icon.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedButtonPresenterPart >> label [
	^ label ifNil:[self presenterId value]
]

{ #category : #accessing }
ApedButtonPresenterPart >> label: anObject [
	label := anObject
]

{ #category : #preview }
ApedButtonPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newButton
]

{ #category : #preview }
ApedButtonPresenterPart >> setupPreviewPresenter: aPresenter [ 

	super setupPreviewPresenter: aPresenter.
	
	aPresenter 
		label: self label asString.
		
	icon ifNotNil: [ 
		aPresenter icon: (self iconNamed: icon asString asSymbol) ].
]
