Class {
	#name : #APartTestWalkPath,
	#superclass : #TestCase,
	#instVars : [
		'part1',
		'part2',
		'part3',
		'part4',
		'part5'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartTestWalkPath >> setUp [ 
	
	super setUp.
	
	part1 := TestingAPartWithAspect createWithClientRegistry.
	part2 := APart onPart: part1 key: #part2.
	part3 := TestingAPartWithAspect onPart: part2 key: #part3.
	part4 := APart createWithClientRegistry.
	part5 := APart createWithClientRegistry.
	(part3 partInterface description createAspectNamed: #someAspect) value: part4.
	(part1 partInterface description createAspectNamed: #someAspect) value: part5.
	
	
	
	
]

{ #category : #running }
APartTestWalkPath >> testAspectsInPath [

	| result |
	result := part1 walkPath: #(someAspect).
	self assert: result key equals: part1.
	self assertCollection: result value hasSameElements: #(someAspect).

	result := part1 walkPath: #(#part2 part3 #someAspect).
	self assert: result key equals: part3.
	self assertCollection: result value hasSameElements: #(someAspect).

]

{ #category : #running }
APartTestWalkPath >> testBackwardPath [

	| result |
	result := part2 walkPath: #('..' #someAspect).
	self assert: result key equals: part1.
	self assertCollection: result value hasSameElements: #(someAspect).
	
	result := part3 walkPath: #('..' #someAspect).
	self assert: result key equals: part2.
	self assertCollection: result value hasSameElements: #(someAspect).
	
	result := part3 walkPath: #('..' '..' #someAspect).
	self assert: result key equals: part1.
	self assertCollection: result value hasSameElements: #(someAspect).

]

{ #category : #running }
APartTestWalkPath >> testBackwardPathOverLimit [

	self should: [ 
		part1 walkPath: #('..' #someAspect).
	] raise: APError withExceptionDo: [ :e | self assert: e tag equals: #pathOverLimit ].
	
	self should: [ 
		part1 walkPath: #('..' '..' #someAspect).
	] raise: APError withExceptionDo: [ :e | self assert: e tag equals: #pathOverLimit ].

]

{ #category : #running }
APartTestWalkPath >> testForwardPath [

	| result |
	result := part1 walkPath: #(part2).
	self assert: result key equals: part1.
	self assertCollection: result value hasSameElements: #(part2).
	
	result := part1 walkPath: #(part2 part3).
	self assert: result key equals: part2.
	self assertCollection: result value hasSameElements: #(part3).
]

{ #category : #running }
APartTestWalkPath >> testRootPath [

	| result |
	self should: [ part1 walkPath: #('/') ] raiseAPartError: #invalidPath.
	
	result := part1 walkPath: #('/' #part2).
	self assert: result key equals: part1.
	self assertCollection: result value hasSameElements: #(part2).
	
	result := part3 walkPath: #('/' #part2).
	self assert: result key equals: part1.
	self assertCollection: result value hasSameElements: #(part2).

]
