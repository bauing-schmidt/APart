Class {
	#name : #APConditionTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APConditionTest >> testAnd [

	| condition |
	
	condition := APCondition false & APCondition false.	
	self deny: condition booleanValue. 
	
	condition := APCondition true & APCondition false.	
	self deny: condition booleanValue. 
	
	condition := APCondition false & APCondition true.	
	self deny: condition booleanValue. 
	
	condition := APCondition true & APCondition true.	
	self assert: condition booleanValue. 
	
]

{ #category : #tests }
APConditionTest >> testCache [

	| cache value1 value2 condition1 condition2 chain |
	
	cache := IdentityDictionary new.
	
	value1 := false.
	value2 := true.
	condition1 := APCondition on: [ value1 ] ifNot: #Condition1Reason.
	condition2 := APCondition on: [ value2 ] ifNot: #Condition2Reason.
	chain := condition1 & condition2.
	
	self assert: (chain computeReasonUsingCache: cache) equals: #Condition1Reason.

	value1 := true.
	value2 := false.
	"the result is logically wrong because it is taken from the cache"
	self assert: (chain computeReasonUsingCache: cache) equals: #Condition1Reason.

	"clear cache"
	cache := IdentityDictionary new.
	self assert: (chain computeReasonUsingCache: cache) equals: #Condition2Reason.

]

{ #category : #tests }
APConditionTest >> testChain [
	"test if & is doing a lazy evaluation"
	
	self deny: ((APCondition on: [ false ] ifNot: #aReason) & (APCondition on: [ false ] ifNot: #aReason)) booleanValue.
	self deny: ((APCondition on: [ false ] ifNot: #aReason) & (APCondition on: [ true ] ifNot: #aReason)) booleanValue.
	self deny: ((APCondition on: [ true ] ifNot: #aReason) & (APCondition on: [ false ] ifNot: #aReason)) booleanValue.
	self assert: ((APCondition on: [ true ] ifNot: #aReason) & (APCondition on: [ true ] ifNot: #aReason)) booleanValue.
	
]

{ #category : #tests }
APConditionTest >> testFalse [

	| condition |
	
	condition := APCondition false.
	
	self deny: condition booleanValue 
	
]

{ #category : #tests }
APConditionTest >> testFinal [

	| condition final value |
	
	value := 1.
	condition := APCondition on: [ value > 10 ] ifNot: #ValueTooSmall.
	final := condition asFinalCondition.
	self deny: final booleanValue.
	self assert: final reason equals: #ValueTooSmall.
	
	value := 11.	

	"the final condition is unchanged although the condition was changed"
	self deny: final booleanValue.
	self assert: final reason equals: #ValueTooSmall.

]

{ #category : #tests }
APConditionTest >> testFinalForChain [

	| condition final value |
	
	value := 1.
	condition := (APCondition on: [ value > 10 ] ifNot: #ValueTooSmall) & APCondition true.
	
	final := condition asFinalCondition.
	self deny: final booleanValue.
	self assert: final reason equals: #ValueTooSmall.
	
	value := 11.	

	"the final condition is unchanged although the condition was changed"
	self deny: final booleanValue.
	self assert: final reason equals: #ValueTooSmall.

]

{ #category : #tests }
APConditionTest >> testInverted [

	| condition value inverted|
	
	value := 1.
	condition := APCondition on: [ value > 10 ] ifNot: #ValueTooSmall.
	inverted := condition invertedIfNot: #ValueTooBig.
	
	self assert: inverted booleanValue.
	self assert: inverted computeReason equals: nil.
	
	value := 11.
	self deny: inverted booleanValue.
	self assert: inverted computeReason equals: #ValueTooBig.

]

{ #category : #tests }
APConditionTest >> testInvertedWithCache [

	| cache value1 value2 condition1 condition2 chain inverted |
	
	cache := IdentityDictionary new.
	
	value1 := false.
	value2 := true.
	condition1 := APCondition on: [ value1 ] ifNot: #Condition1Reason.
	condition2 := APCondition on: [ value2 ] ifNot: #Condition2Reason.
	chain := condition1 & condition2.
	inverted := chain invertedIfNot: #ValueTooBig.
	
	self assert: (inverted computeReasonUsingCache: cache) equals: nil.
]

{ #category : #tests }
APConditionTest >> testLongChain [

	| condition |
	
	condition := APCondition true & APCondition true & APCondition true & APCondition true.
	self assert: condition booleanValue. 
	
	condition := APCondition false & APCondition true & APCondition true & APCondition true.
	self deny: condition booleanValue. 
	
	condition := APCondition true & APCondition true & APCondition true & APCondition false.
	self deny: condition booleanValue. 
	
]

{ #category : #tests }
APConditionTest >> testNamed [

	| condition aString |
	
	aString := 'some condition'.
	
	condition := APCondition named: aString.
	self assert: condition name equals: aString.
	
	condition := APCondition named: aString on: [ true ] ifNot: #ValueTooSmall.
	self assert: condition name equals: aString.

]

{ #category : #tests }
APConditionTest >> testOnIfNot [

	| condition value |
	
	value := 1.
	condition := APCondition on: [ value > 10 ] ifNot: #ValueTooSmall.
	self deny: condition booleanValue.
	self assert: condition computeReason equals: #ValueTooSmall.
	
	value := 11.	
	condition := APCondition on: [ value > 10 ] ifNot: #ValueTooSmall.
	self assert: condition booleanValue.
	self assert: condition computeReason isNil.

	self should: [
		condition := APCondition on: [ value > 10 ] ifNot: nil.
	] raise: APNilReasonError 
]

{ #category : #tests }
APConditionTest >> testPrinting [ 
	"just a smoke test"

	| condition |
	
	condition := APCondition named: 'aName' on: [ true ] ifNot: #ValueTooSmall.
	self assert: (condition printString includesSubstring: 'aName')

]

{ #category : #tests }
APConditionTest >> testReasonsChain [

	| value1 value2 condition1 condition2 chain |
	
	value1 := false.
	value2 := true.
	condition1 := APCondition on: [ value1 ] ifNot: #Condition1Reason.
	condition2 := APCondition on: [ value2 ] ifNot: #Condition2Reason.
	chain := condition1 & condition2.
	
	self assert: chain computeReason equals: #Condition1Reason.

	value1 := true.
	value2 := false.
	self assert: chain computeReason equals: #Condition2Reason.
	
	value2 := true.
	self assert: chain computeReason equals: nil.
	

]

{ #category : #tests }
APConditionTest >> testSetNameIfUndefined [

	| condition aString1 aString2 |
	
	aString1 := 'some condition'.
	aString2 := 'other condition'.
	
	condition := APCondition on: [ true ] ifNot: #aReason.
	
	condition setNameIfUndefined: aString1.
	self assert: condition name equals: aString1.
	
	condition setNameIfUndefined: aString2.
	self assert: condition name equals: aString1.
		
]

{ #category : #tests }
APConditionTest >> testTrue [

	| condition |
	
	condition := APCondition true.
	
	self assert: condition booleanValue
	
]
