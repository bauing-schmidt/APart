"
APStatefulCondition combines the expression for an APCondition with an APConditionChange. Thus, it allows the stand-alone execution of #updateCondition and thus represents the result value of a complex expression for a condition, supplemented by the information as to whether this has changed since the last call to #updateCondition.

--

DE:APStatefulCondition kombiniert den Ausdruck für eine APCondition mit einem APConditionChange. Damit erlaubt es die eigenständige Ausführung von #updateCondition und repräsentiert somit den Ergebniswert eines komplexen Ausdrucks für eine Condition, ergänzt um die Information, ob sich dieser seit dem letzten Aufruf von #updateCondition geändert hat.
"
Class {
	#name : #APStatefulCondition,
	#superclass : #Object,
	#instVars : [
		'condition',
		'conditionChange'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APStatefulCondition class >> on: aConditionBlock [

	^self new initOn: aConditionBlock
]

{ #category : #API }
APStatefulCondition >> asStatefulCondition [

	^self
]

{ #category : #accessing }
APStatefulCondition >> booleanValue [

	^conditionChange booleanValue
]

{ #category : #accessing }
APStatefulCondition >> condition [

	^condition
]

{ #category : #accessing }
APStatefulCondition >> conditionChange [

	^conditionChange
]

{ #category : #accessing }
APStatefulCondition >> conditionChange: anObject [

	conditionChange := anObject
]

{ #category : #'initialize-release' }
APStatefulCondition >> initOn: aCondition [

	condition := aCondition.
	conditionChange := APConditionChange fromOld: nil
				toNew: (APConditionFinal on: nil)
]

{ #category : #testing }
APStatefulCondition >> isActive [

	^conditionChange booleanValue
]

{ #category : #testing }
APStatefulCondition >> isChanged [

	^conditionChange isChanged
]

{ #category : #printing }
APStatefulCondition >> printOn: s [

	super printOn: s.
	conditionChange notNil ifTrue: [conditionChange printReasonOn: s]
]

{ #category : #testing }
APStatefulCondition >> reason [

	^conditionChange reason
]

{ #category : #updating }
APStatefulCondition >> updateCondition [

	self updateOnCondition: condition
]

{ #category : #updating }
APStatefulCondition >> updateConditionUsingCache: conditionCache [

	self updateOnCondition: condition usingCache: conditionCache
]

{ #category : #updating }
APStatefulCondition >> updateOnCondition: newCondition [

	conditionChange := APConditionChange fromOld: conditionChange
				toNew: newCondition
]

{ #category : #updating }
APStatefulCondition >> updateOnCondition: newCondition usingCache: conditionCache [

	conditionChange := APConditionChange
				fromOld: conditionChange
				toNew: newCondition
				usingCache: conditionCache
]
