"
APEnumEntrySubEnumeration is an entry for an enumeration that contains another enumeration instead of the usual values of an entry. This is transformed into a submenu when building a menu.

--

DE:APEnumEntrySubEnumeration ist ein Eintrag für eine Enumeration, der anstelle der üblichen Werte eines Eintrags eine weitere Enumeration enthält. Diese wird beim Bau eines Menüs in ein Submenü transformiert.
"
Class {
	#name : #APEnumEntrySubEnumeration,
	#superclass : #APEnumAbstractEntry,
	#instVars : [
		'subEnumeration'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #'instance creation' }
APEnumEntrySubEnumeration class >> addUnder: enumParent key: aKey subEnumeration: aSubEnumeration [

	^enumParent
		addEntry: (self new initOn: enumParent key: aKey sub: aSubEnumeration)
]

{ #category : #'instance creation' }
APEnumEntrySubEnumeration class >> on: enumParent sub: aSubEnumeration [

	^self new initOn: enumParent sub: aSubEnumeration
]

{ #category : #'initialize-release' }
APEnumEntrySubEnumeration >> initOn: enumParent key: aKey sub: aSubEnumeration [

	enumeration := enumParent.
	key := aKey.
	subEnumeration := aSubEnumeration
]

{ #category : #'initialize-release' }
APEnumEntrySubEnumeration >> initOn: enumParent sub: aSubEnumeration [

	enumeration := enumParent.
	subEnumeration := aSubEnumeration
]

{ #category : #API }
APEnumEntrySubEnumeration >> isEnumeration [

	^true
]

{ #category : #API }
APEnumEntrySubEnumeration >> subEnumeration [

	^subEnumeration
]

{ #category : #accessing }
APEnumEntrySubEnumeration >> updateCondition [

	super updateCondition.
	subEnumeration updateCondition.
]
