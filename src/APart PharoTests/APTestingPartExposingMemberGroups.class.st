Class {
	#name : #APTestingPartExposingMemberGroups,
	#superclass : #APart,
	#traits : 'APTPartWithFocus',
	#classTraits : 'APTPartWithFocus classTrait',
	#instVars : [
		'group1',
		'acceptors',
		'id'
	],
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #accessing }
APTestingPartExposingMemberGroups >> acceptors [
	^ acceptors
]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> acceptors: anObject [
	acceptors := anObject
]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> canAcceptFocus [

	^ true
]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> canLoseFocus [

	^ true
]

{ #category : #'initialize-release' }
APTestingPartExposingMemberGroups >> defineAspects [

	self description createAllAspectsNamed: #(someAspect).
]

{ #category : #private }
APTestingPartExposingMemberGroups >> expose [

	self exposeMemberGroup: self memberGroup1

]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> focusChanged [

	self reexpose.
	self scopeUpdate.

]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> id [

	^ id
]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> id: anObject [

	id := anObject
]

{ #category : #'initialize-release' }
APTestingPartExposingMemberGroups >> initialize [ 
	
	super initialize.
	
	acceptors := OrderedCollection new.
]

{ #category : #'initialize-release' }
APTestingPartExposingMemberGroups >> initializeActions [

	self description createAction: #someAction do: [ self performAction ] if: APCondition true helpText: #someAction
]

{ #category : #private }
APTestingPartExposingMemberGroups >> memberGroup1 [
	
	group1 := APMemberGroup onPart: self.
	group1 type: #testingGroup.
	group1 addAspect: (self description memberNamed: #someAspect).
	group1 addAction: (self description memberNamed: #someAction).
	
	^ group1
	

]

{ #category : #'API member groups' }
APTestingPartExposingMemberGroups >> memberGroup: aMemberGroup acceptedBy: aPart [ 

	acceptors add: aPart
]

{ #category : #private }
APTestingPartExposingMemberGroups >> performAction [

	^ self id
]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> someAspect [ 

	 ^ #someAspectValue
]

{ #category : #accessing }
APTestingPartExposingMemberGroups >> someAspect: anObject [

	"ignore"
]
