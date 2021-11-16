"
APxMenuHierarchyFromEnumPragmaExamplePart demonstriert:
- Definition von Aktionen aus Pragmas
- Definition von Menüs aus APEnumerationValuePart-Objekten
- Deaktivieren einzelner Menü-Elemente
- Verschachtelung von Menüs
"
Class {
	#name : #APxMenuHierarchyFromEnumPragmaExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'testActionText',
		'actionMenu',
		'peripheralMenu',
		'testPeripheralActionText'
	],
	#category : #'APart Examples-MenuHierarchyFromEnumPragma'
}

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> actionMenu [

	^actionMenu
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> actionText [

	^testActionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> actionText: aText [

	testActionText := aText.
	self changedAspectValue: #actionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> autoAspectDefinition [ 

	^ true
]

{ #category : #'initialize-release' }
APxMenuHierarchyFromEnumPragmaExamplePart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(#actionText #peripheralActionText).
		
	partInterface
		createMenuForKey: #actionMenu;
		createMenuForKey: #peripheralMenu
]

{ #category : #'initialize-subParts' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeActionMenuPart [

	| enum entryEnabledCondition |
	entryEnabledCondition :=
			[:text |
			APCondition
				on: [testActionText isNil or: [(testActionText indexOfSubCollection: text startingAt: 1) = 0]]
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
	actionMenu enumeration: enum
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuActionAlice [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuActionAlice
		do: [self actionText: 'Action Alice performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuActionBob [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuActionBob
		do: [self actionText: 'Action Bob performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuActionEve [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuActionEve
		do: [self actionText: 'Action Eve performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuPeripheralActionEarphone [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuPeripheralActionEarphone
		do: [self peripheralActionText: 'Action Earphone performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuPeripheralActionHeadphone [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuPeripheralActionHeadphone
		do: [self peripheralActionText: 'Action Headphone performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuPeripheralActionKeyboard [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuPeripheralActionKeyboard
		do: [self peripheralActionText: 'Action Keyboard performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuPeripheralActionMouse [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuPeripheralActionMouse
		do: [self peripheralActionText: 'Action Mouse performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuPeripheralActionScreen [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuPeripheralActionScreen
		do: [self peripheralActionText: 'Action Screen performed.']
]

{ #category : #'initialize-actions' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeMenuPeripheralActionSpeaker [
	<aPartDefineAction>

	partInterface description 
		createAction: #menuPeripheralActionSpeaker
		do: [self peripheralActionText: 'Action Speaker performed.']
]

{ #category : #'initialize-subParts' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializePeripheralMenuPart [

	| enum entryIndicatedCondition |
	entryIndicatedCondition :=
			[:text |
			APCondition on: 
					[testPeripheralActionText notNil
						and: [(testPeripheralActionText indexOfSubCollection: text startingAt: 1) > 0]]
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
	peripheralMenu enumeration: enum
]

{ #category : #'initialize-release' }
APxMenuHierarchyFromEnumPragmaExamplePart >> initializeValues [

	testActionText := nil.
	testPeripheralActionText := nil.
	self initializeActionMenuPart.
	self initializePeripheralMenuPart
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> peripheralActionText [

	^testPeripheralActionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> peripheralActionText: aText [

	testPeripheralActionText := aText.
	self changedAspectValue: #peripheralActionText
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExamplePart >> peripheralMenu [

	^peripheralMenu
]
