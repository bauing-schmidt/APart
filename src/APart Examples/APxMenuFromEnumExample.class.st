"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxMenuFromEnumExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-MenuFromEnum'
}

{ #category : #API }
APxMenuFromEnumExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#menu -> [ | mainMenu |
			mainMenu := SpMenuBarPresenter new.
			aPresenter applyKeyBindingsFromMenu: mainMenu.
				mainMenu ].
		#actionText -> [ aPresenter newTextInput ].
		#testValueFromMenu -> [ aPresenter newTextInput ].
		#mirroredTestMenuValue -> [ aPresenter newDropList
			   aspectSymbol: #'state value'; 
            choicesSymbol: #'state enumerationTextList' ].
	 }.

]

{ #category : #API }
APxMenuFromEnumExample class >> defaultLayout [
	<spec>

	^ SpBoxLayout newVertical
		add: #actionText;
		add: #testValueFromMenu;
		add: #mirroredTestMenuValue;
		yourself
]

{ #category : #API }
APxMenuFromEnumExample class >> matchingPartClass [

	^APxMenuFromEnumExamplePart
]

{ #category : #binding }
APxMenuFromEnumExample >> topTestMenuAction [

	| m pmItem |
	m := APMenu new.
	pmItem := APMenuItem labeled: (self aPartTranslate: #TestmenuAction).
	pmItem submenu: (self menuFor: #menuAction).
	m addItem: pmItem.
	pmItem := APMenuItem labeled: (self aPartTranslate: #TestmenuValue).
	pmItem submenu: (self menuFor: #menuValue).
	m addItem: pmItem.
	^m
]
