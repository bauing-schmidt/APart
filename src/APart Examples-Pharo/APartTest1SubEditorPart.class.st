Class {
	#name : #APartTest1SubEditorPart,
	#superclass : #APart,
	#instVars : [
		'firstName',
		'lastName',
		'result'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> defineAspects [

	partInterface description createAllAspectsNamed: #(#firstName #lastName)
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> firstName [

	^firstName
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> firstName: anObject [

	firstName := anObject.
	self changedAspectValue: #firstName
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> hasChanges [

	^ true
	"firstName ~= parentPart firstName or: [lastName ~= parentPart lastName]"
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> initializeActions [

	partInterface description
		createAction: #clearFirstName
			do: [self firstName: nil]
			if: (APCondition on: [firstName size > 0] ifNot: #FieldIsEmpty)
			helpText: #ClearField;
		createAction: #clearLastName
			do: [self lastName: nil ]
			if: (APCondition on: [lastName size > 0] ifNot: #FieldIsEmpty)
			helpText: #ClearField;
		createAction: #cancelEdit
			do: [self inform: 'close']
			if: APCondition true
			helpText: #unused;
		createAction: #saveData
			do: [self inform: 'save ', partInterface asString.
				partInterface requestForPartClose]
			if: (APCondition on: [firstName size > 0] ifNot: #MissingFirstName)
					& (APCondition on: [lastName size > 0] ifNot: #MissingLastName)
						& (APCondition on: [self hasChanges] ifNot: #NoChanges).

		
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> initializeValues [

	result := nil.
	firstName := 'Pavel'.
	lastName := 'Krivanek'.
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> isPromptable [

	^true
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> lastName [

	^lastName
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> lastName: anObject [

	lastName := anObject.
	self changedAspectValue: #lastName
]

{ #category : #'initialize-release' }
APartTest1SubEditorPart >> result [

	^result
]
