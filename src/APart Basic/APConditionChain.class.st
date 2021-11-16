"
APConditionChain serves as a collective container for all linked APConditions. Only when #asFinalCondition is called, the APConditionFinal resulting from the AND operation is constructed

--

DE:APConditionChain dient als Sammelcontainer für alle per & verknüpften APConditions. Erst beim Aufruf #asFinalCondition wird die aus der AND-Verknüpfung resultierende APConditionFinal konstruiert.
"
Class {
	#name : #APConditionChain,
	#superclass : #APCondition,
	#instVars : [
		'chain'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APConditionChain class >> create [

	^ self new
]

{ #category : #API }
APConditionChain >> & otherCondition [

	chain add: otherCondition
]

{ #category : #API }
APConditionChain >> add: aCondition [

	chain add: aCondition
]

{ #category : #API }
APConditionChain >> asFinalCondition [

	chain
		do: [:eachCondition | eachCondition computeReason ifNotNil: [:r | ^APConditionFinal on: r]].
	^APConditionFinal on: nil
]

{ #category : #API }
APConditionChain >> asFinalConditionUsingCache: conditionCache [

	chain do: 
			[:eachCondition |
			(eachCondition computeReasonUsingCache: conditionCache)
				ifNotNil: [:r | ^APConditionFinal on: r]].
	^APConditionFinal on: nil
]

{ #category : #API }
APConditionChain >> booleanValue [

	chain isEmpty ifTrue: [^true].
	chain do: [:eachCondition | eachCondition booleanValue ifFalse: [^false]].
	^true
]

{ #category : #API }
APConditionChain >> computeReason [

	chain isEmpty ifTrue: [^nil].
	chain do: [:e | e computeReason ifNotNil: [:r | ^r]].
	^nil
]

{ #category : #API }
APConditionChain >> computeReasonUsingCache: conditionCache [

	^conditionCache at: self
		ifAbsentPut: 
			[(chain detect: [:e | (e computeReasonUsingCache: conditionCache) notNil]
				ifNone: [nil]) ifNotNil: [:v | v computeReasonUsingCache: conditionCache]]
]

{ #category : #'initialize-release' }
APConditionChain >> initialize [

	chain := OrderedCollection new
]

{ #category : #testing }
APConditionChain >> isConditionChain [

	^ true
]
