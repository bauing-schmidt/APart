Class {
	#name : #APxStatusBarExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'stringField',
		'intField',
		'confirmString',
		'confirmNumber',
		'disableInput',
		'isValidNumberCond',
		'statusBar',
		'progressBar'
	],
	#category : #'APart Examples-StatusBar'
}

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> confirmNumber [
	
	"WARNING: this method does not return the plain accessor of the confirmNumber but 
	the conjunction with the isValidNumer condition result. If the condition is not fulfiled,
	the confirmNumber looks unchecked but the original state of the model stays unchenged"
	
	^ isValidNumberCond booleanValue & confirmNumber
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> confirmNumber: aBoolean [

	confirmNumber := aBoolean.
	self changedAspectValue: #confirmNumber
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> confirmString [

	^confirmString
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> confirmString: aBoolean [

	confirmString := aBoolean.
	self changedAspectValue: #confirmString.
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> disableInput [

	^disableInput
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> disableInput: aBoolean [

	disableInput := aBoolean.
	self changedAspectValue: #disableInput.
]

{ #category : #'initialize-release' }
APxStatusBarExamplePart >> initializeActions [

	| enablementInputEnabled |
	enablementInputEnabled := APCondition on: [disableInput not]
				ifNot: #InputIsDisabled.
	partInterface description
		createAction: #clearString
		do: [
			self statusBar: 'string cleared'. 
			self progressBar: self progressBar + 0.1. 
			
			self stringField: nil]
		if: (APCondition on: [stringField size > 0] ifNot: #StringFieldIsEmpty)
				& enablementInputEnabled
		helpText: #ClearField.
	partInterface description
		createAction: #clearNumber
		do: [self intField: nil]
		if: (APCondition
				on: [intField ifNotNil: [:int | int ~= 0] ifNil: [false]]
				ifNot: #NumberFieldIsEmpty) & enablementInputEnabled
		helpText: #ClearField.
	partInterface description
		createAction: #saveData
		do: 
			[(APConfirmationYesNo onPart: self)
				trigger: #confirmYes do: [self privateSaveData];
				title: #DatenSpeichern;
				message: #FrageDatenSpeichern;
				openClientPrompt]
		if: (APCondition on: [confirmString] ifNot: #NeedConfirmString)
				& (APCondition on: [self confirmNumber] ifNot: #NeedConfirmNumber)
]

{ #category : #'initialize-release' }
APxStatusBarExamplePart >> initializeValues [

	| conditionActive |
	confirmString := false.
	confirmNumber := false.
	disableInput := false.
	isValidNumberCond := APCondition on: [self isValidNumber: intField]
				ifNot: #NeedValueGreater9InNumberField.
	conditionActive := APCondition on: [disableInput not]
				ifNot: #InputIsDisabled.
	self atAll: #(#stringField #intField) putCondition: conditionActive.
	self at: #confirmString
		putCondition: (APCondition on: [stringField size >= 2]
				ifNot: #Need2LettersInStringField) & conditionActive.
				
	self at: #confirmNumber putCondition: isValidNumberCond & conditionActive.
	partInterface addDependencyFrom: #confirmNumber to: #(intField).
	
	self at: #intField validate: [:newVal | isValidNumberCond booleanValue].
	self at: #disableInput putCondition: APCondition true.
	
	self partInterface description createAspectNamed: #statusBar.
	self partInterface description createAspectNamed: #progressBar.
	
	statusBar := 'aMessage'.
	progressBar := 0.1.
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> intField [

	^intField
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> intField: aValue [

	intField := aValue.
	intField isNil ifTrue: [self confirmNumber: false].
	self changedAspectValue: #intField
]

{ #category : #private }
APxStatusBarExamplePart >> isValidNumber: aNumber [

	^ aNumber notNil and: [(APartPlatform current numberInputFrom: aNumber) > 9]
]

{ #category : #updating }
APxStatusBarExamplePart >> noticeInvalidValueForAspect: anAspectKey [

	anAspectKey = #intField ifTrue: [self intField: nil]
]

{ #category : #private }
APxStatusBarExamplePart >> privateSaveData [

	self
		stringField: nil;
		intField: nil.
	Transcript
		cr;
		show: self class name asString;
		show: ': Data saved successfully!';
		cr
]

{ #category : #accessing }
APxStatusBarExamplePart >> progressBar [
	^ progressBar
]

{ #category : #accessing }
APxStatusBarExamplePart >> progressBar: anObject [
	progressBar := anObject.
	self changedAspectValue: #progressBar.
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> statusBar [

	^ statusBar 
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> statusBar: aValue [

	statusBar := aValue.
	self changedAspectValue: #statusBar
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> stringField [

	^stringField
]

{ #category : #'apart aspects' }
APxStatusBarExamplePart >> stringField: aValue [

	stringField := aValue.
	stringField size = 0 ifTrue: [self confirmString: false].
	self changedAspectValue: #stringField.
]
