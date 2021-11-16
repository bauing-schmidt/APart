"
I define a form for properties of children of a box layout
"
Class {
	#name : #ApedBoxLayoutChildEditor,
	#superclass : #ApedLayoutChildEditor,
	#category : #'APart Form Editor-Layout Child Editors'
}

{ #category : #specs }
ApedBoxLayoutChildEditor class >> aspectPairs [

	^ super aspectPairs, {
		#expandLabel -> #expand.
		#fillLabel -> #fill.
		#paddingLabel -> #padding.
	}

]

{ #category : #specs }
ApedBoxLayoutChildEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#expandLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Expand'), ':' ].
		#expand -> [ aPresenter newCheckBox ].
		#fillLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Fill'), ':' ].
		#fill -> [ aPresenter newCheckBox ].
		#paddingLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Border width'), ':' ].
		#padding -> [ aPresenter newNumberInput ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedBoxLayoutChildEditor class >> matchingPartClass [

	^ApedBoxLayoutChildPart
]
