Class {
	#name : #APartTextInputFieldPresenter,
	#superclass : #SpTextInputFieldPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#instVars : [
		'prevalidation'
	],
	#category : #'APart Pharo'
}

{ #category : #specs }
APartTextInputFieldPresenter class >> adapterName [

	^ #ValidatedTextInputFieldAdapter
]

{ #category : #accessing }
APartTextInputFieldPresenter >> defaultModel [
	
	^ValueHolder new contents: String new
]

{ #category : #accessing }
APartTextInputFieldPresenter >> enabled: aBoolean [

	^ super enabled: aBoolean.
]

{ #category : #accessing }
APartTextInputFieldPresenter >> prevalidate: aString cursorPosition: aCursorPosition [

	"return association of the alteredString->newCursorPosition. Use nil to do not alter cursor position, -1 to move cursor at the end of text"
	
	prevalidation ifNil: [
		^ aString -> nil ].
		
	^ self owner client partInterface execute: prevalidation with: aString -> aCursorPosition ifDisabled: [ aString -> nil  ]
]

{ #category : #accessing }
APartTextInputFieldPresenter >> prevalidation [

	^ prevalidation
]

{ #category : #accessing }
APartTextInputFieldPresenter >> prevalidation: anObject [

	prevalidation := anObject
]

{ #category : #accessing }
APartTextInputFieldPresenter >> rawValueChanged: aString [
]

{ #category : #accessing }
APartTextInputFieldPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: aValueAdaptor notNil.
	
	(self rawValueHolderNamed: #text) whenChangedDo: [ :newValue :oldValue |
		self ignoreUpdates ifFalse: [ 
		newValue ifNotNil: [ 
			self rawValueChanged: (newValue asString ifEmpty: [ nil ]).
			aValueAdaptor value: (newValue asString ifEmpty: [ nil ]) ]]].
	
	aValueAdaptor addDependent: self.
	
	"initial update"
	(self rawValueHolderNamed: #text) value: (aValueAdaptor value).
	
	



	

	

]

{ #category : #accessing }
APartTextInputFieldPresenter >> update: anAspectSymbol with: aParameter from: aSender [

	self ignoreUpdatesWhile: [ 
	anAspectSymbol == #value ifTrue: [ 
		(self rawValueHolderNamed: #text) value: (aSender value ifNil: [''])] ].

]
