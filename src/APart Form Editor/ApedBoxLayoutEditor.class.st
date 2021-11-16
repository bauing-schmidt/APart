"
I define form for editing of a box layout properties
"
Class {
	#name : #ApedBoxLayoutEditor,
	#superclass : #ApedLayoutEditor,
	#category : #'APart Form Editor-Layout Editors'
}

{ #category : #specs }
ApedBoxLayoutEditor class >> aspectPairs [

	^ super aspectPairs, {
		#nameLabel -> #name.
		#directionLabel -> #direction.
		#spacingLabel -> #spacing.
		#borderWidthLabel -> #borderWidth.
		#homogeneousLabel -> #homogeneous.
	}

]

{ #category : #specs }
ApedBoxLayoutEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#nameLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Name'), ':' ].
		#name -> [ aPresenter newTextInput ].
		#directionLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Direction'), ':' ].
		#direction -> [ aPresenter newDropList 
			aspectSymbol: #directionsValue;
			choicesSymbol: #directionsList;
			id: #direction ].
		#spacingLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Spacing'), ':' ].
		#spacing -> [ aPresenter newNumberInput ].
		#borderWidthLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Border width'), ':' ].
		#borderWidth -> [ aPresenter newNumberInput ].
		#homogeneousLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Homogeneous'), ':' ].
		#homogeneous -> [ aPresenter newCheckBox ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedBoxLayoutEditor class >> matchingPartClass [

	^ApedBoxLayoutPart
]
