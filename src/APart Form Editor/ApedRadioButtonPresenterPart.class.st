"
I am a description of a radio button presenter
"
Class {
	#name : #ApedRadioButtonPresenterPart,
	#superclass : #ApedFormButtonPresenterPart,
	#instVars : [
		'lookupKey',
		'select'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedRadioButtonPresenterPart class >> iconName [

	^ #tradiobutton
]

{ #category : #testing }
ApedRadioButtonPresenterPart class >> isAbstract [ 

	^ false
]

{ #category : #accessing }
ApedRadioButtonPresenterPart class >> label [ 

	^ 'Radio button'
]

{ #category : #preview }
ApedRadioButtonPresenterPart >> defineAspects [ 

	super defineAspects.

	partInterface description 
		createAllAspectsNamed: #(lookupKey select id).
		
	self addDependentToAspects
]

{ #category : #accessing }
ApedRadioButtonPresenterPart >> lookupKey [
	^ lookupKey
]

{ #category : #accessing }
ApedRadioButtonPresenterPart >> lookupKey: anObject [
	lookupKey := anObject
]

{ #category : #preview }
ApedRadioButtonPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newRadioButton
]

{ #category : #accessing }
ApedRadioButtonPresenterPart >> select [
	^ select
]

{ #category : #accessing }
ApedRadioButtonPresenterPart >> select: anObject [
	select := anObject
]
