Class {
	#name : #APartTestFormPart,
	#superclass : #APart,
	#instVars : [
		'firstName',
		'lastName',
		'result',
		'exceptions'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #'API testing' }
APartTestFormPart >> autoAspectDefinition [ 

	^ true
]

{ #category : #'initialize-release' }
APartTestFormPart >> conditionActive [
	"not meaningful, just for tests"
	<aPartActionCondition>

	^APCondition named: #conditionActive1 on: [true] ifNot: #Disabled
]

{ #category : #'initialize-release' }
APartTestFormPart >> conditionActive2 [
	"not meaningful, just for tests"
	<aPartActionCondition>

	^APCondition named: #conditionActive2 on: [true] ifNot: #Disabled
]

{ #category : #'initialize-release' }
APartTestFormPart >> defineAspects [

	partInterface description createAllAspectsNamed: #(#firstName #lastName)
]

{ #category : #'initialize-release' }
APartTestFormPart >> exceptions [

	^ exceptions
]

{ #category : #'initialize-release' }
APartTestFormPart >> firstName [

	^firstName
]

{ #category : #'initialize-release' }
APartTestFormPart >> firstName: anObject [

	firstName := anObject.
	self changedAspectValue: #firstName
]

{ #category : #accessing }
APartTestFormPart >> fullName: aString [

	| stringParts |
	stringParts := aString findTokens: ' '.
	firstName := stringParts first.
	lastName := stringParts second.
]

{ #category : #'initialize-release' }
APartTestFormPart >> hasChanges [

	^ firstName ~= 'InitialFirstName' or: [lastName ~= 'InitialLastName']
]

{ #category : #'initialize-release' }
APartTestFormPart >> initializeActions [

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
APartTestFormPart >> initializeValues [

	result := nil.
	firstName := 'InitialFirstName'.
	lastName := 'InitialLastName'.
]

{ #category : #'initialize-release' }
APartTestFormPart >> isPromptable [

	^true
]

{ #category : #'initialize-release' }
APartTestFormPart >> lastName [

	^lastName
]

{ #category : #'initialize-release' }
APartTestFormPart >> lastName: anObject [

	lastName := anObject.
	self changedAspectValue: #lastName
]

{ #category : #'initialize-release' }
APartTestFormPart >> logException: anException [

	(exceptions ifNil: [ exceptions := OrderedCollection new ]) add: anException class.
	super logException: anException. 
]

{ #category : #'initialize-release' }
APartTestFormPart >> result [

	^result
]
