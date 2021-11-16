Class {
	#name : #APartRadioButtonPresenter,
	#superclass : #SpRadioButtonPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#instVars : [
		'lookupKey',
		'select'
	],
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartRadioButtonPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #accessing }
APartRadioButtonPresenter >> lookupKey [
	^ lookupKey
]

{ #category : #accessing }
APartRadioButtonPresenter >> lookupKey: anObject [
	lookupKey := anObject
]

{ #category : #accessing }
APartRadioButtonPresenter >> select [
	^ select
]

{ #category : #accessing }
APartRadioButtonPresenter >> select: anObject [
	select := anObject
]

{ #category : #accessing }
APartRadioButtonPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [
	
	| aValueAdaptor |
	aValueAdaptor := aspectObject subAdaptor.
		
	"initial update"
	state := aValueAdaptor value
		ifNotNil: [ :val | val = self select ]
		ifNil: [ false ].

	(self rawValueHolderNamed: #state) whenChangedDo: [ :newValue :oldValue |
		newValue ifTrue: [ 
		aValueAdaptor value: self select ]
	].
	
	aValueAdaptor addDependent: (APartUpdateConverter on: [:aspect | 
		self state: (self select = aValueAdaptor value)]).


]
