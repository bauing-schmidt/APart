"
APxEnablementPragmasExamplePart demonstrates:
- Content same functionality as the superclass
- Definition of actions, conditions and aspects by pragmas

--

DE:APxEnablementPragmasExamplePart demonstriert:
- Inhaltlich dieselbe Funktionalität wie die Superklasse
- Definition der Aktionen, Conditions und Aspekte per Pragmas
"
Class {
	#name : #APxEnablementPragmasExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'stringField',
		'intField',
		'confirmString',
		'confirmNumber',
		'disableInput'
	],
	#category : #'APart Examples-EnablementPragma'
}

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> clearNumber [
	<aPartActionIf: #clearNumberCondition help: #ClearField>

	self intField: nil
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> clearNumberCondition [
	<aPartActionCondition>

	^(APCondition on: [intField ifNotNil: [:int | int ~= 0] ifNil: [false]]
		ifNot: #NumberFieldIsEmpty) & self enablementInputEnabled
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> clearString [
	<aPartActionIf: #clearStringCondition help: #ClearField>

	self stringField: nil
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> clearStringCondition [
	<aPartActionCondition>

	^(APCondition on: [stringField size > 0] ifNot: #StringFieldIsEmpty)
		& self enablementInputEnabled
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> conditionActive [
	<aPartActionCondition>

	^APCondition on: [disableInput not] ifNot: #InputIsDisabled
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> confirmNumber [
	<aPartAspectEnabled: #confirmNumberEnablement>

	^confirmNumber
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> confirmNumber: aBoolean [

	confirmNumber := aBoolean.
	self changedAspectValue: #confirmNumber
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> confirmNumberEnablement [
	<aPartActionCondition>

	^(APCondition on: [intField notNil and: [(APartPlatform current numberInputFrom: intField) > 9]]
		ifNot: #Need2DigitsInNumberField) & self conditionActive
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> confirmString [
	<aPartAspectEnabled: #confirmStringEnablement>

	^confirmString
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> confirmString: aBoolean [

	confirmString := aBoolean.
	self changedAspectValue: #confirmString.
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> confirmStringEnablement [
	<aPartActionCondition>

	^(APCondition on: [stringField size >= 2] ifNot: #Need2LettersInStringField)
		& self conditionActive
]

{ #category : #'initialize-release' }
APxEnablementPragmasExamplePart >> defineAspectsByPragma [
	"Alle mit Pragmas markierten Details werden hier installiert."
	"#(#aPartAction #aPartActionIf:help: #aPartAspect  #aPartNamedCondition)"
	
	super defineAspectsByPragma.

	(Pragma allNamed: #aPartNamedConditions in: self class)
		do: [:pragma | self addNamedConditions: (self perform: pragma selector)].
	(Pragma allNamed: #aPartAspectDefinition in: self class)
		do: [:pragma | self perform: pragma selector].
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> disableInput [
	<aPartAspectEnabled: #true>

	^disableInput
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> disableInput: aBoolean [

	disableInput := aBoolean.
	self changedAspectValue: #disableInput.
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> enablementInputEnabled [
	<aPartActionCondition>

	^APCondition on: [disableInput not] ifNot: #InputIsDisabled
]

{ #category : #'initialize-release' }
APxEnablementPragmasExamplePart >> initializeValues [
	"Es bleibt die Vorbelegung der instVars."

	confirmString := false.
	confirmNumber := false.
	disableInput := false
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> intField [
	<aPartAspectEnabled: #conditionActive>

	^intField
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> intField: aValue [

	intField := aValue.
	intField isNil ifTrue: [confirmNumber := false].
	self changedAspectValue: #intField
]

{ #category : #private }
APxEnablementPragmasExamplePart >> privateSaveData [

	self
		stringField: nil;
		intField: nil.
	Transcript
		cr;
		show: self class name asString;
		show: ': Data saved successfully!';
		cr
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> saveData [
	<aPartActionIf: #saveDataCondition help: nil>

	(APConfirmationYesNo onPart: self)
		trigger: #confirmYes do: [self privateSaveData];
		title: #DatenSpeichern;
		message: #FrageDatenSpeichern;
		openClientPrompt
]

{ #category : #'apart actions' }
APxEnablementPragmasExamplePart >> saveDataCondition [
	<aPartActionCondition>

	^(APCondition on: [confirmString] ifNot: #NeedConfirmString)
		& (APCondition on: [confirmNumber] ifNot: #NeedConfirmNumber)
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> stringField [
	<aPartAspectEnabled: #conditionActive>

	^stringField
]

{ #category : #'apart aspects' }
APxEnablementPragmasExamplePart >> stringField: aValue [

	stringField := aValue.
	stringField size = 0 ifTrue: [confirmString := false].
	self changedAspectValue: #stringField.
]
