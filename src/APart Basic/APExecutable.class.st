"
APExecutable enhances the superclass by introducing 
* a BlockClosure to define the action to be executed,
* information about the (optionally) expected arguments needed for block execution,
* a subclass responsibility to support recording and (later) replaying of action calls, see #createRecordedInteraction.

argumentsTemplate is a normally empty Array with as many elements as arguments may occur. In special cases (not yet occurring in examples), some of those elements may be preset with a value that does not have to be passed by the caller then.
"
Class {
	#name : #APExecutable,
	#superclass : #APartAbstractAction,
	#instVars : [
		'actionBlock',
		'isExpectingArgument',
		'argumentsTemplate'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #'instance creation' }
APExecutable class >> do: aBlock [

	^self new initOn: aBlock
]

{ #category : #'instance creation' }
APExecutable class >> key: aKey do: aBlock [

	^(self do: aBlock)
		key: aKey;
		yourself
]

{ #category : #API }
APExecutable >> actionBlock [

	^actionBlock
]

{ #category : #API }
APExecutable >> checkConsistencyForPart: aPart ifNotDo: aOneArgBlock [

	argumentsTemplate size = actionBlock numArgs
		ifFalse: 
			[(self maySkipPartArgumentFor: argumentsTemplate) ifTrue: [^self].
			aOneArgBlock value: self errorMessageForArgsMismatch.
			^self].
	self isRunInParentPart
		ifTrue: 
			[aPart parentPart isNil
				ifTrue: [aOneArgBlock value: 'Action will need parentPart at execution time']]
]

{ #category : #API }
APExecutable >> createArgumentsArrayOn: aPart and: anArgument [

	| args |
	argumentsTemplate isEmpty ifTrue: [^argumentsTemplate].
	args := argumentsTemplate copy.
	self isRunInParentPart ifTrue: [args at: 1 put: aPart].
	isExpectingArgument ifTrue: [args at: args size put: anArgument].
	^args
]

{ #category : #API }
APExecutable >> createRecordedInteraction [
	"Expected to answer a kind of APRecordedInteraction that is able to represent the executed action for recording and playback"
	
	self subclassResponsibility
]

{ #category : #private }
APExecutable >> errorMessageForArgsMismatch [

	^'actionBlock expects ' , actionBlock numArgs printString
		, ' parameters, action is defined for ' , argumentsTemplate size printString
]

{ #category : #API }
APExecutable >> executeWith: args [
	"The block parameter for the ParentPart may be omitted if nothing else is expected"

	actionBlock numArgs = args size
		ifTrue: [^actionBlock valueWithArguments: args].
	(self maySkipPartArgumentFor: args) ifTrue: [^actionBlock value].
	self aPartError: #messageForArgsMismatch text: self errorMessageForArgsMismatch
]

{ #category : #'initialize-release' }
APExecutable >> expectArgument [

	isExpectingArgument := true.
	argumentsTemplate := Array new: argumentsTemplate size + 1
]

{ #category : #private }
APExecutable >> findPragmaMethodDefForActionBlock [

	| p |
	p := actionBlock copiedValues detect: [:cv | cv class == Pragma]
				ifNone: [^nil].
	^p methodDefinition
]

{ #category : #'initialize-release' }
APExecutable >> initOn: anActionBlock [

	actionBlock := anActionBlock.
	self initialize
]

{ #category : #'initialize-release' }
APExecutable >> initialize [

	isExpectingArgument := false.
	argumentsTemplate := #()
]

{ #category : #API }
APExecutable >> isExpectingArgument [

	^isExpectingArgument
]

{ #category : #API }
APExecutable >> isRunInParentPart [

	^false
]

{ #category : #API }
APExecutable >> isTrigger [

	^false
]

{ #category : #private }
APExecutable >> maySkipPartArgumentFor: args [

	^actionBlock numArgs = 0
		and: [args size = 1 and: [self isRunInParentPart and: [isExpectingArgument not]]]
]

{ #category : #API }
APExecutable >> postExecuteForPart: aPart [
]

{ #category : #printing }
APExecutable >> printOn: s [

	super printOn: s.
	s
		nextPut: $(;
		nextPutAll: key printString;
		nextPut: $)
]

{ #category : #'API inspector' }
APExecutable >> targetAction [

	^self
]

{ #category : #private }
APExecutable >> targetActionKey [

	^key
]

{ #category : #API }
APExecutable >> wantsScopeUpdate [

	^true
]
