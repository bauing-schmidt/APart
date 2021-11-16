"
APConditionChange represents the change of an APCondition.

--

DE:APConditionChange repräsentiert die Änderung einer APCondition.
"
Class {
	#name : #APConditionChange,
	#superclass : #APConditionFinal,
	#instVars : [
		'oldReason'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APConditionChange class >> create [

	^ self new 
]

{ #category : #'instance creation' }
APConditionChange class >> from: someFinalAPCondition [

	^self on: someFinalAPCondition reason
]

{ #category : #'instance creation' }
APConditionChange class >> fromNew: someFinalAPCondition [

	^self on: someFinalAPCondition reason
]

{ #category : #'instance creation' }
APConditionChange class >> fromOld: someOldCondition toNew: someFinalCondition [

	^(self on: someFinalCondition asFinalCondition reason)
		oldReason: (someOldCondition ifNotNil: [someOldCondition reason]);
		yourself
]

{ #category : #'instance creation' }
APConditionChange class >> fromOld: someOldCondition toNew: someFinalCondition usingCache: conditionCache [

	^(self on: (someFinalCondition asFinalConditionUsingCache: conditionCache) reason)
		oldReason: (someOldCondition ifNotNil: [someOldCondition reason]);
		yourself
]

{ #category : #testing }
APConditionChange >> isChanged [

	^oldReason ~= reason
]

{ #category : #accessing }
APConditionChange >> oldReason [

	^oldReason
]

{ #category : #accessing }
APConditionChange >> oldReason: anObject [

	oldReason := anObject
]

{ #category : #printing }
APConditionChange >> printOn: s [

	super printOn: s.
	self printReasonOn: s
]

{ #category : #printing }
APConditionChange >> printReasonOn: s [

	s
		nextPut: $(;
		nextPut: (self isChanged ifTrue: [$C] ifFalse: [$=]);
		space;
		nextPutAll: reason printString;
		nextPut: $)
]
