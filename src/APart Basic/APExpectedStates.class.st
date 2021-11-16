"
APExpectedStates repräsentiert ein Set von erwarteten AnnouncedState-Werten und kann diese gegen den Stand eines APUnitTestClients prüfen. Anstelle der ursprünglichen AnnouncedState-Objekte hält es jedoch nur mehr deren boolschen Aktivitätsstatus.
"
Class {
	#name : #APExpectedStates,
	#superclass : #Object,
	#instVars : [
		'testCase',
		'expectedStates'
	],
	#category : #'APart Basic-Recording'
}

{ #category : #'instance creation' }
APExpectedStates class >> create [ 

	^ self new
]

{ #category : #'instance creation' }
APExpectedStates class >> expectAllInactive: inactiveKeys expectAllActive: activeKeys [

	^(self create)
		expectAllInactive: inactiveKeys;
		expectAllActive: activeKeys;
		yourself
]

{ #category : #'instance creation' }
APExpectedStates class >> onStates: announcedStatesDict [

	| inst |
	inst := self create.
	announcedStatesDict
		keysAndValuesDo: [:k :announcedState | inst expect: k isActive: announcedState isActive].
	^inst
]

{ #category : #API }
APExpectedStates >> at: aKey ifAbsent: absentBlock [

	^expectedStates at: aKey ifAbsent: absentBlock
]

{ #category : #API }
APExpectedStates >> at: aKey ifPresent: presentBlock [

	^expectedStates at: aKey ifPresent: presentBlock
]

{ #category : #'initialize-release' }
APExpectedStates >> expect: aKey isActive: aBoolean [

	expectedStates at: aKey put: aBoolean
]

{ #category : #'initialize-release' }
APExpectedStates >> expect: aKey isActiveWhen: isActiveBlock [

	isActiveBlock value
		ifTrue: [self expectActive: aKey]
		ifFalse: [self expectInactive: aKey]
]

{ #category : #'initialize-release' }
APExpectedStates >> expectActive: aKey [

	expectedStates at: aKey put: true
]

{ #category : #'initialize-release' }
APExpectedStates >> expectAll: announcedStates [
	"#addAll nicht benutzen, damit die Daten sofort auf boolsche Werte überprüft werden"

	announcedStates keysAndValuesDo: 
			[:k :v |
			v ifTrue: [self expectActive: k] ifFalse: [self expectInactive: k]]
]

{ #category : #'initialize-release' }
APExpectedStates >> expectAllActive: aKeyList [

	aKeyList do: [:k | self expectActive: k]
]

{ #category : #'initialize-release' }
APExpectedStates >> expectAllInactive: aKeyList [

	aKeyList do: [:k | self expectInactive: k]
]

{ #category : #'initialize-release' }
APExpectedStates >> expectInactive: aKey [

	expectedStates at: aKey put: false
]

{ #category : #API }
APExpectedStates >> findExpectationMismatchUsingClient: utClient [

	expectedStates keysAndValuesDo: 
			[:k :expectedBoolean |
			| clientState |
			clientState := utClient announcedStateForKey: k
						ifAbsent: [^'Missing client state for key ' , k printString].
			clientState isActive == expectedBoolean
				ifFalse: 
					[^'Active state mismatch: Expected ' , expectedBoolean printString
						, ' for ' , k printString]].
	^nil
]

{ #category : #'initialize-release' }
APExpectedStates >> initialize [

	expectedStates := Dictionary new
]

{ #category : #API }
APExpectedStates >> printAsTestExpressionOn: s indent: indentCount receiverString: receiverString [

	| inactives actives |
	actives := SortedCollection new.
	inactives := SortedCollection new.
	expectedStates keysAndValuesDo: 
			[:k :isActive |
			isActive ifTrue: [actives add: k] ifFalse: [inactives add: k]].
	indentCount timesRepeat: [s tab].
	s
		nextPutAll: receiverString;
		cr.
	indentCount + 1 timesRepeat: [s tab].
	s nextPutAll: 'expectAllInactive: #('.
	inactives do: [:k | k printOn: s] separatedBy: [s space].
	s
		nextPut: $);
		cr.
	indentCount + 1 timesRepeat: [s tab].
	s nextPutAll: 'expectAllActive: #('.
	actives do: [:k | k printOn: s] separatedBy: [s space].
	s
		nextPut: $);
		cr
]

{ #category : #printing }
APExpectedStates >> printOn: s [

	| sortedKeys |
	super printOn: s.
	expectedStates isNil ifTrue: [^self].
	sortedKeys := SortedCollection withAll: expectedStates keys.
	s nextPutAll: ' ('.
	sortedKeys do: [:k | s nextPutAll: k printString] separatedBy: [s space].
	s nextPut: $)
]
