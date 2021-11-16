"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxMenuFromDynamicEnumExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-DynamicEnum'
}

{ #category : #API }
APxMenuFromDynamicEnumExample class >> matchingPartClass [

	^APxMenuFromDynamicEnumExamplePart
]

{ #category : #binding }
APxMenuFromDynamicEnumExample >> topTestMenuAction [

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
