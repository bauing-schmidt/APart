"
I define form for a list properties
"
Class {
	#name : #ApedListPresenterEditor,
	#superclass : #ApedListWidgetEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedListPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#allowToSelectLabel->#allowToSelect.
		#autoDeselectLabel->#autoDeselect
	}

]

{ #category : #specs }
ApedListPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#allowToSelectLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Allow to select'), ':' ].
		#allowToSelect -> [ aPresenter newCheckBox ].
		#autoDeselectLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Auto deselect'), ':' ].
		#autoDeselect -> [ aPresenter newCheckBox ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedListPresenterEditor class >> matchingPartClasses [

	^ { ApedListPresenterPart }
]
