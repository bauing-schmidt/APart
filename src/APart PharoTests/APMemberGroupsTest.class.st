Class {
	#name : #APMemberGroupsTest,
	#superclass : #TestCase,
	#instVars : [
		'root',
		'leftPart',
		'rightPart',
		'exposingPart',
		'acceptingPart'
	],
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #running }
APMemberGroupsTest >> setUp [ 

	super setUp.
	
	root := APTestRootPart createWithClientRegistry.
	leftPart := APart onPart: root key: #leftPart.
	rightPart := APart onPart: root key: #rightPart.
	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.
	
	exposingPart expose.

]
