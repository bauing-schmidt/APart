Class {
	#name : #APartRecordingSequenceClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'part'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartRecordingSequenceClientTest >> setUp [
	
	super setUp.
	
	part := APartTestFormPart createWithClientRegistry.
	
	client := APartRecordingSequenceClient openOnPart: part.
]

{ #category : #running }
APartRecordingSequenceClientTest >> testFinalizeRecordings [

	client isRecording: true.
		
	part partInterface executeTrigger: #clearFirstName.
	
	client isRecording: false.
	
	client allLastInteractions isEmpty
]

{ #category : #running }
APartRecordingSequenceClientTest >> testHasRecordings [

	client isRecording: true.
	
	self deny: client hasRecordings.	
		
	part partInterface executeTrigger: #clearFirstName.
	
	self assert: client hasRecordings.
]

{ #category : #running }
APartRecordingSequenceClientTest >> testInteractions [

	client isRecording: true.
	
	self deny: client hasRecordings.	
		
	part partInterface executeTrigger: #clearFirstName.
		
	self assert: client allLastInteractions size equals: 2.

	self assert: client allLastInteractions first type equals: #action.
	self assert: client allLastInteractions first key equals: #clearFirstName.
	self assertCollection: client allLastInteractions first subInteractions hasSameElements:  {client allLastInteractions second }.

	self assert: client allLastInteractions second type equals: #valueChange.
	self assert: client allLastInteractions second key equals: #firstName.
	self assert: client allLastInteractions second value isNil.
]
