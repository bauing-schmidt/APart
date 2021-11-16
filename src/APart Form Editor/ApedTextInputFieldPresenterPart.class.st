"
I am a description of a text input field presenter
"
Class {
	#name : #ApedTextInputFieldPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#instVars : [
		'isPassword',
		'maxLength',
		'placeholder',
		'exampleText',
		'editable',
		'password'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedTextInputFieldPresenterPart class >> iconName [

	^ #tedit
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart class >> label [ 

	^ 'Text input field'
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> editable [

	^ editable
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> editable: anObject [

	editable := anObject
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> exampleText [

	^ exampleText ifNil:['']
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> exampleText: anObject [

	exampleText := anObject
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	isPassword := (aJsonObj at: #isPassword ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	maxLength := (aJsonObj at: #maxLength ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	placeholder := (aJsonObj at: #placeholder ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	exampleText := (aJsonObj at: #exampleText ifAbsent: [ '' ]).
	editable := (aJsonObj at: #editable ifAbsent: [ true ]).

]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> initializeValues [

	super initializeValues.
	
	isPassword := false.
	maxLength := 0. 
	placeholder := ''. 
	exampleText := ''.
	editable := true.
	password := false.
	
	self partInterface description createAspectNamed: #isPassword.	
	self partInterface description createAspectNamed: #maxLength.	
	self partInterface description createAspectNamed: #placeholder.
	self partInterface description createAspectNamed: #exampleText.
	self partInterface description createAspectNamed: #editable.
	self partInterface description createAspectNamed: #password.
	
	self addDependentToAspects
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> isPassword [
	^ isPassword
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> isPassword: anObject [
	isPassword := anObject
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#isPassword -> self isPassword.
		#maxLength -> self maxLength.
		#placeholder -> self placeholder.
		#exampleText -> self exampleText.
		#editable -> self editable.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> maxLength [
	^ maxLength
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> maxLength: anObject [
	maxLength := anObject
]

{ #category : #preview }
ApedTextInputFieldPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newTextInput  
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> password [
	^ isPassword
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> password: aBoolean [
	isPassword := aBoolean
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> placeholder [
	^ placeholder
]

{ #category : #accessing }
ApedTextInputFieldPresenterPart >> placeholder: anObject [
	placeholder := anObject
]

{ #category : #preview }
ApedTextInputFieldPresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
	
	self isPassword 
		ifTrue: [ aPresenter bePassword ].
		
	aPresenter 
		maxLength: self maxLength asNumber;
		placeholder: self placeholder;
		text: self exampleText;
		editable: self editable.
]
