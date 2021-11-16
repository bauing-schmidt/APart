Class {
	#name : #APartDependenciesRegistryTest,
	#superclass : #TestCase,
	#instVars : [
		'rootPart'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #running }
APartDependenciesRegistryTest >> left1 [

	^ rootPart left 
]

{ #category : #running }
APartDependenciesRegistryTest >> left2 [

	^ rootPart left child
]

{ #category : #running }
APartDependenciesRegistryTest >> right1 [

	^ rootPart right 
]

{ #category : #running }
APartDependenciesRegistryTest >> right2 [

	^ rootPart right child
]

{ #category : #running }
APartDependenciesRegistryTest >> setUp [ 

	super setUp.
	
	rootPart := APartScopesTestRootPart createWithClientRegistry.
	
	"it is required to let recompute all conditions"
	rootPart partInterface updateAndAnnounceAll.
]

{ #category : #running }
APartDependenciesRegistryTest >> testDependenciesCatalogInRootPart [

	"test if all the parts use the same dependencies catalog in the root part"
	self assert: rootPart left dependenciesRegistry equals: rootPart dependenciesRegistry.
	self assert: rootPart right child dependenciesRegistry equals: rootPart dependenciesRegistry.
]

{ #category : #running }
APartDependenciesRegistryTest >> testDependentAspects [

	self right2 partInterface description createAspectNamed: #someAspect.

	self right2 partInterface addDependencyFrom: #someAspect to: #('..' aspectInRight1).
	self right1 partInterface addDependencyFrom: #aspectInRight1 to: #('..' left aspectInLeft1).

	self assertCollection: (self right2 partInterface dependentAspectsOf: #someAspect) hasSameElements: { self right1 -> #aspectInRight1 }.
	self assertCollection: (self right1 partInterface dependentAspectsOf: #aspectInRight1) hasSameElements: { self left1 -> #aspectInLeft1. self right2 -> #someAspect }.
	self assertCollection: (self left1 partInterface dependentAspectsOf: #aspectInLeft1) hasSameElements: { self right1 -> #aspectInRight1 }
]

{ #category : #running }
APartDependenciesRegistryTest >> testDependentPartReferencedByAspect [

	self right2 partInterface description createAspectNamed: #someAspect.
	self right2 partInterface addRawDependencyFrom: #someAspect to: #('/' knownLeft2).

	self assertCollection: (self right2 partInterface dependentAspectsOf: #someAspect) hasSameElements: { rootPart -> #knownLeft2 }
]

{ #category : #running }
APartDependenciesRegistryTest >> testMultipleAbsoluteDependants [

	self right2 partInterface addDependencyFrom: #someAspect to: #('/' right aspectInRight1).
	self right1 partInterface addDependencyFrom: #aspectInRight1 to: #('/' left aspectInLeft1).

	self assertCollection: (self right2 partInterface dependantsOf: #someAspect) hasSameElements: { self right1 }.
	self assertCollection: (self right1 partInterface dependantsOf: #aspectInRight1) hasSameElements: { self left1. self right2 }.
	self assertCollection: (self left1 partInterface dependantsOf: #aspectInLeft1) hasSameElements: { self right1 }
]

{ #category : #running }
APartDependenciesRegistryTest >> testMultipleRelativeDependants [

	self right2 partInterface addDependencyFrom: #someAspect to: #('..' aspectInRight1).
	self right1 partInterface addDependencyFrom: #aspectInRight1 to: #('..' left aspectInLeft1).

	self assertCollection: (self right2 partInterface dependantsOf: #someAspect) hasSameElements: { self right1 }.
	self assertCollection: (self right1 partInterface dependantsOf: #aspectInRight1) hasSameElements: { self left1. self right2 }.
	self assertCollection: (self left1 partInterface dependantsOf: #aspectInLeft1) hasSameElements: { self right1 }
]

{ #category : #running }
APartDependenciesRegistryTest >> testRelativeBackwardDependants [

	self assert: (self right2 partInterface dependantsOf: #someAspect) isEmpty.
	
	self right2 partInterface addDependencyFrom: #someAspect to: #('..' aspectInRight1).

	self assertCollection: (self right1 partInterface dependantsOf: #aspectInRight1) hasSameElements: {self right2}
]

{ #category : #running }
APartDependenciesRegistryTest >> testRelativeForwardDependants [

	self assert: (self right2 partInterface dependantsOf: #someAspect) isEmpty.
	
	self right2 partInterface addDependencyFrom: #someAspect to: #('..' aspectInRight1).

	self assertCollection: (self right2 partInterface dependantsOf: #someAspect) hasSameElements: { self right1 }
]

{ #category : #running }
APartDependenciesRegistryTest >> testUnknownRelativeDependants [

	self right2 partInterface addDependencyFrom: #someAspect to: #('..' unknown).
	self right1 partInterface addDependencyFrom: #aspectInRight1 to: #('..' left unknown).

	self assert: (self right2 partInterface dependantsOf: #someAspect) isEmpty.
	self assert: (self right1 partInterface dependantsOf: #aspectInRight1) isEmpty.
	self assert: (self left1 partInterface dependantsOf: #aspectInLeft1) isEmpty.
]
