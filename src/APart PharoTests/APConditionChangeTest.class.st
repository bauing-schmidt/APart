Class {
	#name : #APConditionChangeTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APConditionChangeTest >> testBasicCreation [ 

	| conditionChange cache |

	self deny: APConditionChange create isChanged.
	
	conditionChange := APConditionChange from: (APCondition true asFinalCondition).
	self deny: conditionChange isChanged.

	"variant of the previous case"
	conditionChange := APConditionChange fromNew: (APCondition true asFinalCondition).
	self deny: conditionChange isChanged.
	
	conditionChange := APConditionChange fromOld: (APCondition true asFinalCondition) toNew: (APCondition false asFinalCondition).
	self assert: conditionChange isChanged.
	
	cache := IdentityDictionary new.
	conditionChange := APConditionChange fromOld: (APCondition true asFinalCondition) toNew: (APCondition false asFinalCondition) usingCache: cache.
	self assert: conditionChange isChanged.
]

{ #category : #tests }
APConditionChangeTest >> testOldReason [

	| conditionChange |
	conditionChange := APConditionChange fromOld: (APCondition false asFinalCondition) toNew: (APCondition true asFinalCondition).
	self assert: conditionChange oldReason equals: #ConditionAlwaysInactive
	

]

{ #category : #tests }
APConditionChangeTest >> testPrinting [

	| conditionChange |

	conditionChange := APConditionChange create.
	self assert: (conditionChange asString includesSubstring: '= ').
	self deny: (conditionChange asString includesSubstring: 'C ').	
		
	conditionChange := APConditionChange fromOld: (APCondition false asFinalCondition) toNew: (APCondition true asFinalCondition).
	self deny: (conditionChange asString includesSubstring: '= ').
	self assert: (conditionChange asString includesSubstring: 'C ').
]
