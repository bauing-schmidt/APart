Class {
	#name : #APartRecordingClientTest,
	#superclass : #TestCase,
	#instVars : [
		'client',
		'part'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartRecordingClientTest >> setUp [
	
	super setUp.
	
	part := APartTestFormPart createWithClientRegistry.
	
	client := APartGenericListener openOnPart: part.
	
	
]

{ #category : #running }
APartRecordingClientTest >> testActionsExecutedDo [

	| key arg execPart recorded |
	
	recorded := false.
	
	client onActionsExecuted: #(#clearFirstName) do: [ :actionKey :actionArg :executingPart |
		recorded := true.
		key := actionKey.
		arg := actionArg.
		execPart := executingPart ].
	
	self assertCollection: client interestingActionKeys keys equals: #(clearFirstName).	

	client isRecording: true.

	part partInterface execute: #clearLastName ifDisabled: [].
	
	self deny: recorded.

	part partInterface execute: #clearFirstName ifDisabled: [].
	
	self assert: recorded.
	self assert: key equals: #clearFirstName.
	self assert: arg equals: #().
	self assert: execPart equals: part.
]

{ #category : #running }
APartRecordingClientTest >> testAnnouncedStateForKeyifAbsent [

	self assert: (client announcedStateForKey: #clearFirstName ifAbsent: [nil]) isNil.

	part partInterface executeTrigger: #clearFirstName.
	
	self deny: (client announcedStateForKey: #clearFirstName ifAbsent: [nil]) isActive.
	self deny: (client announcedStateForKey: #saveData ifAbsent: [nil]) isActive.

]

{ #category : #running }
APartRecordingClientTest >> testExecutingAction [

	client isRecording: true.
	self deny: client hasReceivedShutdown. 
	part partInterface closePart.
	self assert: client hasReceivedShutdown.
]

{ #category : #running }
APartRecordingClientTest >> testHasRecordings [

	self deny: client isRecording.
	
	client isRecording: true.
	
	part partInterface executeTrigger: #clearFirstName.
	
	"generic listener does not store recordings"
	self deny: client hasRecordings.

]

{ #category : #running }
APartRecordingClientTest >> testIsLogging [

	client startLogging.
	self assert: client isLogging.
	
	client endLogging.
	self deny: client isLogging
]

{ #category : #running }
APartRecordingClientTest >> testIsRecording [ 

	self deny: client isRecording.
	
	client isRecording: true.
	self assert: client isRecording.
	
	client isRecording: false.
	self deny: client isRecording.
	

]

{ #category : #running }
APartRecordingClientTest >> testKeysToLog [
	
	| string |
	
	string := String streamContents: [ :s |
		client loggingStream: s.
	
		client startLogging.
		client keysToLog: #(saveData).
		
		self assertCollection: client keysToLog hasSameElements: #(saveData).
		
		self assertCollection: (client loggedKeysFrom: (Dictionary newFrom: {#saveData->nil. #clearFirstName->nil } )) hasSameElements: #(saveData).

		part partInterface executeTrigger: #clearFirstName.
	].

	self assert: string trimBoth equals: 'Start logging recording client #APartTestFormPart\#handleDefaultAnnouncedState: (#saveData=false)' withCRs
]

{ #category : #running }
APartRecordingClientTest >> testOnChangeOfAspectsDo [

	| record |
	
	record := nil.
		
	client onChangeOfAspects: #(#firstName) do: [ :key :value |
		record := key -> value.
		 ].
		
	self assertCollection: client interestingAspectKeys keys equals: #(firstName).	

	client isRecording: true.
	part aPartPerform: #firstName with: 'Joe'.

	self assert: record equals: #firstName -> 'Joe'.
]

{ #category : #running }
APartRecordingClientTest >> testOnChangeOfStatesDo [

	| newStates oldStates |
	
	newStates := OrderedCollection new.	
	oldStates := OrderedCollection new.	
		
	client onChangeOfStates: #(clearFirstName) do: [ :newState :oldState |
		newStates add: newState.
		oldStates add: oldState.
		 ].
	
	self assertCollection: client interestingStateKeys keys equals: #(clearFirstName).	
	
	part partInterface executeTrigger: #clearFirstName.
	
	self assert: newStates size equals: 1.
	self assert: oldStates size equals: 1.
	self assert: newStates first key equals: #clearFirstName.
	self deny: newStates first isActive.
	self assert: oldStates first isNil.

	part aPartPerform: #firstName with: 'Joe'.
	self assert: newStates size equals: 2.
	self assert: oldStates size equals: 2.
	self assert: oldStates second key equals: #clearFirstName.
	self deny: oldStates second isActive.
	self assert: newStates second key equals: #clearFirstName.
	self assert: newStates second isActive.
]

{ #category : #running }
APartRecordingClientTest >> testRegistered [

	| listeners |
	
	listeners := OrderedCollection new.

	part partInterface interactionListenersDo: [ :aListener | listeners add: aListener ].
	
	self assertCollection: listeners hasSameElements: { client }.
]
