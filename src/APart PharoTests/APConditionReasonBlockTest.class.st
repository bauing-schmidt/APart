Class {
	#name : #APConditionReasonBlockTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APConditionReasonBlockTest >> testAnd [

	| condition value |
	
	value := 5.
	
	condition := APConditionReasonBlock on: [ 
		value < 1 
			ifTrue: [ #tooLow ]
			ifFalse: [ 
				value > 10 
					ifTrue: [ #tooHigh ]
					ifFalse: [ nil ] ]].
			
	self assert: (condition & APCondition false) computeReason equals: #ConditionAlwaysInactive.
	
]

{ #category : #tests }
APConditionReasonBlockTest >> testBasicCreation [ 

	| condition value |
	
	value := 5.
	
	condition := APConditionReasonBlock on: [ 
		value < 1 
			ifTrue: [ #tooLow ]
			ifFalse: [ 
				value > 10 
					ifTrue: [ #tooHigh ]
					ifFalse: [ nil ] ]].
			
	self assert: condition reasonBlock notNil.
	
	self assert: condition booleanValue.
	self assert: condition computeReason isNil.

	value := 0.
	self deny: condition booleanValue.
	self assert: condition computeReason equals: #tooLow.

	value := 11.
	self deny: condition booleanValue.
	self assert: condition computeReason equals: #tooHigh.

	"the same with cache"
	self assert: (condition computeReasonUsingCache: IdentityDictionary new) equals: #tooHigh.

	self assert: condition asFinalCondition reason equals: #tooHigh.
]

{ #category : #tests }
APConditionReasonBlockTest >> testBasicCreationWihArgument [

	| condition value argument |
	
	value := 5.
	argument := 2.
	
	condition := APConditionReasonBlock on: [ :arg |
		(value+arg) < 1 
			ifTrue: [ #tooLow ]
			ifFalse: [ 
				value > 10 
					ifTrue: [ #tooHigh ]
					ifFalse: [ nil ] ]] use: argument.
	
	self assert: condition booleanValue.
	self assert: condition computeReason isNil.

	value := -2.
	self deny: condition booleanValue.
	self assert: condition computeReason equals: #tooLow.

	value := 11.
	self deny: condition booleanValue.
	self assert: condition computeReason equals: #tooHigh.


]
