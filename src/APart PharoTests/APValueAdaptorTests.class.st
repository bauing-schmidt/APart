Class {
	#name : #APValueAdaptorTests,
	#superclass : #TestCase,
	#instVars : [
		'part',
		'adaptor',
		'changeValue'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APValueAdaptorTests >> doChange [

	changeValue := #changed
]

{ #category : #running }
APValueAdaptorTests >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	
	changeValue := #notChanged.
	part := APPersonPart createWithClientRegistry.
	adaptor := APValueAdaptor on: part key: #name.
	adaptor onChangeSend: #doChange to: self.
]

{ #category : #running }
APValueAdaptorTests >> testChanged [
	

	self assert: changeValue equals: #notChanged.

	adaptor changed: #value.
	
	self assert: changeValue equals: #changed.
]

{ #category : #running }
APValueAdaptorTests >> testChangedWithIgnoringOfChanges [
	

	self assert: changeValue equals: #notChanged.

	adaptor ignoreChangesWhile: [ 
		adaptor changed: #value. ].
	
	self assert: changeValue equals: #notChanged.
]

{ #category : #running }
APValueAdaptorTests >> testCreation [ 
	
	self assert: adaptor model equals: part.	
	self assert: adaptor subject equals: part.
	self assert: adaptor aspectKey equals: #name.
]

{ #category : #running }
APValueAdaptorTests >> testValue [ 

	adaptor value: #newValue.
	
	self assert: changeValue equals: #changed.	
]
