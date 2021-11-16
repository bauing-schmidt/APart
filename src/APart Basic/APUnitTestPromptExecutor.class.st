"
APUnitTestPromptExecutor führt Prompt-Entscheidungen in UnitTests durch.

"
Class {
	#name : #APUnitTestPromptExecutor,
	#superclass : #APHeadlessPromptExecutor,
	#category : #'APart Basic-Prompt'
}

{ #category : #API }
APUnitTestPromptExecutor class >> clientTypes [

	^#(#UnitTest)
]

{ #category : #API }
APUnitTestPromptExecutor >> executePromptForPart: aPromptPart synchronize: otherPromptExecutors [
	"If UnitTestPromptExecutor is leading and a GUI prompt executor exists, a GUI client in addition to UnitTestClient is opened automatically (if not already present).
	Thus, a GUI prompt will wait for input if no prompt result has been prepared for running the test."

	| preparedResult resultValue promptClosingTriggerKey |
	(otherPromptExecutors detect: [:each | each class clientTypes = #(#GUI)]
		ifNone: [])
			ifNotNil: 
				[:guiPromptExecutor |
				aPromptPart isSimplePrompt
					ifFalse: 
						[owner partInterface part == aPromptPart
							ifFalse: [guiPromptExecutor openNonModalClientFor: aPromptPart]]].
	preparedResult := self fetchNextPromptResultCheckingAgainst: aPromptPart.
	resultValue := nil.
	(#(#confirmEnumValue: #multiChoice: #requestNewFilename: #singleChoice: #text:)
		includes: aPromptPart promptSelector)
			ifTrue: [aPromptPart value: preparedResult value]
			ifFalse: 
				[aPromptPart promptSelector = #openModal:
					ifTrue: 
						["If prompt is finalized by recorded action, this assignment will fetch the result.
						In this case, promptClosingTriggerKey is nil."
						resultValue := self testCase with: aPromptPart
									compute: preparedResult value]].
	promptClosingTriggerKey := preparedResult promptClosingTriggerKey.
	self testCase isRecording
		ifTrue: 
			[self
				noticeExecutionOfTrigger: promptClosingTriggerKey
				forPrompt: aPromptPart
				weight: (self weightForExecutingPrompt: aPromptPart)].
	promptClosingTriggerKey notNil
		ifTrue: 
			[resultValue := aPromptPart partInterface
						executeTrigger: promptClosingTriggerKey].
	otherPromptExecutors do: 
			[:e |
			e
				noticeExecutionOfTrigger: promptClosingTriggerKey
				forPrompt: aPromptPart
				weight: (e weightForExecutingPrompt: aPromptPart)].
	^resultValue
]

{ #category : #private }
APUnitTestPromptExecutor >> fetchNextPromptResultCheckingAgainst: aPromptPart [

	^self testCase fetchNextPromptResultCheckingAgainst: aPromptPart
]

{ #category : #private }
APUnitTestPromptExecutor >> noticeExecutionOfTrigger: triggerKey forPrompt: aPromptPart weight: anInteger [

	| promptResult |
	promptResult := self testCase
				noticeExecutionOfTrigger: triggerKey
				forPrompt: aPromptPart
				weight: anInteger.
	owner partInterface
		interactionListenersDo: [:ial | ial recordPromptResult: promptResult]
]

{ #category : #private }
APUnitTestPromptExecutor >> testCase [

	^owner testCase
]

{ #category : #API }
APUnitTestPromptExecutor >> weightForExecutingPrompt: aPromptPart [

	^self testCase weightForExecutingPrompt: aPromptPart
]
