"
I define form for a number input properties
"
Class {
	#name : #ApedNumberInputFieldPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedNumberInputFieldPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#minimumLabel -> #minimum.
		#maximumLabel -> #maximum.
		#climbRateLabel -> #climbRate.
		#digitsLabel -> #digits.
	}

]

{ #category : #specs }
ApedNumberInputFieldPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#maximumLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Maximum'), ':' ].
		#maximum -> [ aPresenter newNumberInput ].	
		#minimumLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Minimum'), ':' ].
		#minimum -> [ aPresenter newNumberInput ].
		#climbRateLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Climb rate'), ':' ].
		#climbRate -> [ aPresenter newNumberInput ].
		#digitsLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Digits'), ':' ].
		#digits -> [ aPresenter newNumberInput ]
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedNumberInputFieldPresenterEditor class >> matchingPartClasses [

	^ { ApedNumberInputFieldPresenterPart }
]
