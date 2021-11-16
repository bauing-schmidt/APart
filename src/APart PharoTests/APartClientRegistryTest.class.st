Class {
	#name : #APartClientRegistryTest,
	#superclass : #TestCase,
	#instVars : [
		'registry',
		'part'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartClientRegistryTest >> setUp [
	
	super setUp.
	
	part := APartTestFormPart new initialize. "not complete initialization for testing purposes"
	registry := APartClientRegistry on: part.
	part useClientRegistry: registry.
]

{ #category : #tests }
APartClientRegistryTest >> testClientClassRegistry [

	self assert: registry clientClassRegistry isEmpty.	

	"force recreation of the registry"
	registry release. 

	self assertCollection: ((registry clientClassRegistry at: #APartTest1) at: #GUI) hasSameElements: { APartTest1Gui }
]

{ #category : #tests }
APartClientRegistryTest >> testClientTypesForInterface [
	"As soon as we register a client of an interface, the registry should know the related client types."

	| client interface result |

	client := APartHeadlessClient new.	
	interface := part partInterface.
	
	result := registry clientTypesForInterface: interface.
	self assert: result isEmpty.
	
	registry registerClient: client forInterface: interface.

	result := registry clientTypesForInterface: interface.
	self assertCollection: result hasSameElements: #(Headless UnitTest).

]

{ #category : #tests }
APartClientRegistryTest >> testDefaultPromptExecutor [
	"test if the default prompt executor servers for displaying of GUI"
	
	| executor |
	
	executor := registry defaultPromptExecutor.
	executor class clientTypes includes: #GUI.
	 
]

{ #category : #tests }
APartClientRegistryTest >> testDefautlClientClassRegistry [

	self assert: registry clientClassRegistry isEmpty.	

	"force recreation of the registry"
	registry release. 

	self assertCollection: ((registry clientClassRegistry at: #APartTest1) at: #GUI) hasSameElements: { APartTest1Gui }
]

{ #category : #tests }
APartClientRegistryTest >> testExclusinvePart [
	"smoke test"

	self shouldnt: [ 
		registry startExclusivePart: part.
		registry endExclusivePart: part.	
	] raise: Error
]

{ #category : #tests }
APartClientRegistryTest >> testFindClientClassesWithTypesForPart [

	| aDictionary |
	
	part := APartTest1 new.
	
	"can be tested only in the development mode"
	aDictionary := registry findClientClassesWithTypesForPart: part.

	self assert: (aDictionary at: #GUI) equals: APartTest1Gui.
	
	self assertCollection: (registry findClientClassesForPart: part) hasSameElements: { APartTest1Gui }.

]

{ #category : #tests }
APartClientRegistryTest >> testInitialized [

	self assert: registry rootPart equals: part
]

{ #category : #tests }
APartClientRegistryTest >> testInterfaceClients [

	| client interface  |

	client := APartHeadlessClient new.	
	interface := part partInterface.
	
	self deny: (registry clientsForInterface: interface ifPresent: [ :setOfClients | true ] ifAbsent: [ false ]).
	self deny: (registry findClientsForInterface: interface) isNotNil.
	
	registry registerClient: client forInterface: interface.
	
	self 
		assertCollection: (registry clientsForInterface: interface ifPresent: [ :setOfClients | setOfClients ] ifAbsent: [ { } ]) 
		hasSameElements: { client }.
	self 
		assertCollection: (registry findClientsForInterface: interface) 
		hasSameElements: { client }.

]

{ #category : #tests }
APartClientRegistryTest >> testOpenClientsForPart [

	SpBindings value: SpStubAdapterBindings during: [
		| app |
		app := SpMockApplication new. 
		registry openClientsForPart: part application: app.
		self assert: (registry 
							clientsForInterface: part partInterface 
							ifPresent: [ :setOfClients | setOfClients size = 1 ] 
							ifAbsent: [ false ])
	]
	
	
]

{ #category : #tests }
APartClientRegistryTest >> testRelease [

	registry release.
	self assert: registry rootPart isNil.
	
]

{ #category : #tests }
APartClientRegistryTest >> testRemoveClientsFor [

	| client interface  |

	client := APartHeadlessClient new.	
	interface := part partInterface.
	
	registry registerClient: client forInterface: interface.
	self assert: (registry clientsForInterface: interface ifPresent: [ :setOfClients | true ] ifAbsent: [ false ]).
	registry removeClientsFor: interface.

	self deny: (registry clientsForInterface: interface ifPresent: [ :setOfClients | true ] ifAbsent: [ false ]).
	
]

{ #category : #tests }
APartClientRegistryTest >> testResetClients [

	| client interface  |

	client := APartHeadlessClient new.	
	interface := part partInterface.
	
	registry registerClient: client forInterface: interface.
	self assert: (registry clientsForInterface: interface ifPresent: [ :setOfClients | true ] ifAbsent: [ false ]).
	registry resetClients.

	self deny: (registry clientsForInterface: interface ifPresent: [ :setOfClients | true ] ifAbsent: [ false ]).
	
]
