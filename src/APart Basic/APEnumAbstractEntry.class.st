"
APEnumAbstractEntry is the abstract base class for entries for an enumeration.

--

DE:APEnumAbstractEntry ist die abstrakte Basisklasse für Einträge zu einer Enumeration.
"
Class {
	#name : #APEnumAbstractEntry,
	#superclass : #Object,
	#instVars : [
		'enumeration',
		'key',
		'statefulCondition',
		'indicationStatefulCondition',
		'text',
		'icon'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #'instance creation' }
APEnumAbstractEntry class >> addUnder: enumParent forAction: anAction text: aText [
	^ (self addUnder: enumParent key: anAction key)
		text: aText;
		setStatefulConditionOn: anAction condition;
		yourself
]

{ #category : #'instance creation' }
APEnumAbstractEntry class >> addUnder: enumParent key: aKey [

	^enumParent addEntry: (self new initOn: enumParent key: aKey)
]

{ #category : #'instance creation' }
APEnumAbstractEntry class >> addUnder: enumParent key: aKey text: aText [

	^(self addUnder: enumParent key: aKey)
		text: aText;
		yourself
]

{ #category : #'instance creation' }
APEnumAbstractEntry class >> addUnder: enumParent key: aKey value: aValue text: aText [

	^(self addUnder: enumParent key: aKey)
		value: aValue;
		text: aText;
		yourself
]

{ #category : #accessing }
APEnumAbstractEntry >> icon [

	<ignoreForCoverage>
	^icon
]

{ #category : #accessing }
APEnumAbstractEntry >> icon: anObject [

	<ignoreForCoverage>
	icon := anObject
]

{ #category : #accessing }
APEnumAbstractEntry >> indicationStatefulCondition [

	^indicationStatefulCondition.
]

{ #category : #accessing }
APEnumAbstractEntry >> indicationStatefulConditionOn: aCondition [

	indicationStatefulCondition := APStatefulCondition on: aCondition
]

{ #category : #'initialize-release' }
APEnumAbstractEntry >> initOn: enumParent key: aKey [

	enumeration := enumParent.
	key := aKey.
]

{ #category : #accessing }
APEnumAbstractEntry >> isActive [

	^statefulCondition ifNotNil: [statefulCondition isActive] ifNil: [true]
]

{ #category : #accessing }
APEnumAbstractEntry >> isChanged [

	^statefulCondition ifNotNil: [statefulCondition isChanged] ifNil: [false]
]

{ #category : #API }
APEnumAbstractEntry >> isEnumeration [

	^false
]

{ #category : #accessing }
APEnumAbstractEntry >> key [

	^key
]

{ #category : #printing }
APEnumAbstractEntry >> printOn: s [

	<ignoreForCoverage>
	super printOn: s.
	key isNil ifTrue: [^self].
	s
		nextPut: $(;
		nextPutAll: key;
		nextPut: $)
]

{ #category : #accessing }
APEnumAbstractEntry >> reasonForInactivity [

	^statefulCondition ifNotNil: [statefulCondition reason]
]

{ #category : #accessing }
APEnumAbstractEntry >> setStatefulConditionOn: aCondition [
	statefulCondition := APStatefulCondition on: aCondition
]

{ #category : #accessing }
APEnumAbstractEntry >> statefulCondition [

	<ignoreForCoverage>
	^statefulCondition.
]

{ #category : #accessing }
APEnumAbstractEntry >> text [

	^text
]

{ #category : #accessing }
APEnumAbstractEntry >> text: anObject [

	text := anObject
]

{ #category : #accessing }
APEnumAbstractEntry >> updateCondition [

	statefulCondition ifNotNil: [statefulCondition updateCondition].
	indicationStatefulCondition notNil
		ifTrue: [indicationStatefulCondition updateCondition]
]

{ #category : #accessing }
APEnumAbstractEntry >> updateOnFinalReason: reason [

	statefulCondition
		ifNotNil: [statefulCondition updateOnCondition: (APConditionFinal on: reason)]
]
