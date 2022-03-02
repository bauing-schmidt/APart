Class {
	#name : #APContextMenuPart,
	#superclass : #APEnumerationValuePart,
	#instVars : [
		'actionAssignmentsDictionary',
		'groupsIDs'
	],
	#category : #'APart BasicParts'
}

{ #category : #'instance creation' }
APContextMenuPart class >> onPart: aPart key: aKey groupsIDs: groupsIDs [

	^self
		onPart: aPart
		key: aKey
		preInit: nil
		postInit: nil
		groupsIDs: groupsIDs
]

{ #category : #'instance creation' }
APContextMenuPart class >> onPart: aPart key: aKey preInit: aPreInitBlock postInit: aPostInitBlock groupsIDs: groupsIDs [

	| inst |
	inst := self new.
	inst groupsIDs: groupsIDs.
	aPreInitBlock ifNotNil: [aPreInitBlock value: inst].
	aPart notNil
		ifTrue: [inst initOn: aPart key: aKey]
		ifFalse: 
			[inst clientRegistry
				ifNil: [inst useClientRegistry: (APartClientRegistry on: inst)].
			inst initialize].
	inst applyPostInitBlock: aPostInitBlock.
	^inst
]

{ #category : #'API member groups' }
APContextMenuPart >> acceptMemberGroup: aGroup [

	| redirectedActions |
	
	redirectedActions := (aGroup redirectionsFrom: self) select: #isAction.
	enumeration ifNil: [ enumeration := APEnumeration create].
	redirectedActions do: [ :action |
		| entry |
		enumeration ensureRemoveEntryAt: action memberName.
		entry := APEnumEntry on: enumeration key: action memberName.
		entry action: action.
		enumeration addEntry: entry ].

]

{ #category : #'API member groups' }
APContextMenuPart >> acceptedMemberGroupTypes [

	^ (self groupsIDs, super acceptedMemberGroupTypes) asArray
]

{ #category : #accessing }
APContextMenuPart >> actionAssignmentsDictionary [
	^ actionAssignmentsDictionary
]

{ #category : #accessing }
APContextMenuPart >> actionAssignmentsDictionary: anObject [
	actionAssignmentsDictionary := anObject
]

{ #category : #accessing }
APContextMenuPart >> assign: aPart to: anActionName [

	| assignments |
	
	assignments := (self actionAssignmentsDictionary at: anActionName ifAbsentPut: [ OrderedCollection new ]).
	assignments add: aPart.
	^ assignments
]

{ #category : #'API member groups' }
APContextMenuPart >> canAcceptMemberGroup: anAPMemberRefGroup [

	"limit exposing part to be sure the right context menu is used"

	^ (self groupsIDs includes: anAPMemberRefGroup type) and: [ 
		self parentPart = anAPMemberRefGroup part or: [
			self parentPart = anAPMemberRefGroup part parentPart ] ]
]

{ #category : #accessing }
APContextMenuPart >> groupsIDs [

	^ groupsIDs
]

{ #category : #accessing }
APContextMenuPart >> groupsIDs: anObject [

	groupsIDs := anObject
]

{ #category : #accessing }
APContextMenuPart >> initialize [

	super initialize.
	
	actionAssignmentsDictionary := Dictionary new.
	
	self askForMemberGroups.
]

{ #category : #accessing }
APContextMenuPart >> targetInterface [
	^ parentPart partInterface 

]
