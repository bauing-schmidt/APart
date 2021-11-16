"
APConfirmationYesNo dient zum Einholen von Ja-Nein-Entscheidungen
"
Class {
	#name : #APConfirmationYesNo,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'labelYes',
		'labelNo'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APConfirmationYesNo >> defaultPromptSelector [

	^#confirmYesNo:
]

{ #category : #accessing }
APConfirmationYesNo >> labelNo [

	^labelNo ifNil: [ ^ self aPartTranslateDeferred: 'No' ]
]

{ #category : #accessing }
APConfirmationYesNo >> labelNo: anObject [

	labelNo := anObject
]

{ #category : #accessing }
APConfirmationYesNo >> labelYes [

	^labelYes ifNil: [ self aPartTranslateDeferred: 'Yes'. ]
]

{ #category : #accessing }
APConfirmationYesNo >> labelYes: anObject [

	labelYes := anObject
]
