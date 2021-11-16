"
APxMenuFromDynamicEnumExamplePart demonstriert:
- Definition von Menüs aus APEnumerationValuePart-Objekten
- Verarbeitung der Menüauswahl als Wertübergabe oder als ausgelöste Aktion
- Dynamische Veränderung der Menüs durch entsprechende Änderung der Enumeration
"
Class {
	#name : #APxMenuFromDynamicEnumExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'testActionText',
		'testMenuAction',
		'testMenuValue',
		'mirroredTestMenuValue',
		'enumValueList'
	],
	#category : #'APart Examples-DynamicEnum'
}

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> actionText [

	^testActionText
]

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> actionText: aText [

	testActionText := aText.
	self changedAspectValue: #actionText
]

{ #category : #'initialize-release' }
APxMenuFromDynamicEnumExamplePart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(#actionText #menuValue);
		createAspectNamed: #testValueFromMenu
			redirectTo: #(#menuValue #entryValueForKey);
		createAspectNamed: #enumValueList.
		
	partInterface
		createMenuForKey: #menuAction;
		createMenuForKey: #menuValue;
		createMenuForKey: #mirroredTestMenuValue
]

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> exampleMenuEnumerationForAction [

	| enum |
	enum := APEnumeration named: #ActionEnumeration.
	enum textFromKeyBlock: [:k | k asString].
	enum actionFromKeyBlock: [:k | k prefixCamelCased: #menu].
	enumValueList list do: 
			[:v |
			| entry |
			enum addEntry: (entry := APEnumEntry on: enum key: (#action , v) asSymbol).
			partInterface description actionAt: (enum actionForKey: entry key)
				ifAbsent: 
					[entry setStatefulConditionOn: APCondition false.
					entry statefulCondition updateCondition]].
	^enum
]

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> exampleMenuEnumerationForValue [

	| enum |
	enum := APEnumeration named: #ValueEnumeration.
	enum textFromKeyBlock: [:k | 'Item with key ' , k printString].
	enumValueList list do: 
			[:v |
			enum
				addEntry: ((APEnumEntry on: enum key: (#value , v) asSymbol)
						value: v;
						yourself)].
	^enum
]

{ #category : #'initialize-release' }
APxMenuFromDynamicEnumExamplePart >> initializeActions [

	partInterface description createAction: #menuActionAlice
		do: [self actionText: 'Action Alice performed.'].
	partInterface description createAction: #menuActionBob
		do: [self actionText: 'Action Bob performed.'].
	partInterface description createAction: #menuActionEve
		do: [self actionText: 'Action Eve performed.'].
	partInterface description createAction: #addEnum
		do: 
			[(APTextPrompt onPart: self)
				title: #Umbenennen;
				message: #EnterNewName;
				trigger: #continueOk
					withPartDo: [:promptPart | enumValueList list add: promptPart value];
				openClientPrompt].
	partInterface description
		createAction: #removeEnum
		do: [enumValueList list remove: enumValueList selection]
		if: (APCondition on: [enumValueList selection notNil] ifNot: #notSelected)
]

{ #category : #'initialize-release' }
APxMenuFromDynamicEnumExamplePart >> initializeValues [

	testActionText := nil.
	enumValueList := APartList onPart: self key: #enumValueList.
	enumValueList
		list: #('Alice' 'Bob' 'Eve') asOrderedCollectionWithDependants;
		trigger: #selectionChanged do: [self rootUpdate].
	testMenuAction := APMenuFromEnumerationPart onPart: self key: #menuAction.
	testMenuAction enumerationUpdateBlock: [self exampleMenuEnumerationForAction].
	testMenuValue := APMenuFromEnumerationPart onPart: self key: #menuValue.
	testMenuValue
		enumerationUpdateBlock: [self exampleMenuEnumerationForValue];
		trigger: #valueChanged
			do: [mirroredTestMenuValue value: testMenuValue value].
	mirroredTestMenuValue := APMenuFromEnumerationPart onPart: self
				key: #mirroredTestMenuValue.
	mirroredTestMenuValue
		enumerationUpdateBlock: [self exampleMenuEnumerationForValue]
]

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> menuAction [

	^testMenuAction
]

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> menuValue [

	^testMenuValue
]

{ #category : #accessing }
APxMenuFromDynamicEnumExamplePart >> mirroredTestMenuValue [

	^mirroredTestMenuValue
]
