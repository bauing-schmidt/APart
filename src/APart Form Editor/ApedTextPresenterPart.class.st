"
I am a description of a multi-line text input presenter
"
Class {
	#name : #ApedTextPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#instVars : [
		'wrapWord'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedTextPresenterPart class >> iconName [

	^ #tmemo
]

{ #category : #accessing }
ApedTextPresenterPart class >> label [ 

	^ 'Text input'
]

{ #category : #visiting }
ApedTextPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitText: self
]

{ #category : #accessing }
ApedTextPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	wrapWord := (aJsonObj at: #wrapWord ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedTextPresenterPart >> initializeValues [

	super initializeValues.

	wrapWord := true.
	self partInterface description createAspectNamed: #wrapWord.	
		
	self addDependentToAspects
]

{ #category : #accessing }
ApedTextPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#wrapWord -> self wrapWord.
	}.
	
	^ assocs 
]

{ #category : #preview }
ApedTextPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newText
]

{ #category : #accessing }
ApedTextPresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
		
	aPresenter 
		wrapWord: self wrapWord.
		
	self exampleContent ifTrue: [ 
		aPresenter text: (String loremIpsum: 500) ]
]

{ #category : #accessing }
ApedTextPresenterPart >> wrapWord [
	^ wrapWord
]

{ #category : #accessing }
ApedTextPresenterPart >> wrapWord: anObject [
	wrapWord := anObject
]
