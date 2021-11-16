Class {
	#name : #APartTextPresenter,
	#superclass : #SpTextPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartTextPresenter >> defaultModel [
	
	^ValueHolder new contents: String new
]

{ #category : #accessing }
APartTextPresenter >> enabled: aBoolean [

	^ super enabled: aBoolean.
]

{ #category : #accessing }
APartTextPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: aValueAdaptor notNil.
	
	(self rawValueHolderNamed: #text) whenChangedDo: [ :newValue :oldValue |
		self ignoreUpdates ifFalse: [ 
		newValue ifNotNil: [ 
			aValueAdaptor value: (newValue asString ifEmpty: [ nil ]) ]]].
	
	aValueAdaptor addDependent: self.
	
	"initial update"
	(self rawValueHolderNamed: #text) value: (aValueAdaptor value)



	

	

]

{ #category : #accessing }
APartTextPresenter >> update: anAspectSymbol with: aParameter from: aSender [

	self ignoreUpdatesWhile: [ 
	anAspectSymbol == #value ifTrue: [ 
		(self rawValueHolderNamed: #text) value: (aSender value ifNil: [''])] ].

]
