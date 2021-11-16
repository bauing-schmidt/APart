"
I define form with general widget properties
"
Class {
	#name : #ApedWidgetPresenterEditor,
	#superclass : #ApedPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedWidgetPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#aspectLabel -> #aspect.
		#sameIdAsAspectLabel -> #sameIdAsAspect.
		#presenterIdLabel -> #presenterId.
"		#visibleLabel -> #visible."
		#borderWidthLabel -> #borderWidth.
		#borderColorLabel -> #borderColor.
		#colorLabel -> #color.
		#helpLabel -> #help.
		#enabledLabel -> #enabled.
		#exampleContentLabel -> #exampleContent.
		#notesLabel -> #notes.
	}

]

{ #category : #specs }
ApedWidgetPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#aspectLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Aspect'), ':' ].
		#aspect -> [ aPresenter newTextInput ].
		#sameIdAsAspectLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Same ID as Aspect'), ':' ].
		#sameIdAsAspect -> [ aPresenter newCheckBox ].
		#presenterIdLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'ID'), ':' ].
		#presenterId -> [ aPresenter newTextInput ].
		#borderWidthLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Border width'), ':' ].
		#borderWidth -> [ aPresenter newNumberInput ].
		#borderColorLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Border color'), ':' ].
		#borderColor -> [ aPresenter newColorInput ].
		#colorLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Color'), ':' ].
		#color -> [ aPresenter newColorInput ].
		#helpLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Help'), ':' ].
		#help -> [ aPresenter newTextInput ].
		#enabledLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Enabled'), ':' ].
		#enabled -> [ aPresenter newCheckBox label: '' ].
		#exampleContentLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Example content'), ':' ].
		#exampleContent -> [ aPresenter newCheckBox label: '' ].
		#notesLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Notes'), ':' ].
		#notes -> [ aPresenter newTextInput ].
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedWidgetPresenterEditor class >> matchingPartClasses [

	^ { ApedWidgetPresenterPart }
]
