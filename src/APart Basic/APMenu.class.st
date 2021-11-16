Class {
	#name : #APMenu,
	#superclass : #Object,
	#instVars : [
		'items',
		'groupSizes',
		'adornment',
		'selectionMemory'
	],
	#category : #'APart Basic-Support'
}

{ #category : #adding }
APMenu >> addItem: aMenuItem [
	"Add a new MenuItem to the end of the menu.  The new menu item will become part of the last group of menu items."

	| lastGroupSize |
	items := items copyWith: aMenuItem.
	lastGroupSize := groupSizes at: groupSizes size.
	groupSizes at: groupSizes size put: lastGroupSize + 1
]

{ #category : #adding }
APMenu >> addLine [

	"stub"
]

{ #category : #'as yet unclassified' }
APMenu >> initialize [

	"Initialize the menu item list to be empty."

	adornment := nil.
	items := Array new.
	groupSizes := Array with: 0
]

{ #category : #adding }
APMenu >> items [ 
	
	^ items
]

{ #category : #adding }
APMenu >> menuItems [
	"Answer the collection of all the menu items in this MenuItemList, including those designated as not visible.  This collection is not to be modified directly."

	^items
]

{ #category : #'as yet unclassified' }
APMenu >> someMenuItemWithValue: aMenuItemValue ifNone: exceptionBlock [
	"Answer the menu item with the given value associated with it (which may be in submenus).  If none, answer the result of evaluating expectionBlock."
	"In MenuItems sind Blöcke als Value erlaubt, daher wird hier die or:-Alternative hinzugefügt."

	^self someMenuItemWhich: 
			[:menuItem :menuItemValue |
			menuItemValue = aMenuItemValue or: 
					[((menuItemValue isKindOf: BlockClosure) and: [menuItemValue numArgs = 0])
						ifTrue: [menuItemValue value = aMenuItemValue]
						ifFalse: [false]]]
		ifNone: exceptionBlock
]
