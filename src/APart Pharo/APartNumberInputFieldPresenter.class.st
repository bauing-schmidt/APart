Class {
	#name : #APartNumberInputFieldPresenter,
	#superclass : #SpNumberInputFieldPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartNumberInputFieldPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #accessing }
APartNumberInputFieldPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	aValueAdaptor := aspectObject subAdaptor.

	(self rawValueHolderNamed: #text) whenChangedDo: [ :newValue :oldValue |
		"aValueAdaptor ignoreChangesWhile: ["aValueAdaptor value: ((newValue isNil or: [ newValue = '' ]) ifTrue: [nil] ifFalse: [ newValue asNumber])"]" ].
	
	aValueAdaptor addDependent: self.
	
	"initial update"
	(self rawValueHolderNamed: #text) value: (aValueAdaptor value)

	

]

{ #category : #accessing }
APartNumberInputFieldPresenter >> update: anAspectSymbol with: aParameter from: aSender [

	anAspectSymbol == #value ifTrue: [ 
		(self rawValueHolderNamed: #text) value: (aSender value ifNil: ['']) asString].

]
