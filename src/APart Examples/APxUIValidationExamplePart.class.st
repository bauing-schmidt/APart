"
APxUIValidationExamplePart shows how a validation selector could be applied to input fields using APControllerWrapper
"
Class {
	#name : #APxUIValidationExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'hours',
		'stringInput'
	],
	#category : #'APart Examples-UIValidation'
}

{ #category : #'initialize-release' }
APxUIValidationExamplePart >> defineAspects [

	partInterface description createAllAspectsNamed: #(#hours #inputString)
]

{ #category : #API }
APxUIValidationExamplePart >> extraAnnouncements [

	^Array with: #controllerWrapperAnnouncement:announcer:
				-> APControllerWrapperAnnouncement
]

{ #category : #accessing }
APxUIValidationExamplePart >> hours [

	^hours
]

{ #category : #accessing }
APxUIValidationExamplePart >> hours: anObject [

	hours := anObject
]

{ #category : #'initialize-release' }
APxUIValidationExamplePart >> max20 [
	<aPartDefineAction>

	partInterface description createAction: #max20
		withArgumentDo: 
			[:controllerWrapper |
			controllerWrapper hasEditValue
				ifTrue: 
					[controllerWrapper editValue size <= 20
						ifTrue: [true]
						ifFalse: 
							[partInterface announce: ((controllerWrapper newAnnouncement)
										ringBell: true;
										flash: true;
										backspaceKey: true).
							false]]
				ifFalse: [true]]
]

{ #category : #accessing }
APxUIValidationExamplePart >> stringInput [

	^stringInput
]

{ #category : #accessing }
APxUIValidationExamplePart >> stringInput: anObject [

	stringInput := anObject
]

{ #category : #'initialize-release' }
APxUIValidationExamplePart >> validateHours [
	<aPartDefineAction>

	partInterface description createAction: #validateHours
		withArgumentDo: 
			[:controllerWrapper |
			| minutes |
			minutes := controllerWrapper editValue.
			(minutes isNil or: [minutes > (24 * 60)])
				ifTrue: 
					[self changedAspectValue: #hours.
					false]
				ifFalse: [true]]
]
