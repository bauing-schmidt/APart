"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxMenuNestedEnumeration,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-MenuNestedEnumeration'
}

{ #category : #API }
APxMenuNestedEnumeration class >> matchingPartClass [

	^APxMenuNestedEnumerationPart
]

{ #category : #accessing }
APxMenuNestedEnumeration >> actionMenuForWindow [

	| windowBarMenu |
	windowBarMenu := APMenu new.
	windowBarMenu addItem: ((APMenuItem labeled: 'Actions')
				submenu: (self menuFor: #actionMenu) value).
	windowBarMenu addItem: ((APMenuItem labeled: 'Values')
				submenu: (self menuFor: #valueMenu) value).
	^windowBarMenu
]
