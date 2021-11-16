"
APxEnumerationComboBoxExamplePart demonstrates:
- Definition of an APEnumerationValuePart as the basis for a ComboBox
- Access to the selected value
- Different access techniques to the values of the combobox:
	- Specification of redirections
	- Specification of aspect paths

--

DE:APxEnumerationComboBoxExamplePart demonstriert:
- Definition eines APEnumerationValuePart als Basis für eine ComboBox
- Zugriff auf den ausgewählten Wert
- Unterschiedliche Zugriffstechniken auf die Werte der Combobox:
	- Angabe von Redirections
	- Angabe von Aspektpfaden
"
Class {
	#name : #APxEnumerationComboBoxExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'resolverMode1',
		'resolverMode2',
		'resolverModeEnabled'
	],
	#category : #'APart Examples-EnumerationComboBox'
}

{ #category : #private }
APxEnumerationComboBoxExamplePart class >> resolverModeEnumeration [

	| enum |
	enum := APEnumeration named: #resolverMode.
	enum textFromKeyBlock: [:k | k prefixCamelCased: (self aPartTranslateDynamic: #lb)].
	enum actionFromKeyBlock: [:k | k].
	enum
		addEntry: (APEnumEntry on: enum key: #modeResourceResolverOurPerson);
		addEntry: (APEnumEntry on: enum key: #modeResourceResolverExistingRole);
		addEntry: (APEnumEntry on: enum key: #modeResourceResolverCreateRole);
		addEntry: (APEnumEntry on: enum key: #modeResourceResolverExternalPerson);
		addEntry: (APEnumEntry on: enum key: #modeResourceResolverExistingUnknown);
		addEntry: (APEnumEntry on: enum key: #modeResourceResolverCreateUnknown);
		yourself.
	^enum
]

{ #category : #'initialize-release' }
APxEnumerationComboBoxExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #resolverModeEnabled;
		createAspectNamed: #resolverMode1 
			redirectTo: #(#resolverMode1 #value);
		createAspectNamed: #resolverMode1Text
			redirectTo: #(#resolverMode1 #valueText);
		createAspectNamed: #resolverMode1List
			redirectTo: #(#resolverMode1 #enumerationTextList);
		createAspectNamed: #resolverMode2
]

{ #category : #'initialize-release' }
APxEnumerationComboBoxExamplePart >> initializeActions [

	| isResolverModeEnabled |
	isResolverModeEnabled := APCondition on: [resolverModeEnabled]
				ifNot: #ResolverModeDisabled.
	partInterface description
		createAction: #clearResolverMode
		do: [resolverMode1 value: nil]
		if: isResolverModeEnabled.
	partInterface description
		createAction: #resolve
		do: [resolverMode1 value: nil]
		if: (APCondition on: [resolverMode1 notNil] ifNot: #NoResolverMode)
				& isResolverModeEnabled
]

{ #category : #'initialize-release' }
APxEnumerationComboBoxExamplePart >> initializeValues [

	resolverMode1 := APEnumerationValuePart onPart: self key: #resolverMode1.
	resolverMode1
		enumeration: self class resolverModeEnumeration;
		setStatefulConditionOn: (APCondition on: [resolverModeEnabled]
					ifNot: #ResolverModeDisabled).
	resolverMode2 := APEnumerationValuePart onPart: self key: #resolverMode2.
	resolverMode2
		enumeration: self class resolverModeEnumeration;
		setStatefulConditionOn: (APCondition on: [resolverModeEnabled]
					ifNot: #ResolverModeDisabled).
	resolverModeEnabled := true
]

{ #category : #accessing }
APxEnumerationComboBoxExamplePart >> resolverMode1 [

	^resolverMode1
]

{ #category : #accessing }
APxEnumerationComboBoxExamplePart >> resolverMode1Mirror [

	^resolverMode1 valueText
]

{ #category : #accessing }
APxEnumerationComboBoxExamplePart >> resolverMode2 [

	^resolverMode2
]

{ #category : #accessing }
APxEnumerationComboBoxExamplePart >> resolverModeEnabled [

	^resolverModeEnabled
]

{ #category : #accessing }
APxEnumerationComboBoxExamplePart >> resolverModeEnabled: aBoolean [

	resolverModeEnabled := aBoolean.
	self changedAspectValue: #resolverModeEnabled
]

{ #category : #API }
APxEnumerationComboBoxExamplePart >> reworkAspectAdaptor: anAspectAdaptor [
	"APEnumerationValuePart sends [self changed: #value] every time there is a value change, so if there are several sub-aspects that should react to changes, their adapters must be dependent on the base part."
	"DE:APEnumerationValuePart versendet [self changed: #value] bei jeder Wertänderung. Sofern mehrere Sub-Aspekte davon bei Änderungen reagieren sollen, müssen deren Adaptoren dependents des Basis-Parts sein."

	anAspectAdaptor subject == resolverMode2
		ifTrue: [resolverMode2 addDependent: anAspectAdaptor].
	^super reworkAspectAdaptor: anAspectAdaptor
]
