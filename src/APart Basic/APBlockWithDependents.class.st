Class {
	#name : #APBlockWithDependents,
	#superclass : #APModelWithValue,
	#instVars : [
		'block',
		'arguments',
		'cached'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APBlockWithDependents class >> block: aBlock arguments: aCollection [
	^ self new block: aBlock arguments: aCollection
]

{ #category : #initialization }
APBlockWithDependents >> block: aBlock arguments: aCollection [

	block := aBlock.
	cached := nil.
	arguments := aCollection.
	1 to: arguments size do: [ :i | (arguments at: i) addDependent: self ]
]

{ #category : #initialization }
APBlockWithDependents >> evaluated [
	| numArgs realArguments |
	numArgs := block numArgs.
	0 = numArgs
		ifTrue: [ ^ block value ].
	1 = numArgs
		ifTrue: [ ^ block value: arguments first value ].
	2 = numArgs
		ifTrue: [ ^ block value: arguments first value value: arguments second value ].
		
	realArguments := (1 to: (arguments size min: numArgs)) collect: [ :index | (arguments at: index) value ].
	^ block valueWithArguments: realArguments
]

{ #category : #initialization }
APBlockWithDependents >> initialize [
	
	cached := nil
]

{ #category : #initialization }
APBlockWithDependents >> releaseRequisites [
	arguments ifNil: [ ^ self ].
	arguments do: [ :each | each removeDependent: self ]
]

{ #category : #initialization }
APBlockWithDependents >> reset [
	cached := nil.
	self changed: #value
]

{ #category : #initialization }
APBlockWithDependents >> update: aspect with: parameter from: sender [

	self reset
]

{ #category : #initialization }
APBlockWithDependents >> value [

	^ cached ifNil: [ cached := self evaluated ].
]

{ #category : #initialization }
APBlockWithDependents >> value: anObject [
	self shouldNotImplement
]
