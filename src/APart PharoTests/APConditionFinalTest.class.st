Class {
	#name : #APConditionFinalTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APConditionFinalTest >> testAnd [
	"test if & is doing a lazy evaluation"
	
	| condition value finalCondition condition2 executed |
	
	value := true.
	executed := false.
	condition := APCondition on: [ value ] ifNot: #Condition1Reason.
	condition2 := APCondition on: [ executed := true. true ] ifNot: #Condition2Reason.
	finalCondition := condition asFinalCondition.
	self assert: (finalCondition & condition2) booleanValue equals: true.
	self assert: executed.
	
	value := false.
	executed := false.
	condition := APCondition on: [ value ] ifNot: #Condition1Reason.
	finalCondition := condition asFinalCondition.
	self assert: (finalCondition & condition2) booleanValue equals: false.
	self deny: executed.
]

{ #category : #tests }
APConditionFinalTest >> testBasicCreation [ 

	| condition value finalCondition |
	
	value := true.
	condition := APCondition on: [ value ] ifNot: #Condition1Reason.
	finalCondition := condition asFinalCondition.
	
	self assert: finalCondition booleanValue.
	self assert: finalCondition isActive.
	self assert: finalCondition reason isNil.
	self assert: finalCondition reasonForInactivity isNil.
	self assert: condition booleanValue.
	
	value := false.
	"the final condition will be not changed"
	self assert: finalCondition booleanValue.
	self assert: finalCondition reason isNil.
	self deny: condition booleanValue.

]
