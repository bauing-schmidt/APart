"
APxMenuFromEnumExamplePart demonstriert:
- Definition von statischen Menüs aus APEnumerationValuePart-Objekten
- Verarbeitung der Menüauswahl als Wertübergabe oder als ausgelöste Aktion
"
Class {
	#name : #APxMenuFromEnumExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'actionText',
		'menuAction',
		'menuValue',
		'mirroredTestMenuValue'
	],
	#category : #'APart Examples-MenuFromEnum'
}

{ #category : #accessing }
APxMenuFromEnumExamplePart class >> exampleMenuEnumerationForAction [

	| enum values |
	values := #('Alice' 'Bob' 'Eve').
	enum := APEnumeration named: #ActionEnumeration.
	enum textFromKeyBlock: [:k | k asString].
	enum actionFromKeyBlock: [:k | k prefixCamelCased: #menu].
	values do: 
			[:v |
			enum
				addEntry: (APEnumEntry on: enum key: (#action , v) asSymbol)].
	^enum
]

{ #category : #accessing }
APxMenuFromEnumExamplePart class >> exampleMenuEnumerationForValue [

	| enum values |
	values := #('Alice' 'Bob' 'Eve').
	enum := APEnumeration named: #ValueEnumeration.
	enum textFromKeyBlock: [:k | 'Item with key ', k printString].
	values do: 
			[:v |
			enum
				addEntry: ((APEnumEntry on: enum key: (#value , v) asSymbol)
						value: v;
						yourself)].
	^enum
]

{ #category : #accessing }
APxMenuFromEnumExamplePart >> actionText [

	^actionText
]

{ #category : #accessing }
APxMenuFromEnumExamplePart >> actionText: aText [

	actionText := aText.
	self changedAspectValue: #actionText
]

{ #category : #'initialize-release' }
APxMenuFromEnumExamplePart >> defineAspects [

	partInterface description
		createAllAspectsNamed: #(#actionText #menuValue);
		createAspectNamed: #testValueFromMenu
			redirectTo: #(#menuValue #entryValueForKey).
	#(#menuAction #menuValue #mirroredTestMenuValue)
		do: [:menuKey | partInterface createMenuForKey: menuKey]
]

{ #category : #'initialize-release' }
APxMenuFromEnumExamplePart >> initializeActions [

	partInterface description createAction: #menuActionAlice
		do: [self actionText: 'Action Alice performed.'].
	partInterface description createAction: #menuActionBob
		do: [self actionText: 'Action Bob performed.'].
	partInterface description createAction: #menuActionEve
		do: [self actionText: 'Action Eve performed.']
]

{ #category : #'initialize-release' }
APxMenuFromEnumExamplePart >> initializeValues [

	actionText := nil.
	menuAction := APMenuFromEnumerationPart onPart: self key: #menuAction.
	menuAction enumeration: self class exampleMenuEnumerationForAction.
	menuValue := APMenuFromEnumerationPart onPart: self key: #menuValue.
	menuValue
		enumeration: self class exampleMenuEnumerationForValue;
		trigger: #valueChanged
			do: [mirroredTestMenuValue value: menuValue value].
	mirroredTestMenuValue := APMenuFromEnumerationPart onPart: self
				key: #mirroredTestMenuValue.
	mirroredTestMenuValue enumeration: self class exampleMenuEnumerationForValue
]

{ #category : #logging }
APxMenuFromEnumExamplePart >> logException: ex [

	Transcript
		show: 'Exception caught by ' , self class name , ':';
		cr;
		show: ex messageText
]

{ #category : #accessing }
APxMenuFromEnumExamplePart >> menuAction [

	^menuAction
]

{ #category : #accessing }
APxMenuFromEnumExamplePart >> menuValue [

	^menuValue
]

{ #category : #accessing }
APxMenuFromEnumExamplePart >> mirroredTestMenuValue [

	^mirroredTestMenuValue
]
