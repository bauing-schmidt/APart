Class {
	#name : #APMemberRefGroupTest,
	#superclass : #APMemberGroupsTest,
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #tests }
APMemberRefGroupTest >> testAcceptsMemberGroup [
	
	self assert: acceptingPart acceptedGroups size equals: 1.
	self assert: acceptingPart acceptedGroups first type equals: #testingGroup.
	self assertCollection: exposingPart acceptors hasSameElements: { acceptingPart }.
]

{ #category : #tests }
APMemberRefGroupTest >> testAddAction [

	| actionPerformed group |
	
	actionPerformed := false.
	root description createAction: #someAction do: [ actionPerformed := true ].
	
	group := APMemberGroup onPart: root.
	group addAction: (root description actionAt: #someAction ifAbsent: [ self aPartError: #missingAction ]).
	
	self assert: group members size equals: 1.
	self assert: group members anyOne key equals: #someAction.
	self assert: group members anyOne memberGroup equals: group.
	
]

{ #category : #tests }
APMemberRefGroupTest >> testAddAspect [

	| actionPerformed group |
	
	actionPerformed := false.
	root description createAspectNamed: #someAspect.
		
	group := APMemberGroup onPart: root.
	group addAspect: (root description aspectFor: #someAspect ifAbsent: [ self aPartError: #missingAction ]).
	
	self assert: group members size equals: 1.
	self assert: group members anyOne name equals: #someAspect.
	self assert: group members anyOne memberGroup equals: group.

	
]

{ #category : #tests }
APMemberRefGroupTest >> testRedirections [

	| group redirections redirectedAspect redirectedAction |
	
	group := acceptingPart acceptedGroups anyOne.
	
	redirections := group redirectionsFrom: acceptingPart.
	
	self assert: redirections size equals: 2.
	
	redirectedAspect := redirections detect: [ :each | each isAspect ].
	redirectedAction := redirections detect: [ :each | each isAction ].
	
	self assertCollection: redirectedAspect path asArray equals: #(/ leftPart exposingPart someAspect).
	self assert: redirectedAspect memberName equals: #someAspect.  

	self assertCollection: redirectedAction path asArray equals: #(/ leftPart exposingPart someAction).
	self assert: redirectedAction memberName equals: #someAction.  
	
]
