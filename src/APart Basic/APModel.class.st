Class {
	#name : #APModel,
	#superclass : #Object,
	#instVars : [
		'dependents',
		'suspended'
	],
	#category : #'APart Basic-Support'
}

{ #category : #dependencies }
APModel >> addDependent: anObject [
	
	self
		myDependents: (self myDependents asAPModelDependentsWith: anObject).
	^ anObject
]

{ #category : #dependencies }
APModel >> asAPModelDependentsWith: anObject [
	^ APModelDependentsCollection with: self with: anObject
]

{ #category : #updating }
APModel >> changed [

	self changed: nil
]

{ #category : #updating }
APModel >> changed: anAspect [ 

	self changed: anAspect with: nil
]

{ #category : #updating }
APModel >> changed: anAspectSymbol with: aParameter [
	suspended == true ifTrue: [ ^ self ].
	self
		ignoreChangesWhile:
			[ self myDependents update: anAspectSymbol with: aParameter from: self ]
]

{ #category : #accessing }
APModel >> ignoreChangesWhile: aBlock [
	| result |
	[ suspended := true.
	result := aBlock value ]
		ensure: [ suspended := false ].
	^ result
]

{ #category : #initialization }
APModel >> initialize [

	super initialize.
	suspended := false.
]

{ #category : #dependencies }
APModel >> myDependents [

	^ dependents
]

{ #category : #dependencies }
APModel >> myDependents: anObject [
	dependents := anObject
]

{ #category : #copying }
APModel >> postCopy [

	super postCopy.
	self breakDependents
]
