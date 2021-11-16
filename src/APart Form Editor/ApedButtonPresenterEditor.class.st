"
I define form for a button properties
"
Class {
	#name : #ApedButtonPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedButtonPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#labelLabel -> #label.
		#iconLabel -> #icon.
	}

]

{ #category : #specs }
ApedButtonPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#labelLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Label'), ':' ].
		#label -> [ aPresenter newTextInput ].
		#iconLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Icon'), ':' ].
		#icon -> [ aPresenter newTextInput ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedButtonPresenterEditor class >> matchingPartClasses [

	^ { ApedButtonPresenterPart }
]
