Class {
	#name : #APartTestFormPartWithArgumentAction,
	#superclass : #APartTestFormPart,
	#instVars : [
		'actionMenu'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #'initialize-release' }
APartTestFormPartWithArgumentAction >> initializeActions [

	super initializeActions.
						
	"actions as support of tests"
	partInterface description
		createAction: #actionWithArgument
		withArgumentDo: [ :arg | arg at: 1 put: 2 ]
		if: (APCondition on: [firstName size > 0] ifNot: #FieldIsEmpty)
		helpText: nil

		
]
