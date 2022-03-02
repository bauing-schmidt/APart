"
APConditionBase is the abstract base class for all APCondition objects.
Instance variable name has no technical function but serves as support for the display of conditions in the debugger.

--

DE:APConditionBase ist die abstrakte Basisklasse für alle APCondition-Objekte.
Instanzvariable name hat keine technische Funktion, sondern dient als Unterstützung für die Anzeige von Conditions im Debugger.
"
Class {
	#name : #APConditionBase,
	#superclass : #Object,
	#instVars : [
		'name',
		'reason'
	],
	#category : #'APart Basic-Conditions'
}

{ #category : #'instance creation' }
APConditionBase class >> named: aName [

	^(self new)
		name: aName;
		yourself
]

{ #category : #API }
APConditionBase >> & next [

	<ignoreForCoverage>

	self subclassResponsibility
]

{ #category : #API }
APConditionBase >> asFinalConditionUsingCache: conditionCache [

	^APConditionFinal on: (self computeReasonUsingCache: conditionCache)
]

{ #category : #API }
APConditionBase >> asStatefulCondition [

	^APStatefulCondition on: self
]

{ #category : #API }
APConditionBase >> booleanValue [

	<ignoreForCoverage>

	self subclassResponsibility
]

{ #category : #API }
APConditionBase >> computeReason [

	^ self booleanValue
		ifTrue: [ nil ]
		ifFalse: [ reason ]
]

{ #category : #API }
APConditionBase >> computeReasonUsingCache: conditionCache [

	^conditionCache at: self ifAbsentPut: [self computeReason]
]

{ #category : #API }
APConditionBase >> invertedIfNot: aReason [

	^APConditionInverted new initOn: self ifNot: aReason
]

{ #category : #testing }
APConditionBase >> isConditionChain [

	^ false
]

{ #category : #accessing }
APConditionBase >> name [

	^ name
]

{ #category : #'initialize-release' }
APConditionBase >> name: aName [

	name := aName
]

{ #category : #printing }
APConditionBase >> printOn: s [

	super printOn: s.
	self name notNil
		ifTrue: 
			[s
				nextPut: ${;
				nextPutAll: self name;
				nextPut: $}].
	reason notNil
		ifTrue: 
			[s
				nextPutAll: '(reason=';
				nextPutAll: reason asString;
				nextPut: $)]
]

{ #category : #'initialize-release' }
APConditionBase >> setNameIfUndefined: aName [
	"Debugging support"

	name isNil ifTrue: [name := aName]
]
