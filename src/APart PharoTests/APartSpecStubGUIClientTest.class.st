Class {
	#name : #APartSpecStubGUIClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'part',
		'form'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartSpecStubGUIClientTest >> setUp [
	super setUp.
	SpBindings
		value: SpStubAdapterBindings
		during: [ | app |
			app := SpMockApplication new.
			part := APartTestFormPart createWithClientRegistry.
			form := (APartTestForm openOnPart: part application: app) presenter.
			client := part clientRegistry findAnyClientForInterface: part partInterface.
		]
]

{ #category : #tests }
APartSpecStubGUIClientTest >> testClose [

	client close

]

{ #category : #tests }
APartSpecStubGUIClientTest >> testCloseActiveSubApp [

	self flag: #todo. "the test opens GUI"

	SpBindings
		value: SpStubAdapterBindings
		during: [ | app |
			app := SpMockApplication new.
			part := APartTestFormWithSubAppConfiguration createWithClientRegistry.
			form := (APartTestForm openOnPart: part application: app) presenter.
			client := part clientRegistry findAnyClientForInterface: part partInterface.
			part initializeValues.
			client closeActiveSubApp
		]
]

{ #category : #tests }
APartSpecStubGUIClientTest >> testCorrectClientType [

	self assert: client class equals: APartSpecStubGUIClient

]

{ #category : #tests }
APartSpecStubGUIClientTest >> testIsOpen [ 

	self assert:  client isOpen 
]

{ #category : #tests }
APartSpecStubGUIClientTest >> testOwnerDo [

	| found count | 
	
	found := nil.
	count := 0.
	
	client ownerDo: [ :owner | 
		found := owner.
		count := count + 1 ].
	self assert: found equals: form.
	self assert: count equals: 1
]

{ #category : #tests }
APartSpecStubGUIClientTest >> testPromptExecutor [

	self flag: #todo. "the test opens GUI"

	SpBindings value: SpStubAdapterBindings during: [ 
		self assert: client promptExecutor class equals: APViewPromptExecutor
	].

]

{ #category : #tests }
APartSpecStubGUIClientTest >> testRelease [
	
	client release.
	self assert: client partInterface isNil.
]

{ #category : #tests }
APartSpecStubGUIClientTest >> testUtility [

	| utility |
	
	utility := Object new.
	
	part partInterface utilityAt: #translator put: utility.
	self assert: (client utilityAt: #translator) equals: utility.
	self assert: (client utilityAt: #missingUtility) isNil.
	self assert: (client utilityAt: #missingUtility ifAbsent: [ self ]) equals: self.
	
	
]
