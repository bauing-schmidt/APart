Class {
	#name : #APartStatusBarPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#instVars : [
		'#message => SpObservableSlot'
	],
	#category : #'APart Pharo'
}

{ #category : #specs }
APartStatusBarPresenter class >> adapterName [

	^ #StatusBarAdapter
]

{ #category : #accessing }
APartStatusBarPresenter >> canTakeKeyboardFocus [

	^ false
]

{ #category : #accessing }
APartStatusBarPresenter >> defaultModel [
	
	^ValueHolder new contents: String new
]

{ #category : #accessing }
APartStatusBarPresenter >> enabled: aBoolean [

	^ super enabled: aBoolean.
]

{ #category : #accessing }
APartStatusBarPresenter >> message [
	^ message
]

{ #category : #accessing }
APartStatusBarPresenter >> message: aString [
	message := aString
]

{ #category : #accessing }
APartStatusBarPresenter >> popMessage [ 
	
	self message: nil.
	self changed: #popMessage
]

{ #category : #accessing }
APartStatusBarPresenter >> pushMessage: aString [ 
	
	| localized | 
	
	localized := aString  
		ifNil: [ '' ] 
		ifNotNil: [ aString localizedForPresenter: self ].
	
	self message: localized.
	self changed: #pushMessage
]

{ #category : #accessing }
APartStatusBarPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: aValueAdaptor notNil.
	
	(self rawValueHolderNamed: #message) whenChangedDo: [ :newValue :oldValue |
		self ignoreUpdates ifFalse: [ 
		newValue ifNotNil: [ 
			aValueAdaptor value: (newValue asString ifEmpty: [ nil ]) ]]].
	
	aValueAdaptor addDependent: self.
	
	"initial update"
	(self rawValueHolderNamed: #message) value: (aValueAdaptor value)



	

	

]

{ #category : #accessing }
APartStatusBarPresenter >> update: anAspectSymbol with: aParameter from: aSender [

	self ignoreUpdatesWhile: [ 
	anAspectSymbol == #value ifTrue: [
		(self rawValueHolderNamed: #message) value: (aSender value ifNil: ['']).
		self pushMessage: aSender value.
] ].

]
