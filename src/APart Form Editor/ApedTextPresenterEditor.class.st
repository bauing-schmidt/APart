"
I define form for a multi-line text input properties
"
Class {
	#name : #ApedTextPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedTextPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#wrapWordLabel -> #wrapWord.
	}

]

{ #category : #specs }
ApedTextPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#wrapWordLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Wrap word'), ':' ].
		#wrapWord -> [ aPresenter newCheckBox ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedTextPresenterEditor class >> matchingPartClasses [

	^ { ApedTextPresenterPart }
]
