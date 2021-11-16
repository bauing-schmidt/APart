Class {
	#name : #ApedListWidgetEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedListWidgetEditor class >> aspectPairs [

	^ super aspectPairs, {	
		#ownExampleContentLabel -> #ownExampleContent.
	}

]

{ #category : #specs }
ApedListWidgetEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#ownExampleContentLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Own Examplecontent'), ':' ].
		#ownExampleContent -> [ aPresenter newText ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]
