"
APEnumEntry represents a common entry for an enumeration.

--

DE:APEnumEntry represents a common entry for an enumeration.
"
Class {
	#name : #APEnumEntry,
	#superclass : #APEnumAbstractEntry,
	#instVars : [
		'value',
		'action',
		'tags'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #'instance creation' }
APEnumEntry class >> on: enumParent key: aKey [

	^self new initOn: enumParent key: aKey
]

{ #category : #'instance creation' }
APEnumEntry class >> on: enumParent key: aKey value: aValue [

	^(self new initOn: enumParent key: aKey)
		value: aValue;
		yourself
]

{ #category : #'instance creation' }
APEnumEntry class >> on: enumParent text: aText [

	^(self new initOn: enumParent key: enumParent generateKey)
		text: aText;
		yourself
]

{ #category : #accessing }
APEnumEntry >> action [

	<ignoreForCoverage>
	^action
]

{ #category : #accessing }
APEnumEntry >> action: anObject [

	<ignoreForCoverage>
	action := anObject
]

{ #category : #accessing }
APEnumEntry >> addTag: aSymbol [

	tags add: aSymbol
]

{ #category : #'initialize-release' }
APEnumEntry >> initOn: enumParent key: aKey [

	super initOn: enumParent key: aKey.
	tags := OrderedCollection new
]

{ #category : #accessing }
APEnumEntry >> tags [

	^tags
]

{ #category : #accessing }
APEnumEntry >> value [

	^value
]

{ #category : #accessing }
APEnumEntry >> value: anObject [

	value := anObject
]
