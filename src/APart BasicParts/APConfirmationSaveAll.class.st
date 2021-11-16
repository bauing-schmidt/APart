Class {
	#name : #APConfirmationSaveAll,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'labelSave',
		'labelSaveAll',
		'labelNotSave',
		'labelNotSaveAll',
		'labelCancel',
		'value',
		'report'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APConfirmationSaveAll >> defaultPromptSelector [

	^#confirmSaveAll:
]

{ #category : #accessing }
APConfirmationSaveAll >> labelCancel [

	^ labelCancel ifNil: [ self aPartTranslateDeferred: 'Cancel'. ]
]

{ #category : #accessing }
APConfirmationSaveAll >> labelCancel: anObject [

	labelCancel := anObject
]

{ #category : #accessing }
APConfirmationSaveAll >> labelNotSave [

	^ labelNotSave ifNil: [ self aPartTranslateDeferred: 'Do not save'. ]
]

{ #category : #accessing }
APConfirmationSaveAll >> labelNotSave: anObject [

	labelNotSave := anObject
]

{ #category : #accessing }
APConfirmationSaveAll >> labelNotSaveAll [

	^ labelNotSaveAll ifNil: [ self aPartTranslateDeferred: 'Save none'. ]
]

{ #category : #accessing }
APConfirmationSaveAll >> labelNotSaveAll: anObject [

	labelNotSaveAll := anObject
]

{ #category : #accessing }
APConfirmationSaveAll >> labelSave [

	^ labelSave ifNil: [ self aPartTranslateDeferred: 'Save'. ]
]

{ #category : #accessing }
APConfirmationSaveAll >> labelSave: anObject [

	labelSave := anObject
]

{ #category : #accessing }
APConfirmationSaveAll >> labelSaveAll [

	^ labelSaveAll ifNil: [ self aPartTranslateDeferred: 'Save all'. ]
]

{ #category : #accessing }
APConfirmationSaveAll >> labelSaveAll: anObject [

	labelSaveAll := anObject
]

{ #category : #accessing }
APConfirmationSaveAll >> report [

	^ report ifNil: [ '' ]
]

{ #category : #accessing }
APConfirmationSaveAll >> report: anObject [

	report := anObject
]

{ #category : #accessing }
APConfirmationSaveAll >> value [

	^ value
]

{ #category : #accessing }
APConfirmationSaveAll >> value: anObject [

	value := anObject
]
