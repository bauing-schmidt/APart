"
I define form for a text input field properties
"
Class {
	#name : #ApedTextInputFieldPresenterEditor,
	#superclass : #ApedWidgetPresenterEditor,
	#category : #'APart Form Editor-Element Editors'
}

{ #category : #specs }
ApedTextInputFieldPresenterEditor class >> aspectPairs [

	^ super aspectPairs, {
		#editableLabel -> #editable.
		#passwordLabel -> #password.
		#exampleTextLabel -> #exampleText.
		#placeholderLabel -> #placeholder.
		#isPasswordLabel -> #isPassword.
		#maxLengthLabel -> #maxLength.
	}

]

{ #category : #specs }
ApedTextInputFieldPresenterEditor class >> associatedPresentersFor: aPresenter [

	| associations aDictionary  |
	
	associations := {  
		#exampleTextLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Example text'), ':' ].
		#exampleText -> [ aPresenter newTextInput ].
		#placeholderLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Placeholder'), ':' ].
		#placeholder -> [ aPresenter newTextInput ].
		#isPasswordLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Password'), ':' ].
		#isPassword -> [ aPresenter newCheckBox ].
		#maxLengthLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Max. length'), ':' ].
		#maxLength -> [ aPresenter newNumberInput ].
		#editableLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Editable'), ':' ].		
		#editable -> [ aPresenter newCheckBox ]. 
		#passwordLabel -> [ aPresenter newLabel label: (aPresenter aPartTranslate: 'Password'), ':' ].		
		#password -> [ aPresenter newCheckBox ]. 
	}.

	aDictionary := super associatedPresentersFor: aPresenter.
	aDictionary addAll: (OrderedDictionary newFrom: associations).
	^ aDictionary
]

{ #category : #API }
ApedTextInputFieldPresenterEditor class >> matchingPartClasses [

	^ { ApedTextInputFieldPresenterPart }
]
