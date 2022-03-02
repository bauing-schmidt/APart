"
A simple use case as tests support class. This use-case evaluates a given block which allows to create testable side-effects.
"
Class {
	#name : #APTestUseCase,
	#superclass : #APUseCase,
	#instVars : [
		'block',
		'otherBlock'
	],
	#category : #'APart PharoTests'
}

{ #category : #accessing }
APTestUseCase class >> implementedActionKeys [
	"Must be overwritten in every subclass"

	^#(someAction otherAction:)
]

{ #category : #'API Action' }
APTestUseCase >> beforePerformAction: anActionKey [

	actionKey := anActionKey
]

{ #category : #accessing }
APTestUseCase >> block [

	^ block
]

{ #category : #accessing }
APTestUseCase >> block: anObject [

	block := anObject
]

{ #category : #'API Action' }
APTestUseCase >> cloneForExecutionFrom: otherUC [

	super cloneForExecutionFrom: otherUC.
	part := otherUC part.
	block := otherUC block.
	otherBlock := otherUC otherBlock.
	
	
]

{ #category : #'API Action' }
APTestUseCase >> initOnPart: aPart actionKey: anActionKey [


	super initOnPart: aPart actionKey: anActionKey.

	otherBlock := [ :arg | ].
]

{ #category : #'API Action' }
APTestUseCase >> initialize [ 

	super initialize.
	otherBlock := [ :arg | ].
]

{ #category : #accessing }
APTestUseCase >> otherBlock [

	^ otherBlock
]

{ #category : #accessing }
APTestUseCase >> otherBlock: anObject [

	otherBlock := anObject
]

{ #category : #'API Action' }
APTestUseCase >> performUseCaseAction [

	actionKey = #someAction ifTrue: [
		block value.
		part ifNotNil: [ :aPart |
			aPart state: #someActionExecuted ].
	].


]

{ #category : #'API Action' }
APTestUseCase >> performUseCaseActionForArgs: args [

	actionKey = #otherAction: ifTrue: [
		otherBlock value: args.
		part ifNotNil: [ :aPart |
			aPart state: args ].
	].


	
]
