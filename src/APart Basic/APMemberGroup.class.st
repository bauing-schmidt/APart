"
I collect members (aspects/actions) of parts in order to expose them in context menus.

Inst vars:
	- members: OrderedCollection
"
Class {
	#name : #APMemberGroup,
	#superclass : #Object,
	#instVars : [
		'id',
		'members',
		'part',
		'subId'
	],
	#category : #'APart Basic-Member Groups'
}

{ #category : #'initialize - release' }
APMemberGroup class >> onPart: aPart [
	^ self basicNew initOn: aPart
]

{ #category : #accessing }
APMemberGroup >> acceptedBy: aPart [ 

	^ self part memberGroup: self acceptedBy: aPart
]

{ #category : #adding }
APMemberGroup >> addAction: anAction [

	anAction memberGroup: self.
	^ members add: anAction
]

{ #category : #adding }
APMemberGroup >> addAspect: anAspect [

	anAspect memberGroup: self.
	^ members add: anAspect
]

{ #category : #accessing }
APMemberGroup >> at: aSymbol [ 

	^ self members detect: [ :e | e key = aSymbol ]
]

{ #category : #accessing }
APMemberGroup >> disabledByFocus [

	^ self part activeFocus not
]

{ #category : #accessing }
APMemberGroup >> hasFocus [

	^ true
]

{ #category : #accessing }
APMemberGroup >> id [ 

	^ id
]

{ #category : #'initialize-release' }
APMemberGroup >> initOn: aPart [
	part := aPart.
	self initialize
]

{ #category : #'initialize-release' }
APMemberGroup >> initialize [
	members := OrderedCollection new.

]

{ #category : #accessing }
APMemberGroup >> members [

	^ members
]

{ #category : #accessing }
APMemberGroup >> part [
	^ part
]

{ #category : #accessing }
APMemberGroup >> redirectionsFrom: aPart [ 

	^ self members collect: [ :each |
		each asRedirectedNamed: each memberName on: aPart path: part pathFromRoot ]
]

{ #category : #accessing }
APMemberGroup >> subId [

	^ subId
]

{ #category : #accessing }
APMemberGroup >> subId: anObject [

	subId := anObject
]

{ #category : #accessing }
APMemberGroup >> type [
	^ id
]

{ #category : #accessing }
APMemberGroup >> type: anObject [
	id := anObject
]
