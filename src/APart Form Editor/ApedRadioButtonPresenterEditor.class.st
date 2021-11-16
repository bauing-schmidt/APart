"
I define form for a radio button properties
"
Class {
	#name : #ApedRadioButtonPresenterEditor,
	#superclass : #ApedAbstractFormButtonPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #API }
ApedRadioButtonPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#labelLookupKey -> #lookupKey.
		#labelSelect -> #select.
	}

]

{ #category : #API }
ApedRadioButtonPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#labelLookupKey -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Lookup key'), ':' ].
		#lookupKey -> [ aPresenter newTextInput ].
		#labelSelect -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Select'), ':' ].
		#select -> [ aPresenter newTextInput ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedRadioButtonPresenterEditor class >> matchingPartClasses [

	^ { ApedRadioButtonPresenterPart }
]
