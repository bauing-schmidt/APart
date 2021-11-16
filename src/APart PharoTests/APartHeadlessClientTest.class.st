Class {
	#name : #APartHeadlessClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'part'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartHeadlessClientTest >> setUp [
	
	super setUp.
	
	part := APartTestFormPart createWithClientRegistry.
	
	client := APartHeadlessClient openOnPart: part.
	
	
]

{ #category : #running }
APartHeadlessClientTest >> testChangeInterfaceFromTo [

	| interface newInterface |
	
	interface := client partInterface.
	newInterface := APartInterface new.
	
	client changeInterfaceFrom: interface to: newInterface.
	
	self assert: client partInterface equals: newInterface. 
	
]

{ #category : #running }
APartHeadlessClientTest >> testChangeInterfaceFromToWhenDifferent [

	| interface oldInterface newInterface |
	
	interface := client partInterface.
	oldInterface := APartInterface new.
	newInterface := APartInterface new.
	
	client changeInterfaceFrom: oldInterface to: newInterface.
	
	"interface was not changed"
	self assert: client partInterface equals: interface. 
	
]

{ #category : #running }
APartHeadlessClientTest >> testClientConfiguration [

	| configuration configuration2 |
	
	configuration := Object new. "stub"
	configuration2 := Object new. "stub"

	part := APartTestFormPart createWithClientRegistry.
	part clientConfiguration: configuration.
	client := APartHeadlessClient openOnPart: part.
	
	self assert: client clientConfiguration equals: part clientConfiguration.
	client clientConfiguration: configuration2.
	self assert: client clientConfiguration equals: configuration2.
	"part keeps the original configuration"
	self assert: part clientConfiguration equals: configuration.
	
]

{ #category : #running }
APartHeadlessClientTest >> testClose [ 

	"smoke tests"
	self shouldnt: [client close] raise: Error.
	self shouldnt: [client closeActiveSubApp] raise: Error.

	
]

{ #category : #running }
APartHeadlessClientTest >> testExecuteActionFor [

	client executeActionFor: #clearFirstName.
	
	self assert: ( client valueForAspect: #firstName) isNil.

]

{ #category : #running }
APartHeadlessClientTest >> testExecuteActionForIfDisabled [

	| message |
	
	message := nil. 

	client executeActionFor: #clearFirstName ifDisabled: [ message := #disabled ].
	self assert: part firstName isNil.
	self assert: message isNil.

]

{ #category : #running }
APartHeadlessClientTest >> testExecuteActionForIfDisabledhenDisabled [

	| message |
	
	message := nil. 

	client setAspect: #firstName value: ''.
	client executeActionFor: #clearFirstName ifDisabled: [ :reason | message := reason ].
	self deny: part firstName isNil.
	self assert: message equals: #FieldIsEmpty.

]

{ #category : #running }
APartHeadlessClientTest >> testExecuteActionForWithIfDisabled [

	| message arg |
	
	part := APartTestFormPartWithArgumentAction createWithClientRegistry. 	
	client := APartHeadlessClient openOnPart: part.

	arg := { 1 }.	
	message := nil. 

	client setAspect: #firstName value: ''.
	client executeActionFor: #clearFirstName with: arg ifDisabled: [ :reason | message := reason ].
	self assert: arg first equals: 1.
	self assert: message equals: #FieldIsEmpty.

]

{ #category : #running }
APartHeadlessClientTest >> testIsHeadlessClient [

	self assert: client isHeadlessClient 
]

{ #category : #running }
APartHeadlessClientTest >> testIsOpen [

	self assert: client isOpen
]

{ #category : #running }
APartHeadlessClientTest >> testNotifyCalledDisabledAction [
	
	| form interface |
		
	SpBindings
		value: SpStubAdapterBindings
		during: [ 
			| app |
			app := SpMockApplication new.
			part := APartTestFormPart createWithClientRegistry.
			interface := part partInterface.
			form := (APartTestForm openOnPart: part application: app) presenter.
			client := (part clientRegistry findClientsForInterface: interface) anyOne.
				
			(form presenterNamed: #clearFirstName) performAction.	
			self should: [(form presenterNamed: #clearFirstName) performAction ] raise: APDisabledActionCallError
	 ]	
]

{ #category : #running }
APartHeadlessClientTest >> testPartInterface [

	self assert: client partInterface equals: part partInterface
]

{ #category : #running }
APartHeadlessClientTest >> testPromptExecutor [

	| newExecutor |

	self assert: (client promptExecutor class clientTypes includes: #Headless).
	
	newExecutor := APHeadlessPromptExecutor on: client.
	
	client promptExecutor: newExecutor.
	self assert: client promptExecutor equals: newExecutor.
	
]

{ #category : #running }
APartHeadlessClientTest >> testRequestForPartClose [

	| value |
	
	value := false.
	
	part trigger: #requestForClose do: [ value := true ].
	client requestForPartClose.
	
	self assert: value.
]

{ #category : #running }
APartHeadlessClientTest >> testSetAspectValue [

	| result |
	result := client setAspect: #firstName value: 'NewFirstName'.
	self assert: ( client valueForAspect: #firstName) equals: 'NewFirstName'.
	self assert: result equals: client.
	
	self assert: (client setAspect: #nonExistiongAspect value: 'NewFirstName') isNil.
	
]

{ #category : #running }
APartHeadlessClientTest >> testSubAppConfiguration [

	part := APartTestFormWithSubAppConfiguration createWithClientRegistry.	
	client := APartHeadlessClient openOnPart: part.
	
	self assert: client subAppConfiguration equals: part subAppConfiguration.	
]

{ #category : #running }
APartHeadlessClientTest >> testValueForAspect [

	self assert: (client valueForAspect: #firstName) equals: 'InitialFirstName'.
	
	self should: [
		client valueForAspect: #nonExistiongAspect
	] raise: APMissingAspectKeyError
]
