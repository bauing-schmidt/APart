"
APUnitTestPromptResult repräsentiert eine Zusammenstellung von Werten, die als Resultat des Aufrufs eines Prompts verwendbar sind. 
"
Class {
	#name : #APUnitTestPromptResult,
	#superclass : #Object,
	#instVars : [
		'promptKey',
		'isControlling',
		'value',
		'promptClosingTriggerKey'
	],
	#category : #'APart Basic-Prompt'
}

{ #category : #'instance creation' }
APUnitTestPromptResult class >> controllingFor: aPromptKey [

	^(self for: aPromptKey)
		isControlling: true;
		yourself
]

{ #category : #'instance creation' }
APUnitTestPromptResult class >> controllingFor: aPromptKey trigger: aTriggerKey [

	^(self controllingFor: aPromptKey)
		promptClosingTriggerKey: aTriggerKey;
		yourself
]

{ #category : #'instance creation' }
APUnitTestPromptResult class >> for: aPromptKey [

	^(self new)
		isControlling: false;
		promptKey: aPromptKey
]

{ #category : #'instance creation' }
APUnitTestPromptResult class >> for: aPromptKey whenClosedExecute: aTriggerKey [

	^(self for: aPromptKey)
		promptClosingTriggerKey: aTriggerKey;
		yourself
]

{ #category : #accessing }
APUnitTestPromptResult >> isControlling [

	^isControlling
]

{ #category : #accessing }
APUnitTestPromptResult >> isControlling: anObject [

	isControlling := anObject
]

{ #category : #printing }
APUnitTestPromptResult >> printOn: s [

	super printOn: s.
	promptKey notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: promptKey printString;
				nextPut: $)]
]

{ #category : #accessing }
APUnitTestPromptResult >> promptClosingTriggerKey [

	^promptClosingTriggerKey
]

{ #category : #accessing }
APUnitTestPromptResult >> promptClosingTriggerKey: aKey [

	promptClosingTriggerKey := aKey
]

{ #category : #accessing }
APUnitTestPromptResult >> promptKey [

	^promptKey
]

{ #category : #accessing }
APUnitTestPromptResult >> promptKey: anObject [

	promptKey := anObject
]

{ #category : #accessing }
APUnitTestPromptResult >> value [

	^value
]

{ #category : #accessing }
APUnitTestPromptResult >> value: anObject [

	value := anObject
]
