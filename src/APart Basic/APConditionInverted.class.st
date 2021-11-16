"
APConditionInverted is not directly instantiated, but is sent over an existing condition #invertedIfNot:. This creates a condition that inverts the original logically without changing it itself.

--

DE:APConditionInverted wird nicht direkt instanziiert, sondern über eine bereits vorhandene Condition, der #invertedIfNot: gesendet wird. So entsteht eine Condition, die die ursprüngliche logisch invertiert, ohne sie selbst zu verändern.
"
Class {
	#name : #APConditionInverted,
	#superclass : #APCondition,
	#instVars : [
		'referredCondition'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #API }
APConditionInverted >> booleanValue [

	^referredCondition booleanValue not
]

{ #category : #API }
APConditionInverted >> computeReasonUsingCache: conditionCache [

	^conditionCache at: self
		ifAbsentPut: 
			[(referredCondition computeReasonUsingCache: conditionCache)
				ifNil: [reason]
				ifNotNil: [nil]]
]

{ #category : #'initialize-release' }
APConditionInverted >> initOn: aReferredCondition ifNot: aReason [

	referredCondition := aReferredCondition.
	reason := aReason
]
