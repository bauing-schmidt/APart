"
I define form for general boolean form element properties
"
Class {
	#name : #ApedAbstractFormButtonPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedAbstractFormButtonPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#labelLabel -> #label.
		#labelLabelClickable -> #labelClickable.
	}

]

{ #category : #specs }
ApedAbstractFormButtonPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#labelLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Label'), ':' ].
		#label -> [ aPresenter newTextInput ].
		#labelLabelClickable -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Label clickable'), ':' ].
		#labelClickable -> [ aPresenter newCheckBox ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]
