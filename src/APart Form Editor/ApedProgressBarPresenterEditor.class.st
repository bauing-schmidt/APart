"
I define form for a progress bar properties
"
Class {
	#name : #ApedProgressBarPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedProgressBarPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
	}

]

{ #category : #specs }
ApedProgressBarPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedProgressBarPresenterEditor class >> matchingPartClasses [

	^ { ApedProgressBarPresenterPart }
]
