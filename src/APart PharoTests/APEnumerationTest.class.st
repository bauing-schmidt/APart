Class {
	#name : #APEnumerationTest,
	#superclass : #TestCase,
	#instVars : [
		'enumeration'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APEnumerationTest >> setUp [
	
	super setUp.
	
	enumeration := APEnumeration named: #enumId.

]

{ #category : #running }
APEnumerationTest >> testActionEnablementFromKeyBlock [
	
	| entry entry2 active active2 |
	
	active := false.
	active2 := false.
	
	entry := 	enumeration addEntryForKey: #key1.
	entry2 := enumeration addEntryForKey: #key2.
	self assert: (enumeration isActiveAt: #key1) equals: true.
	
	entry setStatefulConditionOn: (APCondition on: [ active ] ifNot: #notActive).
	entry updateCondition.
	self deny: (enumeration isActiveAt: #key1).
	self assert: (enumeration isActiveAt: #key2).
	
	enumeration actionEnablementFromKeyBlock: [ :aKey | active2 ].
	
	self deny: (enumeration isActiveAt: #key1) equals: #someIcon.
	self deny: (enumeration isActiveAt: #key2).

	active2 := true.
	self deny: (enumeration isActiveAt: #key1) equals: #someIcon.
	self assert: (enumeration isActiveAt: #key2).

]

{ #category : #running }
APEnumerationTest >> testActionFromKeyBlock [
	
	| entry entry2 |
	
	entry := 	enumeration addEntryForKey: #key1.
	entry2 := enumeration addEntryForKey: #key2.
	self assert: (enumeration actionForKey: #key1) equals: nil.
	entry action: #someAction.
	self assert: (enumeration actionForKey: #key1) equals: #someAction.
	
	enumeration actionFromKeyBlock: [ :aKey | 'modified', aKey capitalized ].
	
	self assert: (enumeration actionForKey: #key1) equals: #someAction.
	self assert: (enumeration actionForKey: #key2) equals: #modifiedKey2
	
	
]

{ #category : #running }
APEnumerationTest >> testActions [
	
	self assert: enumeration actions isEmpty.
	
	(enumeration addEntryForKey: #key1) action: #action1.
	(enumeration addEntryForKey: #key2) action: #action2.
	
	self assertCollection: (enumeration actions) hasSameElements: #(action1 action2).

]

{ #category : #running }
APEnumerationTest >> testAddAllEntriesForKeys [
		
	enumeration addAllEntriesForKeys: #(key1 key2).
	
	self assertCollection: (enumeration keys) hasSameElements: #(key1 key2).
	self assertCollection: (enumeration values) hasSameElements: #(nil nil).

]

{ #category : #running }
APEnumerationTest >> testIconFromKeyBlock [
	
	| entry entry2 |
	
	entry := 	enumeration addEntryForKey: #key1.
	entry2 := enumeration addEntryForKey: #key2.
	self assert: (enumeration iconForKey: #key1) equals: nil.
	entry icon: #someIcon.
	self assert: (enumeration iconForKey: #key1) equals: #someIcon.
	
	enumeration iconFromKeyBlock: [ :aKey | 'icon', aKey capitalized ].
	
	self assert: (enumeration iconForKey: #key1) equals: #someIcon.
	self assert: (enumeration iconForKey: #key2) equals: #iconKey2
	
	
]

{ #category : #running }
APEnumerationTest >> testId [

	self assert: enumeration id equals: #enumId
]

{ #category : #running }
APEnumerationTest >> testIsActive [

	self assert: enumeration isActive.
	
	enumeration statefulCondition: APCondition false.
	
	self deny: enumeration isActive.
]

{ #category : #running }
APEnumerationTest >> testKeyAndValuesDo [

	| entry |
	
	self assert: enumeration texts isEmpty.
		
	entry := enumeration addEntryForKey: #key1 value: 11.
	
	enumeration keysAndValuesDo: [ :k :v | 
		self assert: k equals: #key1.
		self assert: v equals: entry ]
]

{ #category : #running }
APEnumerationTest >> testKeyForText [

	| entry1 entry2 |
	
	self assert: enumeration texts isEmpty.
	
	self assert: (enumeration keyForText: 'text2') equals: nil.
	
	enumeration addEntry: (entry1 := APEnumEntry on: enumeration text: 'text1').
	enumeration addEntry: (entry2 := APEnumEntry on: enumeration text: 'text2').
	
	self assert: (enumeration keyForText: 'text2') equals: entry2 key.

]

{ #category : #running }
APEnumerationTest >> testKeyForValue [
	
	self assert: enumeration texts isEmpty.
	
	self assert: (enumeration keyForValue: 12) equals: nil.
	
	enumeration addEntryForKey: #key1 value: 11.
	enumeration addEntryForKey: #key2 value: 12.
	
	self assert: (enumeration keyForValue: 12) equals: #key2

]

{ #category : #running }
APEnumerationTest >> testKeyIndicationStatefulConditionOn [
		
	enumeration addAllEntriesForKeys: #(key1 key2).
		
	enumeration key: #key1 indicationStatefulConditionOn: APCondition true.
	enumeration key: #key2 indicationStatefulConditionOn: APCondition false.
	
	enumeration updateCondition.
	self assert: (enumeration isIndicatedOnAt: #key1).
	self deny: (enumeration isIndicatedOnAt: #key2).
	
]

{ #category : #running }
APEnumerationTest >> testKeys [
	
	self assert: enumeration keys isEmpty.
	
	(enumeration addEntryForKey: #key1) action: #action1.
	(enumeration addEntryForKey: #key2) action: #action2.
	
	self assertCollection: (enumeration keys) hasSameElements: #(key1 key2).

]

{ #category : #running }
APEnumerationTest >> testRecursive [

	| entry subEnumeration |
	
	subEnumeration := APEnumeration 
								named: #numbers
								withKeyValuePairs: #(one 1 two 2 three 3).
	
	entry := APEnumEntrySubEnumeration
		addUnder: enumeration
		key: #embeddedEnumeration
		subEnumeration: subEnumeration.
	
	self assert: enumeration isRecursive.
]

{ #category : #running }
APEnumerationTest >> testRelease [
		
	enumeration addEntryForKey: #key1.
	
	enumeration release.
	
	enumeration keys isEmptyOrNil.
]

{ #category : #running }
APEnumerationTest >> testSetDefaultActionBlocksForInterface [

	| part interface executed enabled |

	executed := false.
	enabled := true.
	part := APart createWithClientRegistry.
	interface := part partInterface.
	
	interface description createAction: #someAction do: [ executed := true ] if: (APCondition on: [ enabled ] ifNot: #disabled).
	
	enumeration addAllEntriesForKeys: #(someAction).
	
	enumeration setDefaultActionBlocksForInterface: interface.
	
	self deny: executed.
	(enumeration actionForKey: #someAction) value.
	self assert: executed.
	self assert: (enumeration isActiveAt: #someAction).
	enabled := false.
	interface updateCondition.
	self deny: (enumeration isActiveAt: #someAction).

]

{ #category : #running }
APEnumerationTest >> testTagsTreeRoot [

	| root entry1 entry2 entry3 |

	entry1 := enumeration addEntryForKey: #key1.
	entry2 := enumeration addEntryForKey: #key2.
	entry3 := enumeration addEntryForKey: #key3.
		
	entry1 addTag: #tag1.
	entry2 addTag: #tag2.
	entry3 addTag: #tag2.		
			
	root := enumeration tagsTreeRoot.
	
	self assert: root tag equals: #root.
	self assert: root childrenNodes size equals: 2.
	
	self assert: (root childrenNodes allSatisfy: [ :each | each parentNode = root ]).
	
	
	
]

{ #category : #running }
APEnumerationTest >> testTextActionKeyBlock [

	enumeration addEntryForKey: #key1.
	enumeration addEntryForKey: #key2.

	self assert: (enumeration actionForKey: #key1) isNil.
	self assert: (enumeration actionForKey: #key2) isNil.
	
	enumeration actionFromKeyBlock: [ :aKey | ('action', aKey capitalized) asSymbol ].

	self assert: (enumeration actionForKey: #key1) equals: #actionKey1.
	self assert: (enumeration actionForKey: #key2) equals: #actionKey2.
]

{ #category : #running }
APEnumerationTest >> testTextFromKeyBlock [

	enumeration addEntryForKey: #key1.
	enumeration addEntryForKey: #key2.

	self assert: (enumeration textForKey: #key1) equals: 'key1'.
	self assert: (enumeration textForKey: #key2) equals: 'key2'.
	
	enumeration textFromKeyBlock: [ :aKey | 'entry ', aKey ].

	self assert: (enumeration textForKey: #key1) equals: 'entry key1'.
	self assert: (enumeration textForKey: #key2) equals: 'entry key2'.
]

{ #category : #running }
APEnumerationTest >> testTexts [
	
	self assert: enumeration texts isEmpty.
	
	enumeration addEntry: (APEnumEntry on: enumeration text: 'text1').
	enumeration addEntry: (APEnumEntry on: enumeration text: 'text2').
	
	self assertCollection: enumeration texts hasSameElements: #(text1 text2). 
]

{ #category : #running }
APEnumerationTest >> testUpdateOnFinalReason [

	| active |
	
	active := true.
	
	enumeration statefulCondition: (APCondition on: [ active ] ifNot: #notActive) asStatefulCondition.
	
	enumeration updateCondition.
	self assert: enumeration isActive.
	
	active := false.
	enumeration updateCondition.
	self assert: enumeration statefulCondition reason equals: #notActive.

	enumeration updateOnFinalReason: #finalReason.
	self deny: enumeration isActive.
	self assert: enumeration statefulCondition reason equals: #finalReason.
]

{ #category : #running }
APEnumerationTest >> testValues [

	self assert: enumeration values isEmpty.

	(enumeration addEntryForKey: #key1) value: 11.
	(enumeration addEntryForKey: #key2) value: 12.

	self assertCollection: enumeration values hasSameElements: #(11 12)
]
