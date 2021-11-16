Class {
	#name : #APartProgressBarPresenter,
	#superclass : #SpProgressBarPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartProgressBarPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #initialization }
APartProgressBarPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: aPartentPresenter interface: toPart [

	| aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: aValueAdaptor notNil.
			
	aValueAdaptor addDependent: self.
	
	"initial update"
	self fixedAt: aValueAdaptor value



	

	

]

{ #category : #accessing }
APartProgressBarPresenter >> update: anAspectSymbol with: aParameter from: aSender [

	self ignoreUpdatesWhile: [ 
	anAspectSymbol == #value ifTrue: [ 
		self fixedAt: (aSender value ifNil: [0.0]) ]]
]
