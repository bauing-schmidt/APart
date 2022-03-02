"
APTriggerAction repräsentiert eine Aktion, die nicht direkt durch die Anwendung, sondern als Ergebnis einer Trigger-Bedingung aufgerufen wird. Typische Anwendungsfälle sind Wechsel der Selektion oder Verzweigungen nach dem Aufruf von Prompts. 

"
Class {
	#name : #APTriggerAction,
	#superclass : #APExecutable,
	#instVars : [
		'isRunInParentPart',
		'wantsScopeUpdate'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #'initialize-release' }
APTriggerAction >> initialize [

	super initialize.
	isRunInParentPart := false.
	wantsScopeUpdate := true.
]

{ #category : #API }
APTriggerAction >> isRunInParentPart [

	^isRunInParentPart
]

{ #category : #API }
APTriggerAction >> isTrigger [

	^true
]

{ #category : #'initialize-release' }
APTriggerAction >> runInParentPart [

	isRunInParentPart := true.
	argumentsTemplate := Array new: argumentsTemplate size + 1
]

{ #category : #accessing }
APTriggerAction >> updateConditionUsingCache: conditionCache [
]

{ #category : #accessing }
APTriggerAction >> updateOnFinalReason: reason [
]

{ #category : #API }
APTriggerAction >> wantsScopeUpdate [

	^wantsScopeUpdate == true
]

{ #category : #accessing }
APTriggerAction >> wantsScopeUpdate: anObject [

	wantsScopeUpdate := anObject
]
