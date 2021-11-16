"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxMenuHierarchyFromEnumPragmaExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-MenuHierarchyFromEnumPragma'
}

{ #category : #API }
APxMenuHierarchyFromEnumPragmaExample class >> matchingPartClass [

	^APxMenuHierarchyFromEnumPragmaExamplePart
]

{ #category : #accessing }
APxMenuHierarchyFromEnumPragmaExample >> testMenu [

	| testMenu actionSubMenu peripheralSubMenu allSubMenu |
	testMenu := APMenu new.
	actionSubMenu := APMenuItem labeled: 'Actions'.
	actionSubMenu submenu: (self menuFor: #actionMenu).
	testMenu addItem: actionSubMenu.
	peripheralSubMenu := APMenuItem labeled: 'Peripherals'.
	peripheralSubMenu submenu: (self menuFor: #peripheralMenu).
	testMenu addItem: peripheralSubMenu.
	allSubMenu := APMenuItem labeled: 'All'.
	allSubMenu submenu: ((APMenu new)
				addItem: actionSubMenu;
				addItem: peripheralSubMenu).
	testMenu addItem: allSubMenu.
	^testMenu
]
