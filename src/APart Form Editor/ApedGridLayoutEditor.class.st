"
I define form for editing of a grid layout properties
"
Class {
	#name : #ApedGridLayoutEditor,
	#superclass : #ApedLayoutEditor,
	#category : #'APart Form Editor-Layout Editors'
}

{ #category : #specs }
ApedGridLayoutEditor class >> aspectPairs [

	^ super aspectPairs, {
		#nameLabel -> #name.
		#borderWidthLabel -> #borderWidth.
		#columnSpacingLabel -> #columnSpacing.
		#rowSpacingLabel -> #rowSpacing.
		#columnHomogeneousLabel -> #columnHomogeneous.
		#rowHomogeneousLabel -> #rowHomogeneous.
	}

]

{ #category : #specs }
ApedGridLayoutEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#nameLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Name'), ':' ].
		#name -> [ aPresenter newTextInput ].
		#borderWidthLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Border width'), ':' ].
		#borderWidth -> [ aPresenter newNumberInput ].
		#columnSpacingLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Column spacing'), ':' ].
		#columnSpacing -> [ aPresenter newNumberInput ].
		#rowSpacingLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Row spacing'), ':' ].
		#rowSpacing -> [ aPresenter newNumberInput ].
		#columnHomogeneousLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Column homogeneous'), ':' ].
		#columnHomogeneous -> [ aPresenter newCheckBox ].
		#rowHomogeneousLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Row homogeneous'), ':' ].
		#rowHomogeneous -> [ aPresenter newCheckBox ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedGridLayoutEditor class >> matchingPartClass [

	^ApedGridLayoutPart
]
