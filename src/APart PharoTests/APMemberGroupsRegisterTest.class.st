Class {
	#name : #APMemberGroupsRegisterTest,
	#superclass : #APMemberGroupsTest,
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #running }
APMemberGroupsRegisterTest >> setUp [ 

	super setUp.
]

{ #category : #running }
APMemberGroupsRegisterTest >> testInitialState [ 

	self assert: exposingPart acceptedMemberGroupTypes isEmpty.
	self assert: acceptingPart acceptedMemberGroupTypes size equals: 1.
]
