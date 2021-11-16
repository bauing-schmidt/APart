Class {
	#name : #APEnumEntryTest,
	#superclass : #TestCase,
	#instVars : [
		'enumeration',
		'entry'
	],
	#category : #'APart PharoTests'
}

{ #category : #'as yet unclassified' }
APEnumEntryTest >> createEntry [

	entry := APEnumEntry on: enumeration text: 'aText'.
	enumeration addEntry: entry.

]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> createKeyedEntry [

	entry := APEnumEntry on: enumeration key: #someKey.
	enumeration addEntry: entry.

]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> setUp [ 

	super setUp.
	
	enumeration := APEnumeration named: #enumId.
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testAddTag [

	self createEntry.
	
	self assert: entry tags isEmpty.
	entry addTag: #someTag.
	
	self assertCollection: entry tags hasSameElements: #(someTag).
	
	entry addTag: #someTag2.
	
	self assertCollection: entry tags hasSameElements: #(someTag someTag2)
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testIsActive [

	| active |
	
	active := false.
	
	self createEntry.	
	self assert: entry isActive.
	
	entry setStatefulConditionOn: (APCondition on: [ active ] ifNot: #notActive).

	self assert: entry isActive.
	self deny: entry isChanged.
	self assert: entry reasonForInactivity isNil.
	
	entry updateCondition.
	self deny: entry isActive.
	self assert: entry isChanged.
	self assert: entry reasonForInactivity equals: #notActive.

	active := true.
	
	self deny: entry isActive.
	entry updateCondition.
	self assert: entry isActive.
	self assert: entry isChanged.
	
	
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testIsIndication [

	| activeIndication |
	
	activeIndication := true.
	
	self createKeyedEntry.	
	self deny: (enumeration isIndicatedOnAt: #someKey).
	
	entry indicationStatefulConditionOn: (APCondition on: [ activeIndication ] ifNot: #notActive).
	
	"different than in case of statefulCondition"
	self assert: (enumeration isIndicatedOnAt: #someKey).
	entry updateCondition.
	self assert: (enumeration isIndicatedOnAt: #someKey).
	
	activeIndication := false.
	
	self assert: (enumeration isIndicatedOnAt: #someKey).
	entry updateCondition.
	self deny: (enumeration isIndicatedOnAt: #someKey).
	
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testOnKey [

	entry := APEnumEntry on: enumeration key: #k.
	
	self assert: entry key equals: #k.
	self deny: entry isEnumeration.
	self assert: entry text isNil.
	self assert: entry value isNil.
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testOnKeyValue [ 

	entry := APEnumEntry on: enumeration key: #k value: 42.
	
	self assert: entry key equals: #k.
	self deny: entry isEnumeration.
	self assert: entry text isNil.
	self assert: entry value equals: 42.
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testOnText [ 

	self createEntry.
	
	self assert: (entry key beginsWith: 'generatedKey').
	self deny: entry isEnumeration.
	self assert: entry text equals: 'aText'.
	self assert: entry value isNil.
]

{ #category : #'as yet unclassified' }
APEnumEntryTest >> testUpdateOnFinalReason [

	| active |
	
	active := true.
	self createEntry.	
	
	entry setStatefulConditionOn: (APCondition on: [ active ] ifNot: #notActive).

	self assert: entry isActive.
	self assert: entry reasonForInactivity isNil.
	
	entry updateOnFinalReason: #finalReason.

	self deny: entry isActive.
	self assert: entry reasonForInactivity equals: #finalReason.

]
