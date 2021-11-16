"
I define form for editing of a frame layout properties
"
Class {
	#name : #ApedFrameLayoutEditor,
	#superclass : #ApedLayoutEditor,
	#category : #'APart Form Editor-Layout Editors'
}

{ #category : #specs }
ApedFrameLayoutEditor class >> aspectPairs [

	^ super aspectPairs, {
		#labelLabel -> #label.
	}

]

{ #category : #specs }
ApedFrameLayoutEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#labelLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Label'), ':' ].
		#label -> [ aPresenter newTextInput ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedFrameLayoutEditor class >> matchingPartClass [

	^ApedFrameLayoutPart
]
