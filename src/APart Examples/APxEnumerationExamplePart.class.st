"
APxEnumerationExamplePart demonstriert:
- Definition eines APEnumerationValuePart 
- Verwendung der Enumeration als Basis für RadioButtons
"
Class {
	#name : #APxEnumerationExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'resolverMode',
		'resolverModeEnabled'
	],
	#category : #'APart Examples-EnumerationExample'
}

{ #category : #private }
APxEnumerationExamplePart class >> resolverModeEnumeration [

	| enum |
	enum := APEnumeration named: #resolverMode.
	enum textFromKeyBlock: [:k | self aPartTranslateDynamic: (k prefixCamelCased: #lb)].
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
APxEnumerationExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #resolverModeEnabled;
		createAspectNamed: #resolverMode redirectTo: #(#resolverMode #value);
		createAspectNamed: #resolverModeText
			redirectTo: #(#resolverMode #valueText);
		createAspectNamed: #resolverModesList
			redirectTo: #(#resolverMode #enumerationTextList);
		yourself
]

{ #category : #'initialize-release' }
APxEnumerationExamplePart >> initializeActions [

	| resolverModeEnabledCondition |
	resolverModeEnabledCondition := APCondition on: [resolverModeEnabled]
				ifNot: #ResolverModeDisabled.
	partInterface description
		createAction: #clearResolverMode
		do: [resolverMode value: nil]
		if: resolverModeEnabledCondition.
	partInterface description
		createAction: #selectByList
		do: 
			[(APConfirmationEnumValue onPart: self key: #resolverModeChoice)
				genericEnumeration: resolverMode enumeration;
				title: #ResolverModeAuswahl;
				message: #ResolverModeAuswahl;
				trigger: #confirmChoice
					withPartDo: [:promptPart | resolverMode value: promptPart value];
				trigger: #cancelChoice withPartDo: [:promptPart | resolverMode value: nil];
				openClientPrompt]
		if: (APCondition on: [resolverMode value isNil] ifNot: #ResolverModeSet)
				& resolverModeEnabledCondition value
]

{ #category : #'initialize-release' }
APxEnumerationExamplePart >> initializeValues [

	resolverMode := APEnumerationValuePart onPart: self key: #resolverMode.
	resolverMode enumeration: self class resolverModeEnumeration.
	resolverMode setStatefulConditionOn: 
			(APCondition on: [resolverModeEnabled] ifNot: #ResolverModeDisabled).
	resolverModeEnabled := true
]

{ #category : #'initialize-release' }
APxEnumerationExamplePart >> parentMenuLabelForKey: aKey [

	^aKey = #testMenu ifTrue: [self aPartTranslateDeferred: 'Testing menu']
]

{ #category : #accessing }
APxEnumerationExamplePart >> resolverMode [

	^resolverMode
]

{ #category : #accessing }
APxEnumerationExamplePart >> resolverMode: anObject [

	resolverMode := anObject
]

{ #category : #accessing }
APxEnumerationExamplePart >> resolverModeEnabled [

	^resolverModeEnabled
]

{ #category : #accessing }
APxEnumerationExamplePart >> resolverModeEnabled: aBoolean [

	resolverModeEnabled := aBoolean.
	self changedAspectValue: #resolverModeEnabled
]
