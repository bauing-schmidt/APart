"
I define form for a status bar properties
"
Class {
	#name : #ApedStatusBarPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedStatusBarPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
	}

]

{ #category : #specs }
ApedStatusBarPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedStatusBarPresenterEditor class >> matchingPartClasses [

	^ { ApedStatusBarPresenterPart }
]
