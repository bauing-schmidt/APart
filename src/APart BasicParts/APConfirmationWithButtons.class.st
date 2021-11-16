Class {
	#name : #APConfirmationWithButtons,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'labelsAndKeys',
		'value',
		'report'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APConfirmationWithButtons >> addButton: aSymbol label: aLabel [ 

	^ labelsAndKeys add: (aSymbol -> aLabel)
]

{ #category : #'initialize-release' }
APConfirmationWithButtons >> defaultPromptSelector [

	^#confirmWithButtons:
]

{ #category : #accessing }
APConfirmationWithButtons >> initialize [ 

	super initialize.
	labelsAndKeys := OrderedDictionary new.
]

{ #category : #accessing }
APConfirmationWithButtons >> keys [ 

	^ labelsAndKeys keys
]

{ #category : #accessing }
APConfirmationWithButtons >> labels [ 

	^ labelsAndKeys values
]

{ #category : #accessing }
APConfirmationWithButtons >> labelsAndKeys [

	^ labelsAndKeys
]

{ #category : #accessing }
APConfirmationWithButtons >> labelsAndKeys: anObject [

	labelsAndKeys := anObject
]

{ #category : #accessing }
APConfirmationWithButtons >> report [

	^ report
]

{ #category : #accessing }
APConfirmationWithButtons >> report: anObject [

	report := anObject
]

{ #category : #accessing }
APConfirmationWithButtons >> value [

	^ value
]

{ #category : #accessing }
APConfirmationWithButtons >> value: anObject [

	value := anObject
]
