Class {
	#name : #APartButtonPresenter,
	#superclass : #SpButtonPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartButtonPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #accessing }
APartButtonPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: partInterface [
	
	| aValueAdaptor | 
	aValueAdaptor := aspectObject ifNotNil: [ aspectObject subAdaptor ].

	self setAPartAction: (parentPresenter actionFor: anAspect).
	

]
