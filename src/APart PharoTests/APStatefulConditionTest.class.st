Class {
	#name : #APStatefulConditionTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #'as yet unclassified' }
APStatefulConditionTest >> testBasicCreation [ 

	| statefulCondition condition |
	
	condition := APCondition true.
	statefulCondition := condition asStatefulCondition.
	self assert: statefulCondition condition equals: condition.
	self deny: statefulCondition isChanged.
	self assert: statefulCondition booleanValue.	
	self assert: statefulCondition isActive.
	self assert: statefulCondition reason isNil
]

{ #category : #'as yet unclassified' }
APStatefulConditionTest >> testUpdateOnCondition [

	| statefulCondition condition1 condition2 |
	
	condition1 := APCondition true.
	condition2 := APCondition false.
	statefulCondition := APStatefulCondition on: condition1.
	statefulCondition updateOnCondition: condition2.
	
	self assert: statefulCondition isChanged.
	self deny: statefulCondition booleanValue.
	self assert: statefulCondition reason equals: #ConditionAlwaysInactive.
	
	
]
