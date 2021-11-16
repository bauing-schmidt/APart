Class {
	#name : #APTestingPartAcceptingMemberGroups,
	#superclass : #APart,
	#instVars : [
		'acceptedGroups'
	],
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #'API member groups' }
APTestingPartAcceptingMemberGroups >> acceptMemberGroup: aGroup [

	| redirections redirectedAspect redirectedAction |
	
	acceptedGroups add: aGroup.
	
	redirections := aGroup redirectionsFrom: self.

	redirectedAspect := redirections select: [ :each | each isAspect ].
	redirectedAction := redirections select: [ :each | each isAction ].
	
	redirectedAction do: [ :anAction |
		self description ensureUndefineMember: anAction key.
		self description addAction: anAction ].

	redirectedAspect do: [ :anAspect |
		self description ensureUndefineMember: anAspect name. 
		self description createAspectNamed: anAspect name redirectTo: anAspect path ].

	

]

{ #category : #accessing }
APTestingPartAcceptingMemberGroups >> acceptedGroups [
	^ acceptedGroups
]

{ #category : #accessing }
APTestingPartAcceptingMemberGroups >> acceptedGroups: anObject [
	acceptedGroups := anObject
]

{ #category : #'API member groups' }
APTestingPartAcceptingMemberGroups >> acceptedMemberGroupTypes [

	^ ({ #testingGroup }, super acceptedMemberGroupTypes) asArray
]

{ #category : #'API member groups' }
APTestingPartAcceptingMemberGroups >> canAcceptMemberGroup: anAPMemberRefGroup [

	^ anAPMemberRefGroup type = #testingGroup
]

{ #category : #'initialize-release' }
APTestingPartAcceptingMemberGroups >> createDefaultMembers [

	self description ensureUndefineMember: #someAction.
	self description ensureUndefineMember: #someAspect.
	
	self description createAspectNamed: #someAspect.
	self disableAllAspects: #(someAspect).
	self description createAction: #someAction do: [  ] if: APCondition false.


]

{ #category : #'initialize-release' }
APTestingPartAcceptingMemberGroups >> initialize [

	acceptedGroups := OrderedCollection new.
	
	super initialize.
	

]

{ #category : #'initialize-release' }
APTestingPartAcceptingMemberGroups >> initializeAspects [

	self createDefaultMembers.

	self askForMemberGroups.
]

{ #category : #'API member groups' }
APTestingPartAcceptingMemberGroups >> memberGroupUnexposed: aSymbol [

	(acceptedGroups select: [ :each | each id = aSymbol ]) do: [ :each | 
		acceptedGroups remove: each ].
	
	self createDefaultMembers
]
