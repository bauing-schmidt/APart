"
I am a description of a status bar presenter
"
Class {
	#name : #ApedStatusBarPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedStatusBarPresenterPart class >> iconName [

	^ #tstatusbar
]

{ #category : #accessing }
ApedStatusBarPresenterPart class >> label [ 

	^ 'Status bar'
]

{ #category : #visiting }
ApedStatusBarPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitStatusBar: self
]

{ #category : #preview }
ApedStatusBarPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newStatusBar
]

{ #category : #preview }
ApedStatusBarPresenterPart >> setupPreviewPresenter: aPresenter [ 

	super setupPreviewPresenter: aPresenter.
	
	self exampleContent ifTrue: [ 
		aPresenter message: 'Ready...' ]
]
