Class {
	#name : #APUseCaseTest,
	#superclass : #TestCase,
	#instVars : [
		'part',
		'description',
		'actionPerformed'
	],
	#category : #'APart PharoTests'
}

{ #category : #initialization }
APUseCaseTest >> setUp [ 

	super setUp. 
	
	part := APartDescriptionTestPart createWithClientRegistry.
	description := part partInterface description.
	actionPerformed := false.

]

{ #category : #initialization }
APUseCaseTest >> testCreateAllImplementedActionsOnPart [
	
	| otherExecuted | 
	
	otherExecuted := false.
	
	APTestUseCase createAllImplementedActionsOnPart: part.
	
	self assert: (description hasActionNamed: #otherAction:).

	part execute: #someAction ifDisabled: [ self fail ].
	self assert: part state equals: #someActionExecuted.
	
	part execute: #otherAction: with: 42 ifDisabled: [ self fail ].
	self assert: part state equals: #(42). "list of arguments"
	
	
	
	
	

	
	
]
