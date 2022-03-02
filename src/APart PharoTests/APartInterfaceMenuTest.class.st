Class {
	#name : #APartInterfaceMenuTest,
	#superclass : #TestCase,
	#instVars : [
		'interface',
		'part',
		'form',
		'client',
		'partWithRedirection',
		'partWithRedirectionToRedirection'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartInterfaceMenuTest >> setUp [
	super setUp.
	SpBindings
		value: SpStubAdapterBindings
		during: [ | app |
			app := SpMockApplication new.
			part := APartTestFormPartWithMenu createWithClientRegistry.
			interface := part partInterface.
			form := (APartTestForm openOnPart: part application: app) presenter.
			client := part clientRegistry findAnyClientForInterface: interface.
		]
]

{ #category : #tests }
APartInterfaceMenuTest >> testCreateMenuForKey [

	| aMenu |
	
	interface createMenuForKey: #actionMenu.
	
	aMenu := part actionMenu.
	
	self assert: ((interface menuFor: #actionMenu ifAbsent: [ self fail ]) value isKindOf: APMenu)
]
