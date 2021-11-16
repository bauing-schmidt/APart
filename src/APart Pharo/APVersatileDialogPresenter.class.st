Class {
	#name : #APVersatileDialogPresenter,
	#superclass : #SpVersatileDialogPresenter,
	#instVars : [
		'title',
		'initialExtent',
		'expandContentVertically'
	],
	#category : #'APart Pharo'
}

{ #category : #accessing }
APVersatileDialogPresenter >> expandContentVertically [

	 ^ expandContentVertically ifNil: [ true ]
]

{ #category : #accessing }
APVersatileDialogPresenter >> expandContentVertically: aBoolean [

	expandContentVertically := aBoolean
]

{ #category : #accessing }
APVersatileDialogPresenter >> initialExtent [
	^ initialExtent ifNil: [ super initialExtent ]
]

{ #category : #accessing }
APVersatileDialogPresenter >> initialExtent: anObject [
	initialExtent := anObject
]

{ #category : #accessing }
APVersatileDialogPresenter >> initializeDialogWindow: aWindowPresenter [ 

	super initializeDialogWindow: aWindowPresenter.
	
	aWindowPresenter initialExtent: self initialExtent.
	
	aWindowPresenter title: title.
]

{ #category : #accessing }
APVersatileDialogPresenter >> layout [
	| mainLayout row |
	mainLayout := SpBoxLayout newVertical.
	mainLayout 
		borderWidth: 15;
		spacing: 15.

	"if the content area is not defined, place main message next to the main icon"
	contentArea
		ifNotNil: [ mainMessage
				ifNotNil: [ mainMessagePresenter := (mainMessage isString or: [ mainMessage isText ]) ifTrue: [ self newLabel label: mainMessage ] ifFalse: [ mainMessage ].
					mainMessagePresenter whenBuiltDo: [ :event | 
						self application backend name = #Gtk ifTrue: [ 
							event widget setLineWrap: true ] ].
					mainLayout add: #mainMessagePresenter expand: false. 
					] ].

	row := SpBoxLayout newHorizontal.

	mainIcon
		ifNotNil: [ mainIconPresenter := self newImage image: self mainIcon.
			row add: #mainIconPresenter withConstraints: [ :constraints | constraints width: self mainIcon width * 2 ] ].

	contentArea
		ifNotNil: [ contentAreaPresenter := (contentArea isString or: [ contentArea isText ]) ifTrue: [ self newLabel label: contentArea ] ifFalse: [ contentArea ].
			row add: (SpBoxLayout newVertical
				add: #contentAreaPresenter expand: self expandContentVertically) expand: true.] 
		ifNil: [ mainMessage
				ifNotNil: [ mainMessagePresenter := (mainMessage isString or: [ mainMessage isText ]) ifTrue: [ self newLabel label: mainMessage ] ifFalse: [ mainMessage ].
					mainMessagePresenter whenBuiltDo: [ :event | 
						self application backend name = #Gtk ifTrue: [ 
							event widget setLineWrap: true ] ].
					row add: #mainMessagePresenter expand: true] ].

	mainLayout add: row.

	row := SpBoxLayout newHorizontal spacing: 15.


	moreOptionsArea
		ifNotNil: [ moreOptionsButton label: (moreOptionsVisible ifFalse: [ self moreOptionsText ] ifTrue: [ self lessOptionsText ]).
			moreOptionsButton icon: (self iconNamed: (moreOptionsVisible ifFalse: [ #arrowDown ] ifTrue: [ #arrowUp ])).

			row add: #moreOptionsButton expand: false.
			moreOptionsAreaPresenter := (moreOptionsArea isString or: [ moreOptionsArea isText ]) ifTrue: [ self newLabel label: moreOptionsArea ] ifFalse: [ moreOptionsArea ] ].
	buttons keysAndValuesDo: [ :buttonKey :aButton | row add: buttonKey ].

	mainLayout add: row expand: false.

	moreOptionsVisible ifTrue: [ mainLayout add: #moreOptionsAreaPresenter ].

	footnoteArea
		ifNotNil: [ row := SpBoxLayout newHorizontal.
			footnoteIcon
				ifNotNil: [ footnoteIconPresenter := self newImage image: footnoteIcon.
					row add: #footnoteIconPresenter withConstraints: [ :constraints | constraints width: self footnoteIcon width * 2 ] ].

			footnoteAreaPresenter := (footnoteArea isString or: [ footnoteArea isText ]) ifTrue: [ self newLabel label: footnoteArea ] ifFalse: [ footnoteArea ].
			row add: #footnoteAreaPresenter ].
	mainLayout add: row expand: false.

	defaultButtonId ifNotNil: [ (self buttonAt: defaultButtonId) takeKeyboardFocus ].
	
	self presenterAt: #contentAreaPresenter put: contentAreaPresenter.
	self presenterAt: #mainMessagePresenter put: mainMessagePresenter.
	self presenterAt: #mainIconPresenter put: mainIconPresenter.
	^ mainLayout
]

{ #category : #accessing }
APVersatileDialogPresenter >> title: aString [

	title := aString
]

{ #category : #accessing }
APVersatileDialogPresenter >> translate: aDeferredTranslationOrString [ 

	^ aDeferredTranslationOrString translateFor: self application locale 
]
