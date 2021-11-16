"
DependencySubscription transforms update messages from the model update mechanism into concrete messages to a specific receiver.
"
Class {
	#name : #APDependencySubscription,
	#superclass : #Object,
	#instVars : [
		'aspect',
		'argumentsCount',
		'receiver',
		'selector',
		'suspended'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'as yet unclassified' }
APDependencySubscription class >> receiver: aReceiver aspect: anAspect selector: aSymbol [
	
	^ self new initializeReceiver: aReceiver aspect: anAspect selector: aSymbol
]

{ #category : #comparing }
APDependencySubscription >> = anObject [

	^ self class == anObject class
		and: [ receiver == anObject receiver
				and: [ aspect == anObject aspect and: [ selector == anObject selector ] ] ]
]

{ #category : #comparing }
APDependencySubscription >> aspect [
	^aspect
]

{ #category : #comparing }
APDependencySubscription >> hash [
	^ (receiver identityHash 
		bitXor: aspect identityHash)
		bitXor: selector identityHash
]

{ #category : #comparing }
APDependencySubscription >> initializeReceiver: aReceiver aspect: anAspect selector: aSymbol [
	receiver := aReceiver.
	aspect := anAspect.
	selector := aSymbol.
	argumentsCount := selector numArgs.
	argumentsCount > 2 ifTrue: [ self aPartError: #toManyArguments ]
]

{ #category : #comparing }
APDependencySubscription >> isFor: anObject aspect: anAspect [

	^receiver == anObject and: [aspect = anAspect]
]

{ #category : #comparing }
APDependencySubscription >> receiver [
	^receiver
]

{ #category : #comparing }
APDependencySubscription >> selector [
	^selector
]

{ #category : #comparing }
APDependencySubscription >> setReceiver: aReceiver aspect: anAspect selector: aSymbol [
	receiver := aReceiver.
	aspect := anAspect.
	selector := aSymbol.
	argumentsCount := selector numArgs.
	argumentsCount > 2 ifTrue: [ self aPartError: #toManyArguments ]
]

{ #category : #comparing }
APDependencySubscription >> update: anAspect with: parameters from: anObject [
	aspect == anAspect
		ifFalse: [ ^ self ].
	argumentsCount = 0
		ifTrue: [ ^ receiver perform: selector ].
	argumentsCount = 1
		ifTrue: [ ^ receiver perform: selector with: parameters ].
	argumentsCount = 2
		ifTrue: [ ^ receiver perform: selector with: parameters with: anObject ]
]
