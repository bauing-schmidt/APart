"
I define form for a drop list properties
"
Class {
	#name : #ApedDropListPresenterEditor,
	#superclass : #ApedListWidgetEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedDropListPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#hasEntryLabel -> #hasEntry.
	}

]

{ #category : #specs }
ApedDropListPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#hasEntryLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Has Entry'), ':' ].
		#hasEntry -> [ aPresenter newCheckBox ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedDropListPresenterEditor class >> matchingPartClasses [

	^ { ApedDropListPresenterPart }
]
