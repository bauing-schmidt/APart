Class {
	#name : #APMemberGroupsFocusTest,
	#superclass : #TestCase,
	#instVars : [
		'root',
		'leftPart',
		'rightPart',
		'exposingPart',
		'exposingPart2',
		'acceptingPart'
	],
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #running }
APMemberGroupsFocusTest >> setUp [ 

	super setUp.
	
	root := APTestRootPart createWithClientRegistry.
	leftPart := APart onPart: root key: #leftPart.
	rightPart := APart onPart: root key: #rightPart.
	exposingPart := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart.
	exposingPart2 := APTestingPartExposingMemberGroups onPart: leftPart key: #exposingPart2.
	acceptingPart := APTestingPartAcceptingMemberGroups onPart: rightPart key: #acceptingPart.
	
	exposingPart id: 1.
	exposingPart2 id: 2.
	
	exposingPart expose.
	exposingPart2 expose.

]

{ #category : #running }
APMemberGroupsFocusTest >> testAccepting [

	| window presenter | 

	window := APTestingPartExposingMemberGroupsPresenter openOnPart: exposingPart.
	presenter := window presenter. 
	
	self deny: (presenter additionalSubpresentersMap at: #someAction) isEnabled.	

	exposingPart takeFocus.	
	self assert: (presenter additionalSubpresentersMap at: #someAction) isEnabled.
	
	exposingPart2 takeFocus.	
	self deny: (presenter additionalSubpresentersMap at: #someAction) isEnabled.
	window close.
]

{ #category : #running }
APMemberGroupsFocusTest >> testActionsDeniedWithoutFocus [

	| action action2 | 
	
	action := exposingPart description actionAt: #someAction ifAbsent: [ self fail ].
	action2 := exposingPart2 description actionAt: #someAction ifAbsent: [ self fail ].
	
	self deny: action isExecutable.
	self deny: action2 isExecutable.
	

]

{ #category : #running }
APMemberGroupsFocusTest >> testActionsExecutability [

	| action action2 | 
	
	action := exposingPart description actionAt: #someAction ifAbsent: [ self fail ].
	action2 := exposingPart2 description actionAt: #someAction ifAbsent: [ self fail ].
	
	exposingPart takeFocus.
	self assert: action isExecutable.
	self deny: action2 isExecutable.
	
	exposingPart2 takeFocus.
	self deny: action isExecutable.
	self assert: action2 isExecutable.


]

{ #category : #running }
APMemberGroupsFocusTest >> testExposingParts [ 

	| exposingParts | 
	
	exposingParts := root memberGroupsRegistry allExposingPartsFor: #testingGroup.
	self assert: exposingParts size equals: 2.
	self assertCollection: exposingParts hasSameElements: { exposingPart. exposingPart2 }.
]

{ #category : #running }
APMemberGroupsFocusTest >> testFocusSwitch [

	| aPart | 
	
	exposingPart takeFocus. 
	exposingPart2 takeFocus. 
	aPart := root memberGroupsRegistry exposingPartWithFocusFor: #testingGroup.
	self deny: exposingPart hasFocus.
	self assert: exposingPart2 hasFocus.
	self assert: aPart equals: exposingPart2.
]

{ #category : #running }
APMemberGroupsFocusTest >> testPartWithFocus [

	| aPart | 
	
	exposingPart takeFocus. 
	aPart := root memberGroupsRegistry exposingPartWithFocusFor: #testingGroup.
	self assert: aPart equals: exposingPart.
]

{ #category : #running }
APMemberGroupsFocusTest >> testPartWithFocus2 [

	| aPart | 
	
	exposingPart2 takeFocus. 
	aPart := root memberGroupsRegistry exposingPartWithFocusFor: #testingGroup.
	self assert: aPart equals: exposingPart2.
]

{ #category : #running }
APMemberGroupsFocusTest >> testPartWithoutFocus [

	| aPart | 
	
	aPart := root memberGroupsRegistry exposingPartWithFocusFor: #testingGroup.
	self assert: aPart isNil.
]

{ #category : #running }
APMemberGroupsFocusTest >> testPerformingExposed1 [

	| result | 
	
	exposingPart takeFocus.
		
	result := acceptingPart execute: #someAction ifDisabled: [ self fail ].
	self assert: result equals: 1.
	
	
]

{ #category : #running }
APMemberGroupsFocusTest >> testPerformingExposed2 [

	| result | 
	
	exposingPart2 takeFocus.
		
	result := acceptingPart execute: #someAction ifDisabled: [ self fail ].
	self assert: result equals: 2.
]

{ #category : #running }
APMemberGroupsFocusTest >> testPresenter [ 

	| window presenter | 
	window := APTestingPartExposingMemberGroupsPresenter openOnPart: exposingPart.
	presenter := window presenter. 
	
	self deny: (presenter additionalSubpresentersMap at: #someAction) isEnabled.	

	exposingPart takeFocus.	
	self assert: (presenter additionalSubpresentersMap at: #someAction) isEnabled.
	
	exposingPart2 takeFocus.	
	self deny: (presenter additionalSubpresentersMap at: #someAction) isEnabled.
	window close.
]
