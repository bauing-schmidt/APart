Class {
	#name : #APartColorInputPresenter,
	#superclass : #APartTextInputFieldPresenter,
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartColorInputPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: aValueAdaptor notNil.
	
	(self rawValueHolderNamed: #text) whenChangedDo: [ :newValue :oldValue |
		self ignoreUpdates ifFalse: [ 
		newValue ifNotNil: [ 
			aValueAdaptor value: (self toColor: newValue) ]]].
	
	aValueAdaptor addDependent: self.
	
	"initial update"
	(self rawValueHolderNamed: #text) value: (self toString: (aValueAdaptor value))



	

	

]

{ #category : #accessing }
APartColorInputPresenter >> toColor: aStringOrNil [ 

	aStringOrNil ifNil: [ ^ nil ].
	(aStringOrNil trimBoth = '-') ifTrue: [ ^ nil ].
	aStringOrNil ifEmpty: [ ^ nil ].
	aStringOrNil size = 6 ifFalse: [ ^ nil ].
	
	^ Color fromHexString: aStringOrNil asString
]

{ #category : #accessing }
APartColorInputPresenter >> toString: aColorOrNil [ 

	aColorOrNil ifNil: [ ^ '-' ].
	
	^ aColorOrNil asHexString
]

{ #category : #accessing }
APartColorInputPresenter >> update: anAspectSymbol with: aParameter from: aSender [

	self ignoreUpdatesWhile: [ 
	anAspectSymbol == #value ifTrue: [ 
		(self rawValueHolderNamed: #text) value: (self toString: aSender value)] ].

]
