"
APxMenuHierarchyFromEnumExamplePart demonstriert:
- Definition von Menüs aus APEnumerationValuePart-Objekten
- Deaktivieren einzelner Menü-Elemente
- Verschachtelung von Menüs
"
Class {
	#name : #APxMenuHierarchyFromEnumExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'actionText',
		'actionMenu',
		'peripheralMenu',
		'peripheralActionText'
	],
	#category : #'APart Examples-MenuHierarchyFromEnum'
}

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> actionMenu [

	^actionMenu
]

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> actionText [

	^actionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> actionText: aText [

	actionText := aText.
	self changedAspectValue: #actionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> autoAspectDefinition [ 

	^ true
]

{ #category : #'initialize-release' }
APxMenuHierarchyFromEnumExamplePart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(#actionText #peripheralActionText).
		
	partInterface
		createMenuForKey: #actionMenu;
		createMenuForKey: #peripheralMenu
]

{ #category : #'initialize-subParts' }
APxMenuHierarchyFromEnumExamplePart >> initializeActionMenuPart [

	| enum entryEnabledCondition |
	entryEnabledCondition :=
			[:text |
			APCondition
				on: [actionText isNil or: [(actionText indexOfSubCollection: text startingAt: 1) = 0]]
				ifNot: #notSelected].
	enum := APEnumeration named: #testMenuEnumeration.
	enum textFromKeyBlock: [:k | self aPartTranslateDynamic: (k prefixCamelCased: #lb)].
	enum actionFromKeyBlock: [:k | k prefixCamelCased: #menu].
	enum
		addEntry: ((APEnumEntry on: enum key: #actionAlice)
					setStatefulConditionOn: (entryEnabledCondition value: 'Alice'));
		addEntry: ((APEnumEntry on: enum key: #actionBob)
					setStatefulConditionOn: (entryEnabledCondition value: 'Bob'));
		addEntry: ((APEnumEntry on: enum key: #actionEve)
					setStatefulConditionOn: (entryEnabledCondition value: 'Eve'));
		yourself.
	actionMenu := APMenuFromEnumerationPart onPart: self key: #actionMenu.
	actionMenu enumeration: enum.
]

{ #category : #'initialize-release' }
APxMenuHierarchyFromEnumExamplePart >> initializeActions [

	partInterface description 
		createAction: #menuActionAlice
			do: [self actionText: 'Action Alice performed.'];
		createAction: #menuActionBob
			do: [self actionText: 'Action Bob performed.'];
		createAction: #menuActionEve
			do: [self actionText: 'Action Eve performed.'];
		createAction: #menuPeripheralActionMouse
			do: [self peripheralActionText: 'Action Mouse performed.'];
		createAction: #menuPeripheralActionKeyboard
			do: [self peripheralActionText: 'Action Keyboard performed.'];
		createAction: #menuPeripheralActionScreen
			do: [self peripheralActionText: 'Action Screen performed.'];
		createAction: #menuPeripheralActionHeadphone
			do: [self peripheralActionText: 'Action Headphone performed.'];
		createAction: #menuPeripheralActionEarphone
			do: [self peripheralActionText: 'Action Earphone performed.'];
		createAction: #menuPeripheralActionSpeaker
			do: [self peripheralActionText: 'Action Speaker performed.']
]

{ #category : #'initialize-subParts' }
APxMenuHierarchyFromEnumExamplePart >> initializePeripheralMenuPart [

	| enum entryIndicatedCondition |
	entryIndicatedCondition :=
			[:text |
			APCondition on: 
					[peripheralActionText notNil
						and: [(peripheralActionText indexOfSubCollection: text startingAt: 1) > 0]]
				ifNot: #notSelected].
	enum := APEnumeration named: #testPeripheralMenuEnumeration.
	enum textFromKeyBlock: [:k | self aPartTranslateDynamic: (k prefixCamelCased: #lb)].
	enum actionFromKeyBlock: [:k | k prefixCamelCased: #menuPeripheral].
	enum
		addEntry: ((APEnumEntry on: enum key: #actionMouse)
					indicationStatefulConditionOn: (entryIndicatedCondition value: 'Mouse');
					addTag: #inputDevice);
		addEntry: ((APEnumEntry on: enum key: #actionKeyboard)
					indicationStatefulConditionOn: (entryIndicatedCondition value: 'Keyboard');
					addTag: #inputDevice);
		addEntry: ((APEnumEntry on: enum key: #actionScreen)
					indicationStatefulConditionOn: (entryIndicatedCondition value: 'Screen'));
		addEntry: ((APEnumEntry on: enum key: #actionEarphone)
					indicationStatefulConditionOn: (entryIndicatedCondition value: 'Earphone');
					addTag: #playbackDevice);
		addEntry: ((APEnumEntry on: enum key: #actionHeadphone)
					indicationStatefulConditionOn: (entryIndicatedCondition value: 'Headphone');
					addTag: #playbackDevice);
		addEntry: ((APEnumEntry on: enum key: #actionSpeaker)
					indicationStatefulConditionOn: (entryIndicatedCondition value: 'Speaker');
					addTag: #playbackDevice);
		yourself.
	peripheralMenu := APMenuFromEnumerationPart onPart: self key: #peripheralMenu.
	peripheralMenu enumeration: enum.
	
	peripheralMenu description createAction: #menuPeripheralActionScreen redirectTo: #('..' menuPeripheralActionScreen).
	peripheralMenu description createAction: #menuPeripheralActionKeyboard redirectTo: #('..' menuPeripheralActionKeyboard)
]

{ #category : #'initialize-release' }
APxMenuHierarchyFromEnumExamplePart >> initializeValues [

	actionText := nil.
	peripheralActionText := nil.
	self initializeActionMenuPart.
	self initializePeripheralMenuPart
]

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> peripheralActionText [

	^peripheralActionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> peripheralActionText: aText [

	peripheralActionText := aText.
	self changedAspectValue: #peripheralActionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumExamplePart >> peripheralMenu [

	^peripheralMenu
]
