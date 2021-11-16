Class {
	#name : #APartInterfaceTest,
	#superclass : #TestCase,
	#instVars : [
		'interface',
		'part',
		'form',
		'client',
		'partWithRedirection',
		'partWithRedirectionToRedirection'
	],
	#category : #'APart PharoTests'
}

{ #category : #utilities }
APartInterfaceTest >> createFormWithRedirection [
	SpBindings
		value: SpStubAdapterBindings
		during: [ | app | 
			app := SpMockApplication new.
			part := APartTestFormPart createWithClientRegistry.
			partWithRedirection := APartTestFormWithRedirection createWithClientRegistry.
			partWithRedirection target: part.
			interface := partWithRedirection partInterface.
			form := (APartTestForm openOnPart: partWithRedirection application: app) presenter.
			client := partWithRedirection clientRegistry findAnyClientForInterface: interface
		]
]

{ #category : #utilities }
APartInterfaceTest >> createFormWithRedirectionToRedirection [
	SpBindings
		value: SpStubAdapterBindings
		during: [ | app | 
			app := SpMockApplication new.
			part := APartTestFormPart createWithClientRegistry.

			partWithRedirection := APartTestFormWithRedirection createWithClientRegistry.
			partWithRedirection target: part.

			partWithRedirectionToRedirection := APartTestFormWithRedirectionToRedirection createWithClientRegistry.
			partWithRedirectionToRedirection target: partWithRedirection.

			interface := partWithRedirectionToRedirection partInterface.
			form := (APartTestForm openOnPart: partWithRedirectionToRedirection application: app) presenter.
			client := partWithRedirectionToRedirection clientRegistry findAnyClientForInterface: interface.
		]
]

{ #category : #running }
APartInterfaceTest >> setUp [
	super setUp.
	SpBindings
		value: SpStubAdapterBindings
		during: [ | app |
			app := SpMockApplication new.
			part := APartTestFormPart createWithClientRegistry.
			interface := part partInterface.
			form := (APartTestForm openOnPart: part application: app) presenter.
			client := part clientRegistry findAnyClientForInterface: interface.
		]
]

{ #category : #tests }
APartInterfaceTest >> testActionForPathIfAbsent [
	
	self createFormWithRedirection.
	
	interface description createAspectNamed: #someAspect redirectTo: #(target firstName).

	(interface description aspectFor: #someAspect ifAbsent: [ nil ]) value: #testingValue.
	
	self assert: (interface description aspectFor: #someAspect ifAbsent: [ nil ]) value equals: #testingValue.
	self assert: part firstName equals: #testingValue.
	
	
	self should: [ 
		interface description createAspectNamed: #someAspect redirectTo: #(redirected value).
	] raise: APAspectRedefinitionError.

 
]

{ #category : #tests }
APartInterfaceTest >> testActionRedirectionToRedirection [

	self createFormWithRedirectionToRedirection.
	
	partWithRedirection partInterface description createAction: #someAction redirectTo: #(target clearFirstName).
	partWithRedirectionToRedirection partInterface description createAction: #someAction redirectTo: #(target someAction).
	
	self assert: partWithRedirectionToRedirection firstName equals: #InitialFirstName.
	self assert: partWithRedirection firstName equals: #InitialFirstName.
	self assert: part firstName equals: #InitialFirstName.
	
	partWithRedirectionToRedirection partInterface execute: #someAction ifDisabled: [ nil ].
	
	self assert: partWithRedirectionToRedirection firstName equals: #InitialFirstName.
	self assert: partWithRedirection firstName equals: #InitialFirstName.
	self assert: part firstName equals: nil.

]

{ #category : #tests }
APartInterfaceTest >> testAllAspectKeysInclude [

	self assert: (interface description allAspectKeysInclude: #firstName).	
	self assert: (interface description allAspectKeysInclude: #lastName).
	self deny: (interface description allAspectKeysInclude: #missingAspect).
]

{ #category : #tests }
APartInterfaceTest >> testAnnounceFocusRequest [

	"smoke test"
	self assert: interface announceFocusRequest equals: interface
]

{ #category : #tests }
APartInterfaceTest >> testAspectNamedAddDependents [
	| aspect firstNameChanged lastNameChanged |
	firstNameChanged := false.
	lastNameChanged := false.
	(part modelForAspect: #firstName)
		onChangeSend: #value
		to: [ firstNameChanged := true ].
	(part modelForAspect: #lastName)
		onChangeSend: #value
		to: [ lastNameChanged := true ].
	aspect := interface description createAspectNamed: #fullName.
	interface aspectNamed: #fullName addDependents: #(firstName lastName).
	aspect value: 'John Doe'.
	self assert: (form presenterNamed: #firstName) text equals: 'John'.
	self assert: (form presenterNamed: #lastName) text equals: 'Doe'.
	self assert: firstNameChanged.
	self assert: lastNameChanged
]

{ #category : #tests }
APartInterfaceTest >> testCreateActionDo [

	| executed |
	
	executed := false.

	interface description createAction: #someAction do: [ executed := true ].
	
	part execute: #someAction ifDisabled: [  ].
	
	self assert: executed.
	
	self should: [ 
		interface description createAction: #someAction do: [ executed := true ].
	] raise: APActionRedefinitionError 
]

{ #category : #tests }
APartInterfaceTest >> testCreateActionRedirectTo [
		
	self createFormWithRedirection.

	interface description createAction: #someAction redirectTo: #(target clearFirstName).
	
	self deny: partWithRedirection firstName isEmptyOrNil.		
	self deny: part firstName isEmptyOrNil.		

	partWithRedirection execute: #someAction ifDisabled: [  ].

	self deny: partWithRedirection firstName isEmptyOrNil.		
	self assert: part firstName isEmptyOrNil.		
			
	self should: [ 
		interface description createAction: #someAction redirectTo: #(redefinition actionExecuted).
	] raise: APActionRedefinitionError.

 
]

{ #category : #tests }
APartInterfaceTest >> testCreateActionRedirectToSelf [
	
	| result |
	
	result := nil.
	
	self createFormWithRedirection.
	
	interface description  createAction: #targetAction do: [ result := 42 ].
		interface description createAction: #someAction redirectTo: #(targetAction).
	
	interface execute: #someAction ifDisabled: [ ].
	
	self assert: result equals: 42.
]

{ #category : #tests }
APartInterfaceTest >> testCreateAspectNamedBuild [

	| buildBlock result |
	
	result := false.
	
	buildBlock := [ :aspectBuilder | result := (aspectBuilder part = part)].
	
	interface createAspectNamed: #someAspect build: buildBlock.
	
	self assert: result.
	
	self should: [ 
		interface createAspectNamed: #someAspect build: buildBlock.
	] raise: APAspectRedefinitionError 
]

{ #category : #tests }
APartInterfaceTest >> testCreateAspectNamedRedirectTo [
	
	self createFormWithRedirection.
	
	interface description createAspectNamed: #someAspect redirectTo: #(target firstName).

	(interface description aspectFor: #someAspect ifAbsent: [ nil ]) value: #testingValue.
	
	self assert: (interface description aspectFor: #someAspect ifAbsent: [ nil ]) value equals: #testingValue.
	self assert: part firstName equals: #testingValue.
 
]

{ #category : #tests }
APartInterfaceTest >> testCreateAspectNamedRedirectToRedefinitionFailure [
	
	self createFormWithRedirection.
	
	interface description createAspectNamed: #someAspect redirectTo: #(target firstName).
	
	self should: [ 
		interface description createAspectNamed: #someAspect redirectTo: #(redirected firstName).
	] raise: APAspectRedefinitionError.

 
]

{ #category : #tests }
APartInterfaceTest >> testCreateAspectNamedUse [

	| adapter |
	
	adapter := APValueAdaptor on: part key: #someAspect.
	
	interface description createAspectNamed: #someAspect use: adapter.
	
	self assert: (interface description aspectFor: #someAspect ifAbsent: [nil]) subAdaptor equals: adapter.
	
	self should: [ 
		interface description createAspectNamed: #someAspect use: adapter.
	] raise: APAspectRedefinitionError 
]

{ #category : #tests }
APartInterfaceTest >> testCreateFormWithRedirection [

	"this tests just proves the initial setup of the tests with redirection"
		
	self createFormWithRedirection.
	
	self deny: part equals: partWithRedirection.
	self assert: interface equals: partWithRedirection partInterface.
	self deny: interface equals: part partInterface.
	self assert: part equals: partWithRedirection target.
	
	self assert: client notNil.

]

{ #category : #tests }
APartInterfaceTest >> testExecuteTrigger [

	| value |
	
	value := nil.
	
	part trigger: #someTrigger do: [ value := 1 ].
	self assert: value isNil.
	
	interface executeTrigger: #someTrigger.
	
	self assert: value equals: 1.

]

{ #category : #tests }
APartInterfaceTest >> testIsActionExecutableIfAbsent [

	| enabled | 
	
	enabled := true.

	interface description
		createAction: #someAction
		do: [ enabled := false ]
		if: (APCondition on: [ enabled ] ifNot: #disabled)
		helpText: #someAction.
		
	self assert: (interface isActionExecutable: #someAction ifAbsent: [ #missing ] ).
	self assert: (interface isActionExecutable: #missingAction ifAbsent: [ #missing ] ) equals: #missing.
	
	interface execute: #someAction ifDisabled: [].

	self deny: (interface isActionExecutable: #someAction ifAbsent: [ #missing ] ).
	
	self assert: (interface reasonForActionNotExecutable: #someAction ifAbsent: [ #missing ]) equals: #disabled
]

{ #category : #tests }
APartInterfaceTest >> testLocalAspectKeys [

	self assertCollection: interface description localAspectKeys hasSameElements: #(firstName lastName)
]

{ #category : #tests }
APartInterfaceTest >> testNotifications [
	
	| result |
	
	result := 0.
		
	form client onNotification: #someNotification  do: [ result := 1 ].
		
	part sendNotification: #someNotification.
	
	self assert: result equals: 1.
	
]

{ #category : #tests }
APartInterfaceTest >> testNotificationsSeveralTimes [
	
	| result |
	
	result := 0.
		
	form client onNotification: #someNotification  do: [ result := result + 1 ].
	form client onNotification: #someNotification  do: [ result := result + 3 ].
	form client onNotification: #someNotification  do: [ result := result + 7 ].
		
	part sendNotification: #someNotification.
	
	self assert: result equals: 11.
	
]

{ #category : #tests }
APartInterfaceTest >> testNotificationsWithArgument [
	
	| result |
	
	result := 0.
		
	form client onNotification: #someNotification  do: [ :arg | result := arg ].
		
	part sendNotification: #someNotification with: 4.
	
	self assert: result equals: 4.
	
]

{ #category : #tests }
APartInterfaceTest >> testNotificationsWithManyArguments [
	
	| result |
	
	result := 0.
		
	form client onNotification: #someNotification  do: [ :arg :arg2 :arg3  | result := arg + arg2 + arg3 ].
		
	part sendNotification: #someNotification withArguments: #(1 2 3).
	
	self assert: result equals: 6.
	
]

{ #category : #tests }
APartInterfaceTest >> testNotificationsWithTwoArguments [
	
	| result |
	
	result := 0.
		
	form client onNotification: #someNotification  do: [ :arg :arg2 | result := arg + arg2 ].
		
	part sendNotification: #someNotification with: 4 with: 5.
	
	self assert: result equals: 9.
	
]

{ #category : #tests }
APartInterfaceTest >> testNotificationsWithoutSubscription [
	
	| result |
	
	result := 0.
			
	part sendNotification: #someNotification.
	
	self assert: result equals: 0.
	
]

{ #category : #tests }
APartInterfaceTest >> testPartChannel [

	| subpart |
	
	subpart := APart onPart: part key: #subpart. 

	interface usePartChannel.
	
	self assert: interface subjectChannelForAspects isValueHolder.
	
	self assert: interface subjectChannelForAspects value equals: part.
	
	interface changeSubject: subpart.
	
	self assert: interface subjectChannelForAspects value equals: subpart.

]

{ #category : #tests }
APartInterfaceTest >> testRecursionForAction [
	
	self createFormWithRedirection.

	self should: [ interface description  createAction: #someAction do: [ 
		partWithRedirection execute: #someAction ifDisabled: [  ] ].
 		partWithRedirection execute: #someAction ifDisabled: [  ].
	] raise:  APActionRecursionError
]

{ #category : #tests }
APartInterfaceTest >> testRedirectExistingActionThatDoesNotExist [

	self createFormWithRedirection.
	
	self should: [ 
		partWithRedirection partInterface redirectExistingAction: #someAction to: #(target clearFirstName).
	] raise: APMissingActionError.

]

{ #category : #tests }
APartInterfaceTest >> testRedirectExistingActionTo [

	| result | 
	
	result := nil.
	
	self createFormWithRedirection.

	partWithRedirection partInterface description createAction: #someAction do: [ result := 42 ].
	
	partWithRedirection partInterface redirectExistingAction: #someAction to: #(target clearFirstName).
	
	self assert: result equals: nil.
	self deny: part firstName equals: nil.
	
	partWithRedirection partInterface execute: #someAction ifDisabled: [  ].
	
	self assert: result equals: nil.
	self assert: part firstName equals: nil.
	 
	
]

{ #category : #tests }
APartInterfaceTest >> testRedirectExistingAspectThatDoesNotExist [

	self createFormWithRedirection.
	
	self should: [ 
		partWithRedirection partInterface redirectExistingAspect: #someAspect to: #(target clearFirstName).
	] raise: APMissingAspectKeyError.

]

{ #category : #tests }
APartInterfaceTest >> testRedirectExistingAspectTo [

	| result | 
	
	result := nil.
	
	self createFormWithRedirection.

	partWithRedirection partInterface description createAspectNamed: #someAspect.
	
	(part partInterface description aspectFor: #firstName ifAbsent: []) value: #PartFirstName.
	(partWithRedirection partInterface description aspectFor: #firstName ifAbsent: []) value: #PartWithRedirectionFirstName.
	
	partWithRedirection partInterface redirectExistingAspect: #someAspect to: #(target firstName).
		
	(partWithRedirection partInterface description aspectFor: #someAspect ifAbsent: []) value: #NewFirstName.
	
	self assert: partWithRedirection firstName equals: #PartWithRedirectionFirstName.
	self assert: part firstName equals: #NewFirstName.
	 
	
]

{ #category : #tests }
APartInterfaceTest >> testRedirectedInterfaces [

	| targetPart | 
	
	targetPart := APart createWithClientRegistry.
	targetPart partInterface description createAspectNamed: #yourself. 
	part firstName: targetPart. 
	self assert: interface redirectedInterfaces isEmpty.
	
	interface description createAspectNamed: #redirectedAspect redirectTo: #(firstName yourself).
	self assertCollection: interface redirectedInterfaces hasSameElements: { targetPart partInterface }.

]

{ #category : #tests }
APartInterfaceTest >> testRedirectionToRedirection [
		
	self createFormWithRedirectionToRedirection.
	
	partWithRedirection partInterface description createAspectNamed: #someAspect redirectTo: #(target firstName).
	partWithRedirectionToRedirection partInterface description createAspectNamed: #someAspect redirectTo: #(target someAspect).
	
	self assert: (interface description aspectFor: #someAspect ifAbsent: [ nil ]) value equals: #InitialFirstName.
	
	self assert: interface == partWithRedirectionToRedirection partInterface.

	(interface description aspectFor: #someAspect ifAbsent: [ nil ]) value: #NewFirstName.
	self assert: (interface description aspectFor: #someAspect ifAbsent: [ nil ]) value equals: #NewFirstName.
	
	self assert: partWithRedirectionToRedirection firstName equals: #InitialFirstName.
	self assert: partWithRedirection firstName equals: #InitialFirstName.
	self assert: part firstName equals: #NewFirstName.

]

{ #category : #tests }
APartInterfaceTest >> testSubinterfaceAtPath [

	| subpart subpart2 result | 
		
	subpart := APart onPart: part key: #subpart1.
	subpart2 := APart onPart: subpart key: #subpart2.

	result := interface subInterfaceAtPath: ''.
	self assert: result equals: interface.
	
	result := interface subInterfaceAtPath: #(subpart1).	
	self assert: result equals: subpart partInterface.

	result := interface subInterfaceAtPath: #(subpart1 subpart2).	
	self assert: result equals: subpart2 partInterface.
		

]

{ #category : #tests }
APartInterfaceTest >> testSubjectForAspects [
	
	self assert: interface subjectForAspects equals: part.
	
	
]

{ #category : #tests }
APartInterfaceTest >> testUtility [

	| utility |
	
	utility := Object new.
	
	interface utilityAt: #translator put: utility.
	self assert: (interface utilityAt: #translator) equals: utility.
	self assert: (interface utilityAt: #missingUtility) isNil.
	self assert: (interface utilityAt: #missingUtility ifAbsent: [ self ]) equals: self.
	interface utilityAt: #missingUtility ifAbsentPut: self.
	self assert: (interface utilityAt: #missingUtility) equals: self.
	
]

{ #category : #tests }
APartInterfaceTest >> testWithParentInterfaces [ 

	| subpart |

	subpart := APart onPart: part key: #subpart.
	
	self assertCollection: subpart partInterface withParentInterfaces hasSameElements: { subpart partInterface. interface }
]
