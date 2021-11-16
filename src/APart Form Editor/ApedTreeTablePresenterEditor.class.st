"
I define form for a tree table properties
"
Class {
	#name : #ApedTreeTablePresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedTreeTablePresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
	}

]

{ #category : #specs }
ApedTreeTablePresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedTreeTablePresenterEditor class >> matchingPartClasses [

	^ { ApedTreeTablePresenterPart }
]
