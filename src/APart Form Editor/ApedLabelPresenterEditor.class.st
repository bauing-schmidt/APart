"
I define form for a label properties
"
Class {
	#name : #ApedLabelPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedLabelPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#labelLabel -> #label.
	}

]

{ #category : #specs }
ApedLabelPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#labelLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Label'), ':' ].
		#label -> [ aPresenter newTextInput ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedLabelPresenterEditor class >> matchingPartClasses [

	^ { ApedLabelPresenterPart }
]
