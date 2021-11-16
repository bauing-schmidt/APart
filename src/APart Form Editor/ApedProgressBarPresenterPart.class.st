"
I am a description of a progress bar presenter
"
Class {
	#name : #ApedProgressBarPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedProgressBarPresenterPart class >> iconName [

	^ #tprogressbar
]

{ #category : #accessing }
ApedProgressBarPresenterPart class >> label [ 

	^ 'Progress bar'
]

{ #category : #accessing }
ApedProgressBarPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newProgressBar
]

{ #category : #preview }
ApedProgressBarPresenterPart >> setupPreviewPresenter: aPresenter [ 

	super setupPreviewPresenter: aPresenter.
	
	self exampleContent ifTrue: [ 
		aPresenter fixedPercentage: 42.0 ]
]
