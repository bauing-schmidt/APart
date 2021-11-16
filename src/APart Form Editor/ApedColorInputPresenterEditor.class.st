"
I define form for a color input properties
"
Class {
	#name : #ApedColorInputPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedColorInputPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
	}

]

{ #category : #specs }
ApedColorInputPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedColorInputPresenterEditor class >> matchingPartClasses [

	^ { ApedColorInputPresenterPart }
]
