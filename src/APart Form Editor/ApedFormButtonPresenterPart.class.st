"
I am a description of a general boolean form button presenter
"
Class {
	#name : #ApedFormButtonPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#instVars : [
		'label',
		'labelClickable'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #testing }
ApedFormButtonPresenterPart class >> isAbstract [ 

	^ true
]

{ #category : #accessing }
ApedFormButtonPresenterPart >> initializeValues [

	super initializeValues.
	
	self partInterface description 
		createAspectNamed: #label;
		createAspectNamed: #labelClickable.
		
	self addDependentToAspects
]

{ #category : #'as yet unclassified' }
ApedFormButtonPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#label -> self label.
		#labelClickable -> self labelClickable.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedFormButtonPresenterPart >> label [
	^ label
]

{ #category : #accessing }
ApedFormButtonPresenterPart >> label: anObject [
	label := anObject
]

{ #category : #accessing }
ApedFormButtonPresenterPart >> labelClickable [
	^ labelClickable
]

{ #category : #accessing }
ApedFormButtonPresenterPart >> labelClickable: anObject [
	labelClickable := anObject
]

{ #category : #preview }
ApedFormButtonPresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.

	aPresenter 
		label: self label;
		labelClickable: self labelClickable
]
