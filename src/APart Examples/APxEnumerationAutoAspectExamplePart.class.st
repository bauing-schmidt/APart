"
APxEnumerationAutoAspectExamplePart demonstriert:
- Definition eines APEnumerationValuePart als Basis für eine ComboBox
- Zugriff auf den ausgewählten Wert
- Automatische Definition der Redirected Aspects
"
Class {
	#name : #APxEnumerationAutoAspectExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'resolverMode',
		'resolverModeEnabled'
	],
	#category : #'APart Examples-EnumerationAutoAspect'
}

{ #category : #private }
APxEnumerationAutoAspectExamplePart class >> resolverModeEnumeration [

	| enum |
	enum := APEnumeration named: #resolverMode.
	enum textFromKeyBlock: [:k | (self aPartTranslateDynamic: (k prefixCamelCased: #lb))].
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
APxEnumerationAutoAspectExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #resolverModeEnabled;
		createAspectNamed: #resolverMode;
		createAspectNamed: #resolverModeText
			redirectTo: #(#resolverMode #valueText);
		yourself
	"createAspectNamed: #resolverModesList
			redirectTo: #(#resolverMode #enumerationTextList);"
]

{ #category : #'initialize-release' }
APxEnumerationAutoAspectExamplePart >> initializeActions [

	| isResolverModeEnabled |
	isResolverModeEnabled := APCondition on: [resolverModeEnabled]
				ifNot: #ResolverModeDisabled.
	partInterface description
		createAction: #clearResolverMode
		do: [resolverMode value: nil]
		if: isResolverModeEnabled.
	partInterface description
		createAction: #resolve
		do: [resolverMode value: nil]
		if: (APCondition on: [resolverMode notNil] ifNot: #NoResolverMode)
				& isResolverModeEnabled
]

{ #category : #'initialize-release' }
APxEnumerationAutoAspectExamplePart >> initializeValues [

	resolverMode := APEnumerationValuePart onPart: self key: #resolverMode.
	resolverMode
		enumeration: self class resolverModeEnumeration;
		setStatefulConditionOn: 
				(APCondition on: [resolverModeEnabled] ifNot: #ResolverModeDisabled).
	resolverModeEnabled := true
]

{ #category : #accessing }
APxEnumerationAutoAspectExamplePart >> resolverMode [

	^resolverMode
]

{ #category : #accessing }
APxEnumerationAutoAspectExamplePart >> resolverMode: anObject [

	resolverMode := anObject
]

{ #category : #accessing }
APxEnumerationAutoAspectExamplePart >> resolverModeEnabled [

	^resolverModeEnabled
]

{ #category : #accessing }
APxEnumerationAutoAspectExamplePart >> resolverModeEnabled: aBoolean [

	resolverModeEnabled := aBoolean.
	self changedAspectValue: #resolverModeEnabled
]
