"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxMenuWithIconsExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-MenuWithIcons'
}

{ #category : #API }
APxMenuWithIconsExample class >> matchingPartClass [

	^APxMenuWithIconsExamplePart
]

{ #category : #accessing }
APxMenuWithIconsExample >> topItemMenuAction [

	| m pmItem |
	m := APMenu new.
	pmItem := APMenuItem labeled: (self aPartTranslate: #topItemMenuAction).
	pmItem submenu: (self menuFor: #itemMenuEnumPart).
	m addItem: pmItem.
	^m
]
