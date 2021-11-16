Class {
	#name : #APDynamicMemberRefGroupTest,
	#superclass : #APMemberGroupsTest,
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #running }
APDynamicMemberRefGroupTest >> setUp [ 

	"unlike the superclass test, we do not create exposing/accepting parts immediatelly"
	
	root := APTestRootPart createWithClientRegistry.
	leftPart := APart onPart: root key: #leftPart.
	rightPart := APart onPart: root key: #rightPart.

]

{ #category : #running }
APDynamicMemberRefGroupTest >> testAcceptingCreatedFirst [
	
	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.

	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	exposingPart expose.
		
	self assert: acceptingPart acceptedGroups size equals: 1.

	
]

{ #category : #running }
APDynamicMemberRefGroupTest >> testAcceptingCreatedFirstWhileExposingPartIsReleased [
	
	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.

	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.	
	exposingPart expose.
	exposingPart release.
		
	self assert: acceptingPart acceptedGroups size equals: 0.

	
]

{ #category : #running }
APDynamicMemberRefGroupTest >> testExposingCreatedFirst [
	
	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	exposingPart expose.

	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.

		
	self assert: acceptingPart acceptedGroups size equals: 1.

]

{ #category : #running }
APDynamicMemberRefGroupTest >> testExposingCreatedFirstWhileExposingPartIsReleased [
	
	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	exposingPart expose.
	
	leftPart removeSubPartForKey: #exposingPart.
	exposingPart release.	

	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.
		
	self assert: acceptingPart acceptedGroups size equals: 0.

]

{ #category : #running }
APDynamicMemberRefGroupTest >> testForgetMemberGroupNamed [
	
	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	exposingPart expose.
	
	exposingPart forgetMemberGroupNamed: #testingGroup.	

	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.
		
	self assert: acceptingPart acceptedGroups size equals: 0.
]

{ #category : #running }
APDynamicMemberRefGroupTest >> testRedirections [

	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.

	self deny: (acceptingPart description actionAt: #someAction ifAbsent: [ self fail ]) isRedirected.
	self deny: (acceptingPart description aspectsAt: #someAspect ifAbsent: [ self fail ]) isRedirected.

	exposingPart expose.
	
	self assert: (acceptingPart description actionAt: #someAction ifAbsent: [ self fail ]) isRedirected.
	self assert: (acceptingPart description aspectsAt: #someAspect ifAbsent: [ self fail ]) isRedirected.
	
]

{ #category : #running }
APDynamicMemberRefGroupTest >> testRedirectionsToReleasedPart [

	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.

	exposingPart expose.
	exposingPart release.

	self deny: (acceptingPart description actionAt: #someAction ifAbsent: [ self fail ]) isRedirected.
	self deny: (acceptingPart description aspectsAt: #someAspect ifAbsent: [ self fail ]) isRedirected.
	
]
