"
I serve for collecting of MemberRefGroups. The parts that expose member groups, register to me. At the very end, I find all parts that are able to accept member groups and distribute the collected groups to them.

I am usually placed in the root part.
"
Class {
	#name : #APMemberGroupsRegistry,
	#superclass : #Object,
	#instVars : [
		'rootPart',
		'exposingPartsByGroupName',
		'acceptingPartsByGroupName'
	],
	#category : #'APart Basic-Member Groups'
}

{ #category : #'instance creation' }
APMemberGroupsRegistry class >> for: rootPart [

	^ self new rootPart: rootPart; yourself
]

{ #category : #API }
APMemberGroupsRegistry >> acceptingPartsFor: aSymbol [

 	^ acceptingPartsByGroupName at: aSymbol ifAbsent: Array new
]

{ #category : #API }
APMemberGroupsRegistry >> allExposingPartsFor: aSymbol [ 

	^ (exposingPartsByGroupName at: aSymbol) asArray copy
]

{ #category : #API }
APMemberGroupsRegistry >> askForMemberGroups: memberGrupTypes from: anAcceptingPart [

	| result |
	
	result := OrderedCollection new.
	memberGrupTypes do: [ :each | 
		exposingPartsByGroupName at: each ifPresent: [ :partsArray | 
			| aGroup |
			partsArray do: [ :aPart |
				aPart ifNotNil: [ 
					aGroup := (aPart exposedMemberGroupFor: each).
					aGroup ifNotNil: [ 
						aGroup hasFocus ifTrue: [ 
							result add: aGroup ] ] ] ] ] ].

	self registerAcceptingPart: anAcceptingPart for: memberGrupTypes.

	^ result
]

{ #category : #API }
APMemberGroupsRegistry >> exposeMemberGroup: aMemberGroup from: anObject [
	
	| aWeakArray | 
	
	aWeakArray := exposingPartsByGroupName at: aMemberGroup id ifAbsentPut: [ WeakOrderedCollection new ].
	aWeakArray add: aMemberGroup part.
	
	(self acceptingPartsFor: aMemberGroup id) do: [ :aPart |
		aPart ifNotNil: [ 
			aPart processMemberGroup: aMemberGroup  ]]
]

{ #category : #API }
APMemberGroupsRegistry >> exposingPartWithFocusFor: aSymbol [ 

	^ (self allExposingPartsFor: aSymbol) detect: [ :each | each hasFocus ] ifNone: [ nil ]

	
]

{ #category : #initialization }
APMemberGroupsRegistry >> initialize [

	super initialize.
	self reset.
]

{ #category : #API }
APMemberGroupsRegistry >> registerAcceptingPart: anAcceptingPart for: memberGrupTypes [

	memberGrupTypes do: [ :groupID |
		| existing extended | 
		existing := acceptingPartsByGroupName  at: groupID ifAbsent: [ WeakArray new ].
		extended := existing copyWith: anAcceptingPart.
		acceptingPartsByGroupName at: groupID put: extended ].
]

{ #category : #private }
APMemberGroupsRegistry >> reset [ 
	
	exposingPartsByGroupName := IdentityDictionary new.
	acceptingPartsByGroupName := IdentityDictionary new.
]

{ #category : #accessing }
APMemberGroupsRegistry >> rootPart [
	^ rootPart
]

{ #category : #accessing }
APMemberGroupsRegistry >> rootPart: anObject [
	rootPart := anObject
]

{ #category : #API }
APMemberGroupsRegistry >> unexposeMemberGroupNamed: aSymbol from: aPart [
	
	| acceptors weakArray |
	
	acceptors := acceptingPartsByGroupName at: aSymbol ifAbsent: [ ^ self ].
	acceptors do: [ :each | 
		each ifNotNil: [ 
			each memberGroupUnexposed: aSymbol ] ].
	
	weakArray := exposingPartsByGroupName at: aSymbol ifAbsent: [ ^ self ].
	weakArray remove: aPart ifAbsent: [ ^ self ].
	weakArray ifEmpty: [ 
			exposingPartsByGroupName removeKey: aSymbol ].
	
	
]
