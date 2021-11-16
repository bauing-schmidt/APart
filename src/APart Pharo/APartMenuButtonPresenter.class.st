"
I am a copy of class APartButtonPresenter. This comment is copied from there, and might not be entirely accurate

Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	aspectSymbol:		<Object>
	builder:		<Object>
	id:		<Object>
	ignoreUpdates:		<Object>
	model:		<Object>


    Implementation Points
"
Class {
	#name : #APartMenuButtonPresenter,
	#superclass : #SpMenuButtonPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartMenuButtonPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #accessing }
APartMenuButtonPresenter >> menuFor: aValueAdaptor [
 
	^ self subMenuForEnumerationValueAdaptor: aValueAdaptor
]

{ #category : #accessing }
APartMenuButtonPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [

	| valueAspect aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self setupMenuFor: aValueAdaptor.
	
	valueAspect := aValueAdaptor value partInterface description aspectFor: #value ifAbsent: [ nil ].

	valueAspect addDependent: (APartUpdateConverter on: [:aspect | 
		self label: valueAspect value.
	]).

	self label: (valueAspect value).
	
]

{ #category : #accessing }
APartMenuButtonPresenter >> setupMenuFor: aValueAdaptor [
	self menu: (self menuFor: aValueAdaptor)
]
