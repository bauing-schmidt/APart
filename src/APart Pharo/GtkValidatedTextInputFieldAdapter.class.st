Class {
	#name : #GtkValidatedTextInputFieldAdapter,
	#superclass : #GtkTextInputFieldAdapter,
	#instVars : [
		'ignoreChanged'
	],
	#category : #'APart Pharo'
}

{ #category : #protocol }
GtkValidatedTextInputFieldAdapter >> addModelTo: gtkEntry [ 
	
	"from GtkAbstractTextAdapter>>#addModelTo:"
	self addTextTo: gtkEntry. 
	self presenter whenTextChangedDo: [ :text | 
		self setText: text to: gtkEntry ].
	gtkEntry connectPopulatePopup: [ :menuWidget |
		self populatePopup: menuWidget  ].
	
	"from GtkTextInputFieldAdapter>>#addModelTo:"
	self connectChangedTo: gtkEntry.
	
	self presenter placeholder ifNotNil: [ :text | 
		gtkEntry placeHolderText: (text localizedForPresenter: self presenter) asString ].
	self presenter whenPlaceholderChangedDo: [ :text | 
		gtkEntry placeHolderText: (text localizedForPresenter: self presenter) asString ].
	
	gtkEntry maxLength: self model maxLength.
	self model whenMaxLengthChangedDo: [ gtkEntry maxLength: self presenter maxLength ].
	
	self presenter isPassword ifTrue: [ 
		gtkEntry bePassword.
		gtkEntry visibility: false. ].
	
	self presenter whenPasswordChangedDo: [ :isPassword | 
		isPassword
			ifFalse: [ gtkEntry beForAnyCharacter ]
			ifTrue: [ gtkEntry bePassword ].
		gtkEntry visibility: isPassword not ].
	

]

{ #category : #protocol }
GtkValidatedTextInputFieldAdapter >> connectChangedTo: gtkEntry [
	
	"from GtkTextInputFieldAdapter>>#addModelTo:"
	"sync presenter text and gtk"
	gtkEntry connectChanged: [ 
		ignoreChanged 
			ifFalse: [ 
				| originalText originalCursorPosition newPosition validationResult |
				
				originalText := gtkEntry text.
				originalCursorPosition := gtkEntry cursorPosition.
				
				validationResult := self presenter prevalidate: gtkEntry text cursorPosition: gtkEntry cursorPosition.
				originalText = validationResult key ifFalse: [ 
					ignoreChanged := true.
					[ 
						gtkEntry text: validationResult key.
					] ensure: [ ignoreChanged := false. ] ].
				
				newPosition := validationResult value.
				(newPosition notNil and: [ originalCursorPosition ~= newPosition  ])
					ifTrue: [ GtkRunLoop delayedDefer: [ gtkEntry setCursorPosition: validationResult value ] ].
				self presenter text: validationResult key ]
	  		ifTrue: [			 
				ignoreChanged := false ]].

]

{ #category : #protocol }
GtkValidatedTextInputFieldAdapter >> initialize [

	super initialize.
	
	ignoreChanged := false.
]

{ #category : #protocol }
GtkValidatedTextInputFieldAdapter >> text: aString [ 
	
	self setText: aString to: widget.
	self model text: aString.
]
