Class {
	#name : #APartImagePresenter,
	#superclass : #SpImagePresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #specs }
APartImagePresenter class >> adapterName [ 

	^ #ImageAdapter
]

{ #category : #initialization }
APartImagePresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: aValueAdaptor notNil.
	
	(self rawValueHolderNamed: #image) whenChangedDo: [ :newValue :oldValue |
		self ignoreUpdates ifFalse: [ 
		newValue ifNotNil: [ aValueAdaptor value: newValue ]]].
	
	aValueAdaptor addDependent: self.
	
	"initial update"
	(self rawValueHolderNamed: #image) value: (aValueAdaptor value).
	
	



	

	

]

{ #category : #initialization }
APartImagePresenter >> update: anAspectSymbol with: aParameter from: aSender [

	self ignoreUpdatesWhile: [ 
	anAspectSymbol == #value ifTrue: [ 
		(self rawValueHolderNamed: #image) value: (aSender value ifNil: [''])] ].

]
