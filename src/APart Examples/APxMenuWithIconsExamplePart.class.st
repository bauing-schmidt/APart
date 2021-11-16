"
APxMenuWithIconsExamplePart demonstriert:
- Ergänzung einer Enumeration durch Icons
- Koordination von Value-Changes in Menüs und Listen

Die Integration von Icons in Enumerations in der hier gezeigten Form ist eine Vereinfachung, da Icons Elemente der Präsentationsschicht sind, zumal sie hier darstellungsrelevante Informationen tragen (speziell ihre Größe in Pixeln). In der derzeitigen Form fehlt noch eine trennende Schicht ähnlich wie zwischen einem Text und einem grafischem Label, das bereits eine Font-Zuordnung hat. Geplant ist die Einführung eines IconResolvers, der anstelle des konkreten Icons verwendet wird.
"
Class {
	#name : #APxMenuWithIconsExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'itemList',
		'itemMenuEnumPart',
		'hexPrintBlock',
		'selectedValueString'
	],
	#category : #'APart Examples-MenuWithIcons'
}

{ #category : #'initialize-release' }
APxMenuWithIconsExamplePart >> defineAspects [

	partInterface createMenuForKey: #itemMenuEnumPart
]

{ #category : #'initialize-release' }
APxMenuWithIconsExamplePart >> initializeValues [

	hexPrintBlock :=
			[:e |
			| hexString |
			hexString := e printStringHex.
			hexString := '00000' , hexString.
			hexString := hexString copyFrom: hexString size - 5 to: hexString size.
			'#' , hexString].
	itemList := APartList onPart: self key: #itemList.
	itemList
		list: #(16r00DE3A 16r00A63D 16r59BBA8 16r00B0DB 16r0C75BB 16r7F5CA3 16r62332A 16rA26615 16r898024 16rB9CE00 16rF9B000 16rF39200 16rFFEE00)
					asOrderedCollectionWithDependants;
		itemStringRepresentationBlock: hexPrintBlock;
		itemIconRepresentationBlock: 
				[:e |
				self iconNamed: #grau_leer_quadrat copy];
		trigger: #selectionChanged
			do: [self updateSelectedValueStringFrom: itemList selection];
		exposeListAspect.
	itemMenuEnumPart := APMenuFromEnumerationPart onPart: self key: #menuValue.
	itemMenuEnumPart trigger: #valueChanged
		do: 
			[self updateSelectedValueStringFrom: itemMenuEnumPart value.
			itemList selection: itemMenuEnumPart value].
	itemMenuEnumPart enumerationUpdateBlock: 
			[| enum |
			enum := APEnumeration named: #itemEnumeration.
			enum textFromKeyBlock: hexPrintBlock.
			enum iconFromKeyBlock: 
					[:e |
					self iconNamed: #grau_leer_quadrat copy].
			itemList list do: 
					[:v |
					enum addEntry: ((APEnumEntry on: enum key: v)
								value: v;
								yourself)].
			enum].
	self disableAllAspects: #(#selectedValueString)
]

{ #category : #accessing }
APxMenuWithIconsExamplePart >> itemMenuEnumPart [

	^itemMenuEnumPart
]

{ #category : #accessing }
APxMenuWithIconsExamplePart >> selectedValueString [

	^selectedValueString
]

{ #category : #private }
APxMenuWithIconsExamplePart >> updateSelectedValueStringFrom: newValue [

	selectedValueString := newValue ifNotNil: [:n | hexPrintBlock value: n].
	self changedAspectValue: #selectedValueString
]
