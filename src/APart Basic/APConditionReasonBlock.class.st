"
APConditionReasonBlock is a condition that directly determines the reason for the default instead of a boolean condition. In this way, the condition can return a variety of detailed reasons for its failure.

--

DE:APConditionReasonBlock ist eine Condition, per der anstelle einer boolschen Bedingung direkt der Grund für die Nichterfüllung ermittelt wird. Auf diesem Weg kann die Condition eine Vielzahl von detaillierten Gründen für ihr Scheitern zurückliefern.
"
Class {
	#name : #APConditionReasonBlock,
	#superclass : #APConditionBase,
	#instVars : [
		'reasonBlock',
		'blockArgument'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APConditionReasonBlock class >> on: aReasonBlock [

	^self on: aReasonBlock use: nil
]

{ #category : #'instance creation' }
APConditionReasonBlock class >> on: aReasonBlock use: aBlockArg [

	^self new initOn: aReasonBlock use: aBlockArg
]

{ #category : #API }
APConditionReasonBlock >> & next [

	^(APConditionChain create)
		add: self;
		add: next;
		yourself
]

{ #category : #API }
APConditionReasonBlock >> asFinalCondition [

	^APConditionFinal on: self reasonBlockValue
]

{ #category : #API }
APConditionReasonBlock >> booleanValue [

	^self reasonBlockValue isNil
]

{ #category : #API }
APConditionReasonBlock >> computeReason [

	^self reasonBlockValue
]

{ #category : #API }
APConditionReasonBlock >> computeReasonUsingCache: conditionCache [
	"For this class, the FinalCondition is cached, not the Boolean value"
	"DE:Für diese Klasse wird die FinalCondition im Cache gespeichert, nicht der boolsche Wert"

	^conditionCache at: self ifAbsentPut: [self asFinalCondition reason]
]

{ #category : #'initialize-release' }
APConditionReasonBlock >> initOn: aReasonBlock use: aBlockArg [

	reasonBlock := aReasonBlock.
	blockArgument := aBlockArg
]

{ #category : #accessing }
APConditionReasonBlock >> reasonBlock [

	^reasonBlock
]

{ #category : #private }
APConditionReasonBlock >> reasonBlockValue [

	^blockArgument
		ifNotNil: [reasonBlock value: blockArgument]
		ifNil: [reasonBlock value]
]
