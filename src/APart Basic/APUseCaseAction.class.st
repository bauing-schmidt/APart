"
If an action is not defined by a part directly, but logically belongs to a certain use case, it makes sense to associate the action with the use case instance directly:
* The same use case instance can run the action for a certain key as well as it defines the condition for the enablement of the same action.
* As the use case typically directly implements the action functionality, it does not make sense to define a code block.
* The use case instance has the same life time as the action(s) it is associated with.

To support use case classes that implement several (typically small) actions, the action is not forwarded generically to the use case by #perform:. However, APUseCaseAction defines the following API for associated use cases:

* performUseCaseActionFor: aKey
* conditionForUseCaseAction: aKey

If an action is callable with an argument, the API for calling the use case is:

* performUseCaseActionFor: aKey with: anArgument

Instance creation API is always #key:useCase:. So creating an APUseCaseAction from within a use case is done by calling the basic use case utility:

* self createAction: anActionKey forPart: aPart

This call internally creates the action instance in the interface description of the passed part and connects it with there receiver use case.
"
Class {
	#name : #APUseCaseAction,
	#superclass : #APExecutableWithCondition,
	#instVars : [
		'useCase'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #'instance creation' }
APUseCaseAction class >> key: actionKey useCase: aUseCase [
	"Do not pass condition here, it will be fetched (along with helpText) from the use case during #initOn:useCase:"
	
	^self basicNew 
		initOn: actionKey useCase: aUseCase
]

{ #category : #API }
APUseCaseAction >> executeWith: args [

	| ucClone ucResult |
	useCase beforePerformAction: key.
	ucClone := useCase cloneForExecution.
	ucResult := args isEmpty
		ifTrue: [	ucClone performUseCaseAction]
		ifFalse: [ucClone performUseCaseActionForArgs: args].
	ucClone afterPerformAction: key.
	^ucResult
	 
]

{ #category : #'initialize-release' }
APUseCaseAction >> initOn: actionKey useCase: aUseCase [

	self initialize.
	key := actionKey.
	useCase := aUseCase.
	useCase assertImplementedAction: key.
	self setStatefulConditionOn: aUseCase conditionForUseCaseAction.
	helpText := useCase helpTextForUseCaseAction.
]

{ #category : #API }
APUseCaseAction >> isRawAction [

	^ true
]

{ #category : #accessing }
APUseCaseAction >> useCase [

	^ useCase
]
