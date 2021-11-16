Class {
	#name : #APartCheckBoxPresenter,
	#superclass : #SpCheckBoxPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartCheckBoxPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #accessing }
APartCheckBoxPresenter >> enabled: aBooleanOrValuable [
	"Set if the button is enabled (clickable).
	This can either be a boolean or a block returning a boolean."

	enabled := aBooleanOrValuable
]

{ #category : #accessing }
APartCheckBoxPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [
		
	| aValueAdaptor |
	aValueAdaptor := aspectObject subAdaptor.

	(self rawValueHolderNamed: #state) whenChangedDo: [ :newValue :oldValue |
		"aValueAdaptor ignoreChangesWhile: [ "aValueAdaptor value: (newValue ifNil: [false])"]" ].
	
	aValueAdaptor addDependent: (APartUpdateConverter on: [:aspect | 
		self state: aValueAdaptor value]).
		
	"initial update"
	state := (aValueAdaptor value)
]
