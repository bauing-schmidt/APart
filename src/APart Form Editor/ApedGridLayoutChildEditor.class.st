"
I define a form for properties of children of a grid layout
"
Class {
	#name : #ApedGridLayoutChildEditor,
	#superclass : #ApedLayoutChildEditor,
	#category : #'APart Form Editor-Layout Child Editors'
}

{ #category : #specs }
ApedGridLayoutChildEditor class >> aspectPairs [

	^ super aspectPairs, {
		#labelX -> #x.
		#labelY -> #y.
		#labelSpanX -> #spanX.
		#labelSpanY -> #spanY.
	}

]

{ #category : #specs }
ApedGridLayoutChildEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#labelX -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'X'), ':' ].
		#x -> [ aPresenter newNumberInput ].
		#labelY -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Y'), ':' ].
		#y -> [ aPresenter newNumberInput ].
		#labelSpanX -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Span X'), ':' ].
		#spanX -> [ aPresenter newNumberInput ].
		#labelSpanY -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Span Y'), ':' ].
		#spanY -> [ aPresenter newNumberInput ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedGridLayoutChildEditor class >> matchingPartClass [

	^ApedGridLayoutChildPart
]
