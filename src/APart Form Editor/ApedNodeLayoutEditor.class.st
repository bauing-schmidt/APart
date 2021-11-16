"
I define form for editing of a layout node
"
Class {
	#name : #ApedNodeLayoutEditor,
	#superclass : #ApedLayoutEditor,
	#category : #'APart Form Editor-Layout Editors'
}

{ #category : #specs }
ApedNodeLayoutEditor class >> aspectPairs [

	^ super aspectPairs, {
		#presenterIdLabel -> #presenterId.
	}

]

{ #category : #specs }
ApedNodeLayoutEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#presenterIdLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Presenter ID'), ':' ].
		#presenterId -> [ aPresenter newDropList 
			aspectSymbol: #presenterIdValue;
			choicesSymbol: #presenterIdList;
			id: #presenterId ].
	 }.
	
	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary

]

{ #category : #API }
ApedNodeLayoutEditor class >> matchingPartClass [

	^ApedNodeLayoutPart
]
