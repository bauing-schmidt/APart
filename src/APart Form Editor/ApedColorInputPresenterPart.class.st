"
I am a description of a color input presenter
"
Class {
	#name : #ApedColorInputPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedColorInputPresenterPart class >> iconName [

	^ #tcolorinput
]

{ #category : #accessing }
ApedColorInputPresenterPart class >> label [ 

	^ 'Color input'
]

{ #category : #preview }
ApedColorInputPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newColorInput
]

{ #category : #preview }
ApedColorInputPresenterPart >> setupPreviewPresenter: aPresenter [ 

	super setupPreviewPresenter: aPresenter.
	
	self exampleContent ifTrue: [ 
		aPresenter text: 'FEFEAA' ]
]
