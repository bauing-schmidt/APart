"
APxMenuNestedEnumerationPart demonstriert:
- Aufbau von verschachtelten Enumerations
- Enumeration-Entries für Menüs, die eine Action auslösen
- Enumeration-Entries für Menüs, die einen Wert zurückgeben
"
Class {
	#name : #APxMenuNestedEnumerationPart,
	#superclass : #APartExample,
	#instVars : [
		'actionMenu',
		'actionDisplay',
		'valueMenu'
	],
	#category : #'APart Examples-MenuNestedEnumeration'
}

{ #category : #accessing }
APxMenuNestedEnumerationPart >> actionDisplay [

	^actionDisplay
]

{ #category : #accessing }
APxMenuNestedEnumerationPart >> actionDisplay: anObject [

	actionDisplay := anObject.
	self changedAspectValue: #actionDisplay
]

{ #category : #accessing }
APxMenuNestedEnumerationPart >> actionMenu [

	^actionMenu
]

{ #category : #accessing }
APxMenuNestedEnumerationPart >> autoAspectDefinition [ 

	^ true
]

{ #category : #'initialize-release' }
APxMenuNestedEnumerationPart >> defineAspects [

	#(#actionMenu #valueMenu)
		do: [:menuKey | partInterface createMenuForKey: menuKey].
	partInterface description
		createAllAspectsNamed: #(#actionDisplay);
		createAspectNamed: #valueDisplay
			redirectTo: #(#valueMenu #entryValueForKey)
]

{ #category : #'initialize-release' }
APxMenuNestedEnumerationPart >> initializeActions [

	partInterface description 
		createAction: #menuActionApple
			do: [self actionDisplay: 'Action Apple performed'];
		createAction: #menuActionBanana
			do: [self actionDisplay: 'Action Banana performed'];
		createAction: #menuActionStrawberryBoxSmall
			do: [self actionDisplay: 'Action Strawberry box small performed'];
		createAction: #menuActionStrawberryBoxNormal
			do: [self actionDisplay: 'Action Strawberry box normal performed'];
		createAction: #menuActionStrawberryBoxLarge
			do: [self actionDisplay: 'Action Strawberry box large performed'];
		yourself
]

{ #category : #'initialize-release' }
APxMenuNestedEnumerationPart >> initializeValues [

	| mainEnum subEnum |
	actionMenu := APMenuFromEnumerationPart onPart: self key: #actionMenu.
	actionMenu targetInterface: partInterface.
	mainEnum := APEnumeration named: #Fruits
				withValueEntries: #(#Apple #Banana).
	mainEnum actionFromKeyBlock: [:k | (#menuAction , k) asSymbol].
	subEnum := APEnumeration named: #Sizes
				withValueEntries: #(#Small #Normal #Large).
	subEnum actionFromKeyBlock: [:k | (#menuActionStrawberryBox , k) asSymbol].
	APEnumEntrySubEnumeration
		addUnder: mainEnum
		key: #StrawberryBox
		subEnumeration: subEnum.
	actionMenu enumeration: mainEnum.
	valueMenu := APMenuFromEnumerationPart onPart: self key: #valueMenu.
	mainEnum := APEnumeration named: #Fruits
				withKeyValuePairs: #(#apple 'One apple' #banana 'One banana').
	subEnum := APEnumeration named: #Sizes
				withKeyValuePairs: #(#smallBox 'Small strawberry box' #normalBox 'Normal strawberry box' #largeBox 'Large strawberry box').
	APEnumEntrySubEnumeration
		addUnder: mainEnum
		key: #strawberryBox
		subEnumeration: subEnum.
	valueMenu enumeration: mainEnum
]

{ #category : #accessing }
APxMenuNestedEnumerationPart >> valueMenu [

	^valueMenu
]
