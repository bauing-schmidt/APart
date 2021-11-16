"
An APCondition stands for a concrete Boolean expression, which is determined as a single condition.

--

DE:Eine APCondition steht für einen konkreten boolschen Ausdruck, der als einzelne Bedingung ermittelt wird.
"
Class {
	#name : #APCondition,
	#superclass : #APConditionBase,
	#instVars : [
		'booleanBlock'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APCondition class >> false [

	^APConditionFinal on: #ConditionAlwaysInactive
]

{ #category : #'instance creation' }
APCondition class >> named: aName on: anEnabledBlock ifNot: reason [

	^(self named: aName) initOn: anEnabledBlock ifNot: reason
]

{ #category : #'instance creation' }
APCondition class >> on: anEnabledBlock ifNot: reason [

	^self new initOn: anEnabledBlock ifNot: reason
]

{ #category : #'instance creation' }
APCondition class >> true [

	^APConditionFinal on: nil
]

{ #category : #API }
APCondition >> & next [

	^(APConditionChain create)
		add: self;
		add: next;
		yourself
]

{ #category : #API }
APCondition >> asFinalCondition [

	^APConditionFinal on: (self booleanValue ifFalse: [reason])
]

{ #category : #API }
APCondition >> booleanValue [

	^booleanBlock value
]

{ #category : #'initialize-release' }
APCondition >> initOn: aBooleanBlock ifNot: aReason [

	booleanBlock := aBooleanBlock.
	aReason == nil ifTrue: [ APNilReasonError signal].
	reason := aReason
]
