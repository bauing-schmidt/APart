"
based on original CCSTestCase
"
Class {
	#name : #SUTAPTestCase,
	#superclass : #TestCase,
	#instVars : [
		'timeout',
		'timerProcess',
		'helperProcesses',
		'manager'
	],
	#category : #'APart Tests'
}

{ #category : #'initialize-release' }
SUTAPTestCase class >> defaultTestIniName [
	"Name of the Ini-File used for Tests"

	"^'CCSTest'"
	^'CCSTest-17.1'
]

{ #category : #defaults }
SUTAPTestCase class >> defaultTimeout [

	^3000000
]

{ #category : #pragma }
SUTAPTestCase class >> resourceMethodPragmas [
	<pragmas: #instance>
	^#( 	#name:title:parents:keyWords:  
		#name:title:parents:keyWords:spec: )
]

{ #category : #timeOut }
SUTAPTestCase class >> shallRunWithTimeout: aTestSelector [

	^false
]

{ #category : #'VisualWorks metadata' }
SUTAPTestCase class >> visualWorksMetadata [

	^ #(
		'namespace' 'XProgramming.SUnit'
		'superclassNamespace' 'XProgramming.SUnit'
	)

]

{ #category : #'asserting-utils' }
SUTAPTestCase >> failWith: aReasonText [

	self assert: false description: aReasonText
]

{ #category : #accessing }
SUTAPTestCase >> getTimeout [
"timout may be nil !
using this method allows/needs to use your own defaultTimeout.
finally timeout must be always an Integer !
"
	^timeout
]

{ #category : #'initialize-release' }
SUTAPTestCase >> initialize [

	super initialize.
	helperProcesses := OrderedCollection new.
	timeout := nil.
	^self
]

{ #category : #private }
SUTAPTestCase >> removeHandlers [

	helperProcesses size > 0
		ifTrue: 
			[helperProcesses copy do: 
					[:p |
					
					[p terminate.
					helperProcesses remove: p] on: Error do: [:ex | ]]]
]

{ #category : #running }
SUTAPTestCase >> runCase [
	"This can be overridden to do before and after work but the super runCase call would be dangerous to omit."

	| result |
	self resources do: [:each | each availableFor: self].
	
	[self setUp.
	result := self performTest]
			ensure: [
				self tearDown.
				self cleanUpInstanceVariables].
	^result
]

{ #category : #timeOut }
SUTAPTestCase >> shallRunWithTimeout [

	^self class shallRunWithTimeout: testSelector
]

{ #category : #running }
SUTAPTestCase >> tearDown [

	timerProcess ifNotNil: [timerProcess terminate].
	self removeHandlers
]

{ #category : #accessing }
SUTAPTestCase >> timeout [
"see comment in #getTimeout
"
	^timeout ifNil: [self class defaultTimeout]
]

{ #category : #accessing }
SUTAPTestCase >> timeout: anObject [

	timeout := anObject
]

{ #category : #utility }
SUTAPTestCase >> wait: milliSeconds [

	(Delay forMilliseconds: milliSeconds) wait
]
