"
APxEnablementExamplePart demonstriert:
- Definition einfacher Werte
- Definition einfacher Funktionen als APAction
- Enablement von Widgets für einfache Werte sowie für Button-Widgets
- Öffnen eines einfachen Prompts vor der Durchführung einer Aktion
"
Class {
	#name : #APxEnablementExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'stringField',
		'intField',
		'confirmString',
		'confirmNumber',
		'disableInput',
		'isValidNumberCond'
	],
	#category : #'APart Examples-Enablement'
}

{ #category : #'apart aspects' }
APxEnablementExamplePart >> confirmNumber [
	
	"WARNING: this method does not return the plain accessor of the confirmNumber but 
	the conjunction with the isValidNumer condition result. If the condition is not fulfiled,
	the confirmNumber looks unchecked but the original state of the model stays unchenged"
	
	^ isValidNumberCond booleanValue & confirmNumber
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> confirmNumber: aBoolean [

	confirmNumber := aBoolean.
	self changedAspectValue: #confirmNumber
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> confirmString [

	^confirmString
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> confirmString: aBoolean [

	confirmString := aBoolean.
	self changedAspectValue: #confirmString.
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> disableInput [

	^disableInput
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> disableInput: aBoolean [

	disableInput := aBoolean.
	self changedAspectValue: #disableInput.
]

{ #category : #'initialize-release' }
APxEnablementExamplePart >> initializeActions [

	| enablementInputEnabled |
	enablementInputEnabled := APCondition on: [disableInput not]
				ifNot: #InputIsDisabled.
	partInterface description
		createAction: #clearString
		do: [self stringField: nil]
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
APxEnablementExamplePart >> initializeValues [

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
	self at: #disableInput putCondition: APCondition true
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> intField [

	^intField
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> intField: aValue [

	intField := aValue.
	intField isNil ifTrue: [self confirmNumber: false].
	self changedAspectValue: #intField
]

{ #category : #private }
APxEnablementExamplePart >> isValidNumber: aNumber [

	^ aNumber notNil and: [(APartPlatform current numberInputFrom: aNumber) > 9]
]

{ #category : #updating }
APxEnablementExamplePart >> noticeInvalidValueForAspect: anAspectKey [

	anAspectKey = #intField ifTrue: [self intField: nil]
]

{ #category : #private }
APxEnablementExamplePart >> privateSaveData [

	self
		stringField: nil;
		intField: nil.
	Transcript
		cr;
		show: self class name asString;
		show: ': Data saved successfully!';
		cr
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> stringField [

	^stringField
]

{ #category : #'apart aspects' }
APxEnablementExamplePart >> stringField: aValue [

	stringField := aValue.
	stringField size = 0 ifTrue: [self confirmString: false].
	self changedAspectValue: #stringField.
]
