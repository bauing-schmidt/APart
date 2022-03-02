"
Abstract base class for all kinds of use cases that are addressed to execute an APUseCaseAction. Its API covers the following requirements:
* [assertImplementedAction: actionKey] checks #implementedActionKeys to ensure that called action key is declared correctly in subclass.
* [conditionForUseCaseAction: actionKey] expects APCondition instance that is wrapped into APStatefulCondition for the given action.
* [performUseCaseActionFor: actionKey {args: args}] expects action to be executed, optionally with arguments.
* [helpTextForUseCaseAction: actionKey] expects translated helpText.
  
"
Class {
	#name : #APUseCase,
	#superclass : #Object,
	#instVars : [
		'actionKey',
		'isCloneForExecution',
		'part'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #API }
APUseCase class >> createAction: anActionKey onPart: aPart [

	| ucInst |
	ucInst := self onPart: aPart actionKey: anActionKey.
	aPart partInterface description
		createAction: anActionKey
		forUseCase: ucInst.
	"self pdmRegisterTranslation: anActionKey"
]

{ #category : #API }
APUseCase class >> createAllImplementedActionsOnPart: aPart [

	self implementedActionKeys do: [:k |
		self createAction: k onPart: aPart.
		k last = $:
			ifTrue: [ aPart description setExpectArgumentForActionKey: k	].
	]
]

{ #category : #API }
APUseCase class >> implementedActionKeys [
	"Must be overwritten in every subclass"

	^#()
]

{ #category : #API }
APUseCase class >> onPart: aPart actionKey: anActionKey [
	"Mind that part and actionKey are expected to alread be present before #initialize is run in subclasses.
	Thus, we must use #basicNew instead of #new."
	
	^self basicNew initOnPart: aPart actionKey: anActionKey
]

{ #category : #accessing }
APUseCase >> actionKey [

	^ actionKey
]

{ #category : #accessing }
APUseCase >> actionKey: anObject [

	actionKey := anObject
]

{ #category : #'API Action' }
APUseCase >> afterPerformAction: anActionKey [

	"redefine in subclasses"
]

{ #category : #API }
APUseCase >> assertImplementedAction: actionKey [

	(self class implementedActionKeys includes: actionKey)
		ifFalse: [self aPartError: #unsupportedUseCaseActionKey
							text: 'Missing key ', actionKey asString, ' in: ', self class name, ' class>>#implementedActionKeys'
							attribute: actionKey]
]

{ #category : #'API Action' }
APUseCase >> beforePerformAction: anActionKey [

	"redefine in subclasses"
]

{ #category : #API }
APUseCase >> cloneForExecution [
	"Use cases that refuse to be cloned on execution have to override this by returning self.
	It is always safer to have a unique instance for running a use case action, so this is the default.
	
	We use a use-case clone because one use-case can handle multiple actions (with different enablement state).
	"
	
	^ self class basicNew cloneForExecutionFrom: self
]

{ #category : #private }
APUseCase >> cloneForExecutionFrom: otherUC [
	"This call has to be overwritten in subclasses. Missing super call from there will fail because of actionKey remaining nil."
	
	self initialize.
	actionKey := otherUC actionKey.
	isCloneForExecution := true.
]

{ #category : #API }
APUseCase >> conditionForUseCaseAction [
	"Simple default, will have to be overwritten in subclasses in most cases"
	
	^APCondition true
]

{ #category : #API }
APUseCase >> helpTextForUseCaseAction [
	"Always to be overriden in subclasses"
	
	^'Missing help text for use case action ', 
		actionKey asString, 
		' in class ',
		self class name
]

{ #category : #initialization }
APUseCase >> initOnPart: aPart actionKey: anActionKey [

	part := aPart.
	actionKey := anActionKey.

]

{ #category : #initialization }
APUseCase >> initialize [

	super initialize.
	isCloneForExecution := false.
]

{ #category : #accessing }
APUseCase >> isCloneForExecution [

	^ isCloneForExecution
]

{ #category : #accessing }
APUseCase >> part [

	^ part
]

{ #category : #'API Action' }
APUseCase >> performUseCaseAction [
	"Mind that some callers expect a value returned when action code is run"
	
	self subclassResponsibility
]

{ #category : #'API Action' }
APUseCase >> performUseCaseActionForArgs: args [
	"Mind that some callers expect a value returned when action code is run.
	We dont make this a subclass responsibilty because it will not be needed in most cases
	and try to reroute it if possible."
		
	args isEmpty
		ifTrue: [	^self performUseCaseAction].
	self pdmDeveloperHalt: 'Missing implementation of #performUseCaseActionForArgs: in class ', self class name
]
