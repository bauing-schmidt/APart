Class {
	#name : #APartTestAPart,
	#superclass : #TestCase,
	#instVars : [
		'part',
		'subpart1',
		'subpart2'
	],
	#category : #'APart PharoTests'
}

{ #category : #running }
APartTestAPart >> addSubparts [

	subpart1 := APart onPart: part key: #subpart1.
	subpart2 := APart onPart: part key: #subpart2.

]

{ #category : #running }
APartTestAPart >> setUp [

	super setUp.
	
	part := APartTestForm createRootPart. 
]

{ #category : #running }
APartTestAPart >> testAddNamedCondition [

	| condition |
	
	condition := APCondition named: #aCondition on: [ true ] ifNot: #ConditionReason.
		
	part addNamedCondition: condition.

	self assert: (part setterConditionFor: #aCondition) equals: condition.

]

{ #category : #running }
APartTestAPart >> testAddNamedConditions [

	| condition1 condition2 |
	
	condition1 := APCondition named: #aCondition1 on: [ true ] ifNot: #ConditionReason.
	condition2 := APCondition named: #aCondition2 on: [ true ] ifNot: #ConditionReason.
		
	part addNamedConditions: { condition1. condition2 }.

	self assert: (part setterConditionFor: #aCondition1) equals: condition1.
	self assert: (part setterConditionFor: #aCondition2) equals: condition2.

]

{ #category : #running }
APartTestAPart >> testAddSubPartKey [
	
	self assert: part subPartCount equals: 0.
	
	"subparts should not be created this way. Here only for testing purposes"
	subpart1 := APart createWithClientRegistry.
	part addSubPart: subpart1 key: #subpart1.
	
	self assert: part subPartCount equals: 1.
	self assert: (part subPartAt: #subpart1 ifNone: [ nil ]) notNil.
]

{ #category : #running }
APartTestAPart >> testAnnouncer [ 

	self assert: part announcer equals: part partInterface
]

{ #category : #running }
APartTestAPart >> testAtAllPutCondition [

	| condition1 |
	
	condition1 := APCondition named: #aCondition1 on: [ true ] ifNot: #ConditionReason.
		
	part atAll: #(key1 key2) putCondition: condition1.
	
	self assert: condition1 name equals: 'key1 key2'.

	self assert: (part setterConditionFor: #key1) equals: condition1.
	self assert: (part setterConditionFor: #key2) equals: condition1.

]

{ #category : #running }
APartTestAPart >> testAtValidate [
		
	part at: #firstName validate: [ :newValue | newValue = #John ].
	part at: #lastName validate: [ :newValue | newValue = #Doe ].
	
	self deny: ((part modelForAspect: #firstName) validate: #Jane).	
	self assert: ((part modelForAspect: #lastName) validate: #Doe).
]

{ #category : #running }
APartTestAPart >> testChangedAllAspectValues [
		
	| firstNameChanged lastNameChanged |	
		
	firstNameChanged := false.
	lastNameChanged := false.

	(part modelForAspect: #firstName) onChangeSend: #value to: [ firstNameChanged := true  ].
	(part modelForAspect: #lastName) onChangeSend: #value to: [ lastNameChanged := true  ].
	
	part changedAllAspectValues.

	self assert: firstNameChanged.
	self assert: lastNameChanged.
]

{ #category : #running }
APartTestAPart >> testChangedAspectValues [
		
	| firstNameChanged lastNameChanged |	
		
	firstNameChanged := false.
	lastNameChanged := false.

	(part modelForAspect: #firstName) onChangeSend: #value to: [ firstNameChanged := true  ].
	(part modelForAspect: #lastName) onChangeSend: #value to: [ lastNameChanged := true  ].
	
	self deny: firstNameChanged.
	self deny: lastNameChanged.
	
	part changedAspectValues: #(firstName).

	self assert: firstNameChanged.
	self deny: lastNameChanged.
]

{ #category : #running }
APartTestAPart >> testChangedAspectValuesSuppressListeners [
		
	| firstNameChanged lastNameChanged client |	
		
	firstNameChanged := false.
	lastNameChanged := false.
	
	client := APartRecordingSequenceClient on: part partInterface.

	(part modelForAspect: #firstName) onChangeSend: #value to: [ firstNameChanged := true  ].
	(part modelForAspect: #lastName) onChangeSend: #value to: [ lastNameChanged := true  ].
	
	self deny: firstNameChanged.
	self deny: lastNameChanged.
	
	client isRecording: true.

	part changedAspectValues: #(firstName) suppressListeners: true.
	
	self assert: client allLastInteractions isEmpty
]

{ #category : #running }
APartTestAPart >> testChangedAspectValuesSuppressListenersDisabled [
		
	| firstNameChanged lastNameChanged client |	
		
	firstNameChanged := false.
	lastNameChanged := false.
	
	client := APartRecordingSequenceClient on: part partInterface.

	(part modelForAspect: #firstName) onChangeSend: #value to: [ firstNameChanged := true  ].
	(part modelForAspect: #lastName) onChangeSend: #value to: [ lastNameChanged := true  ].
	
	self deny: firstNameChanged.
	self deny: lastNameChanged.
	
	client isRecording: true.

	part changedAspectValues: #(firstName) suppressListeners: false.
	
	self assert: client allLastInteractions size equals: 1.
	self assert: client allLastInteractions first key equals: #firstName.
	
]

{ #category : #running }
APartTestAPart >> testClinetConfiguration [
		
	| configuration recordingClient |
	
	configuration := Object new. "stub"	
			
	recordingClient := APartRecordingSequenceClient on: part partInterface.	
	recordingClient isRecording: true.
	
	part clientConfiguration: configuration.
	
	self assert: part clientConfiguration equals: configuration.
	self assert: recordingClient allLastInteractions first key equals: #clientConfiguration.
	
]

{ #category : #running }
APartTestAPart >> testConditionChainFromSelectorOrArray [

	| chain |

	chain := part conditionChainFromSelectorOrArray: #conditionActive.
	self deny: chain isConditionChain.

	chain := part conditionChainFromSelectorOrArray: #(conditionActive conditionActive2).
	self assert: chain isConditionChain.
	
	chain := part conditionChainFromSelectorOrArray: #(conditionActive).
	self deny: chain isConditionChain
]

{ #category : #running }
APartTestAPart >> testConditionFromSelector [

	| condition |
	
	condition := part conditionFromSelector: #conditionActive.
	
	self assert: condition name equals: #conditionActive1.
	
	self should: [ 
		condition := part conditionFromSelector: #yourself.
	] raise: APConditionExpectedError
]

{ #category : #running }
APartTestAPart >> testConditionNameAssignment [

	| condition |
	
	condition := APCondition on: [ true ] ifNot: #ConditionReason.
	
	self assert: condition name isNil.
	
	part at: #True putCondition: condition.

	self assert: condition name equals: #True.

]

{ #category : #running }
APartTestAPart >> testConditionsRedefinitionError [

	| condition |
	
	condition := APCondition true.
	
	part at: #True putCondition: condition.

	self should: [ 
		part at: #True putCondition: condition.
		] raise: APConditionRedefinitionError

]

{ #category : #running }
APartTestAPart >> testDisableAllAspects [
	
	part := APartTestForm createRootPart.
	
	self assert: (part setterConditionFor: #firstName) booleanValue.	
	self assert: (part setterConditionFor: #lastName) booleanValue.
	
	part disableAllAspects: #(firstName lastName).
	
	self deny: (part setterConditionFor: #firstName) booleanValue.	
	self deny: (part setterConditionFor: #lastName) booleanValue.
]

{ #category : #running }
APartTestAPart >> testDisableAllAspectsTwice [
	
	part := APartTestForm createRootPart.
	
	part disableAllAspects: #(firstName lastName).

	self should: [ 
			part disableAllAspects: #(firstName lastName).
	] raise: APConditionRedefinitionError
]

{ #category : #running }
APartTestAPart >> testExecuteIfDisabled [

	| message |
	
	message := nil. 
	
	self assert: part firstName equals: 'InitialFirstName'.
	part execute: #clearFirstName ifDisabled: [ message := #disabled ].
	self assert: part firstName isNil.
	self assert: message isNil.


	
]

{ #category : #running }
APartTestAPart >> testExecuteIfDisabledWhenDisabled [

	| message |
	
	message := nil. 
	
	part firstName: ''. "set value that does not fit the state condition"
	part partInterface updateCondition.
	part execute: #clearFirstName ifDisabled: [ :reason | message := reason ].
	self deny: part firstName isNil.
	self assert: message equals: #FieldIsEmpty.
	
]

{ #category : #running }
APartTestAPart >> testExecuteTrigger [

	| value |
	
	value := nil.
	
	part trigger: #someTrigger do: [ value := 1 ].
	self assert: value isNil.
	
	part executeTrigger: #someTrigger.
	
	self assert: value equals: 1.

]

{ #category : #running }
APartTestAPart >> testExecuteTriggerIfAbsent [

	| value message |
	
	value := 0.
	message := nil.
	
	part trigger: #someTrigger do: [ value := value + 1 ].
	self assert: value equals: 0.
	
	part executeTrigger: #someTrigger ifAbsent: [ message := #missing ].
	
	self assert: value equals: 1.
	self assert: message isNil.

	part executeTrigger: #someMissingTrigger ifAbsent: [ message := #missing ].
	
	self assert: value equals: 1.
	self assert: message equals: #missing.

]

{ #category : #running }
APartTestAPart >> testExecuteTriggerWith [

	| value |
	
	value := 0.
	
	part trigger: #someTrigger withArgumentDo: [ :arg | value := value + arg ].
	self assert: value equals: 0.
	
	part executeTrigger: #someTrigger with: 2.
	
	self assert: value equals: 2.

]

{ #category : #running }
APartTestAPart >> testExecuteWith [

	| arg |
	
	part := APartTestFormPartWithArgumentAction createWithClientRegistry. 	
	
	arg := { 1 }.
	
	self assert: part firstName equals: 'InitialFirstName'.
	part execute: #actionWithArgument with: arg.
	self assert: arg first equals: 2.

	
]

{ #category : #running }
APartTestAPart >> testExecuteWithIfDisabled [

	| arg message |
	
	part := APartTestFormPartWithArgumentAction createWithClientRegistry. 	

	arg := { 1 }.	
	message := nil. 

	self assert: part firstName equals: 'InitialFirstName'.
	part execute: #actionWithArgument with: arg.
	self assert: arg first equals: 2.
	self assert: message isNil.


	
]

{ #category : #running }
APartTestAPart >> testExecuteWithIfDisabledWhenDisabled [

	| arg message |
	
	part := APartTestFormPartWithArgumentAction createWithClientRegistry. 	

	arg := { 1 }.	
	message := nil. 

	part firstName: ''. "set value that does not fit the state condition"
	part partInterface updateCondition.
	part execute: #actionWithArgument with: arg ifDisabled: [ :reason | message := reason ].
	self assert: arg first equals: 1.
	self assert: message equals: #FieldIsEmpty.


	
]

{ #category : #running }
APartTestAPart >> testFindClientClassForOpeningException [
	"test the default behavior: raising of an exception"
	self should: [ 
		part findClientClassForOpening
	] raise: APCouldNotFindClientForOpeningError
]

{ #category : #running }
APartTestAPart >> testIsChildPartOf [

	| part1 part2 part3 |
		
	part1 := APart createWithClientRegistry.
	part2 := APart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.
	
	self assert: (part2 isChildPartOf: part1).	
	self assert: (part3 isChildPartOf: part2).
	self deny: (part3 isChildPartOf: part1).
]

{ #category : #running }
APartTestAPart >> testIsInitialized [

	self assert: part isInitialized.
	part release.	
	self deny: part isInitialized.
	
]

{ #category : #running }
APartTestAPart >> testIsPart [ 

	self assert: part isPart.
	self deny: nil isPart.
	self deny: 42 isPart.
]

{ #category : #running }
APartTestAPart >> testIsProptable [

	self deny: APart createWithClientRegistry isPromptable. "default behavior"
	
	self assert: part isPromptable.

]

{ #category : #running }
APartTestAPart >> testIsSimplePropot [

	self deny: part isSimplePrompt
]

{ #category : #running }
APartTestAPart >> testKey [

	self addSubparts.
	
	self assert: part key isNil.
	self assert: subpart1 key equals: #subpart1.
	self assert: subpart2 key equals: #subpart2.
	
]

{ #category : #running }
APartTestAPart >> testLogException [
	"testDefault behavior - just let the exception pass"

	self addSubparts.
	
	self should: [ 
		subpart1 logException: Notification new.
	] raise: Notification.

	self assertCollection: part exceptions hasSameElements: { Notification }

]

{ #category : #running }
APartTestAPart >> testModelForAspect [
	
	| aValueAdaptor |
	part := APartTestForm createRootPart.
	
	aValueAdaptor := part modelForAspect: #firstName.
	self assert: aValueAdaptor subject equals: part.
	self assert: aValueAdaptor aspectKey equals: #firstName.
]

{ #category : #running }
APartTestAPart >> testModelForAspectFailure [
		
	self should: [ 
		part modelForAspect: #undefinedAspect
	] raise: APMissingAspectKeyError.
]

{ #category : #running }
APartTestAPart >> testOnPart [

	| part1 part2 |
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1.
	
	self assert: (part1 subPartAt: #APartTestFormPart ifNone: [ nil ]) equals: part2.
]

{ #category : #running }
APartTestAPart >> testOnPartKeyCondition [

	| part1 part2 |
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #subpart condition: APCondition false.
	
	self assert: (part1 subPartAt: #subpart ifNone: [ nil ]) equals: part2.
	self deny: (part1 setterConditionFor: #subpart) booleanValue 
]

{ #category : #running }
APartTestAPart >> testOnPartKeyPostInit [

	| part1 part2 executed |
	
	executed := false.
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #subpart postInit: [ :aPart | 
		"the part is still being initialized"
		self assert: aPart isInitializing.
		self deny: aPart partInterface isNil.
		executed := true ].
	
	self assert: executed. 
	self assert: part2 parentPart equals: part1.
]

{ #category : #running }
APartTestAPart >> testOnPartKeyPreInit [

	| part1 part2 executed |
	
	executed := false.
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #subpart preInit: [ :aPart | 
		"check if the part is not initialized"
		self assert: aPart partInterface isNil.
		executed := true ].
	
	self assert: executed. 
	self assert: part2 parentPart equals: part1.
]

{ #category : #running }
APartTestAPart >> testOpenClientPrompt [

	"smoke test"
	| parentPart app |
		
			"prompts require to be opened on a part with an active client, if we want to use the non-default Spec application with headless output"

	app := SpMockApplication new.
	parentPart := APxEnablementExamplePart createWithClientRegistry.
	APxEnablementExample openOnPart: parentPart application: app.
			
	part := (APWarningPrompt onPart: parentPart)
			title: #WarningTitle;
			message: #WarningText.

	self shouldnt: [part openClientPrompt ] raise: Error 

]

{ #category : #running }
APartTestAPart >> testOpenClientsForPart [
	
	SpBindings value: SpStubAdapterBindings during: [ 
		| windows |
		windows := part openClient.
		self assert: ((part clientRegistry findClientsForInterface: part partInterface) size = 1).
		windows do: [ :each | each close ]
	]

]

{ #category : #running }
APartTestAPart >> testOpenPromptOnSelf [ 

	| parentPart app |
		
			"prompts require to be opened on a part with an active client, if we want to use the non-default Spec application with headless output"

	app := SpMockApplication new.
	parentPart := APxEnablementExamplePart createWithClientRegistry.
	APxEnablementExample openOnPart: parentPart application: app.
			
	part := (APWarningPrompt onPart: parentPart)
			title: #WarningTitle;
			message: #WarningText.

	self shouldnt: [part openClientPromptOnSelf ] raise: Error 

]

{ #category : #running }
APartTestAPart >> testParentInterface [

	| part1 part2 part3 |
	
	part1 := APart createWithClientRegistry.
	part2 := APart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.
	
	self assert: part2 parentInterface equals: part1 partInterface.
	self assert: part3 parentInterface equals: part2 partInterface.

]

{ #category : #running }
APartTestAPart >> testPartConditionReasonAlong [

	| part1 part2 part3 values |
	
	values := { true. true. true }.
	
	part1 := APart createWithClientRegistry.
	part2 := APart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.
	
	part1 addNamedCondition: (APCondition named: #condtion1 on: [ values first ] ifNot: #Reason1). 
	part2 addNamedCondition: (APCondition named: #condtion2 on: [ values second ] ifNot: #Reason2). 
	part3 addNamedCondition: (APCondition named: #condtion3 on: [ values third ] ifNot: #Reason3). 
	
	self assert: (part1 partConditionReasonAlong: #(#part2 #part3)) isNil.
	values at: 3 put: false.
	self assert: (part1 partConditionReasonAlong: #(#part2 #part3)) isNil.

]

{ #category : #running }
APartTestAPart >> testPartConditionReasonAlongWithNamedCondition [
	"named conditions are ignored"

	| part1 part2 part3 values |
	
	values := { true. true. true }.
	
	part1 := APart createWithClientRegistry.
	part2 := APart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.
	
	part1 setStatefulConditionOn: (APCondition on: [ values first ] ifNot: #Reason1). 
	part2 setStatefulConditionOn: (APCondition on: [ values second ] ifNot: #Reason2). 
	part3 setStatefulConditionOn: (APCondition on: [ values third ] ifNot: #Reason3). 
	
	self assert: (part1 partConditionReasonAlong: #(#part2 #part3)) isNil.

	values at: 3 put: false.
	"condition update is needed"
	part3 updateCondition.
	self assert: (part1 partConditionReasonAlong: #(#part2 #part3)) equals: #Reason3.

	values at: 2 put: false.
	part2 updateCondition.
	self assert: (part1 partConditionReasonAlong: #(#part2 #part3)) equals: #Reason2.

	values at: 1 put: false.
	part1 updateCondition.
	self assert: (part1 partConditionReasonAlong: #(#part2 #part3)) equals: #Reason1.


]

{ #category : #running }
APartTestAPart >> testPathFromRootPart [

	| part1 part2 part3 |
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.

	self assertCollection: (part2 pathFromRootPart: part1) asArray equals: #(#part2).
	self assertCollection: (part3 pathFromRootPart: part1) asArray equals: #(part2 part3).
]

{ #category : #running }
APartTestAPart >> testPromptClosingTriggerKey [

	self assert: part promptClosingTriggerKey equals: #complexPromptClosed
]

{ #category : #running }
APartTestAPart >> testPromptSelector [

	self assert: part promptSelector equals: #openModal:
]

{ #category : #running }
APartTestAPart >> testRemoveSubPartForKey [
	"this test does not check all consequences of the subpart removal"

	self addSubparts.
	
	part removeSubPartForKey: #subpart1.
	
	self assert: part subPartCount equals: 1
	
	
]

{ #category : #running }
APartTestAPart >> testResult [ 

	self assert: part result isNil
]

{ #category : #running }
APartTestAPart >> testRootPart [

	| part1 part2 part3 |
	
	part1 := APart createWithClientRegistry.
	part2 := APart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.
	
	self assert: part1 rootPart equals: part1.
	self assert: part2 rootPart equals: part1.
	self assert: part3 rootPart equals: part1.
]

{ #category : #running }
APartTestAPart >> testRootUpdate [

	| message |
	
	message := nil. 
	
	part firstName: ''. "set value that does not fit the state condition"
	part rootUpdate.
	part execute: #clearFirstName ifDisabled: [ :reason | message := reason ].
	self deny: part firstName isNil.
	self assert: message equals: #FieldIsEmpty.
	
]

{ #category : #running }
APartTestAPart >> testRootUpdateFromSubpart [

	| message |
	
	message := nil. 

	self addSubparts.
	
	part firstName: ''. "set value that does not fit the state condition"
	part rootUpdate.
	part execute: #clearFirstName ifDisabled: [ :reason | message := reason ].
	self deny: part firstName isNil.
	self assert: message equals: #FieldIsEmpty.
	
]

{ #category : #running }
APartTestAPart >> testSetterFor [


	self assert: (APart setterFor: #msg) equals: #msg:.
	self assert: (APart setterFor: #msg:) equals: #msg:.
]

{ #category : #running }
APartTestAPart >> testShallLiveWithoutClients [

	self deny: part shallLiveWithoutClients 
]

{ #category : #running }
APartTestAPart >> testStatefulConditionOn [

	| condition value |
	
	value := 5.
	
	condition := APCondition on: [ value < 10 ] ifNot: #MoreThanTen.
	part setStatefulConditionOn: condition.
	
	self assert: (part statefulCondition condition) equals: condition.
		
	self assert: part isActive.
	self deny: part isChanged.
	
	value := 10.
	"nothing will change without explicit update"
	self assert: part isActive.
	self deny: part isChanged.
	
	part updateCondition.
	self deny: part isActive.
	self assert: part isChanged.
	self assert: part reasonForInactivity equals: #MoreThanTen.
	
	
	

]

{ #category : #running }
APartTestAPart >> testSubPartsAnySatisfy [

	| part1 part2 part3 |
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.

	self assert: (part1 subPartsAnySatisfy: [ :aPart | aPart subPartCount = 1 ]).
	self assert: (part2 subPartsAnySatisfy: [ :aPart | aPart subPartCount = 0 ]).
	self deny: (part3 subPartsAnySatisfy: [ :aPart | aPart subPartCount = 0 ]).

]

{ #category : #running }
APartTestAPart >> testSubPartsOfKind [

	| part1 part2 part3 |
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.

	self assertCollection: (part1 subPartsOfKind: APartTestFormPart) hasSameElements: { part2 }.
	self assert: (part2 subPartsOfKind: APartTestFormPart) isEmpty.
	self assertCollection: (part2 subPartsOfKind: APart) hasSameElements: { part3 }.
	self assert: (part3 subPartsOfKind: APartTestFormPart) isEmpty.
]

{ #category : #running }
APartTestAPart >> testSubPartsOfKindDo [
	| part1 part2 part3 part4 result |
	
	result := OrderedCollection new.
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #part2.	
	part3 := APartTestFormPart onPart: part2 key: #part3.
	part4 := APart onPart: part1 key: #part4.

	part1 subPartsOfKind: APartTestFormPart do: [ :aPart | result add: aPart ].
	
	self assertCollection: result asArray hasSameElements: { part2 } 

]

{ #category : #running }
APartTestAPart >> testSubPartsRecursivelyDo [

	| part1 part2 part3 part4 result |
	
	result := OrderedCollection new.
	
	part1 := APart createWithClientRegistry.
	part2 := APartTestFormPart onPart: part1 key: #part2.	
	part3 := APart onPart: part2 key: #part3.
	part4 := APart onPart: part1 key: #part4.

	part1 subPartsRecursivelyDo: [ :aPart | result add: aPart ].
	
	self assertCollection: result asArray hasSameElements: { part2. part3. part4 } 

]

{ #category : #running }
APartTestAPart >> testSubpartAlreadyExists [
	
	| subpart |

	self addSubparts.
	self should: [ 
		subpart := APart onPart: part key: #subpart1.
		subpart yourself "just to use the temporary variable"
	 ] raise: APSubpartAlreadyExistsError.
]

{ #category : #running }
APartTestAPart >> testSubparts [

	self addSubparts.
	
	self assert: part subPartCount equals: 2
]

{ #category : #running }
APartTestAPart >> testTriggerWithPartDo [

	| value |
		
	self addSubparts.
	
	subpart1 trigger: #someTrigger withPartDo: [ :aPart | value := aPart ].
	self assert: value isNil.
	
	subpart1 executeTrigger: #someTrigger.	
	self assert: value equals: subpart1.
]

{ #category : #running }
APartTestAPart >> testTriggerWithPartDoInParent [
	"the trigger:withPartDo: must be set for parts that are subparts"

	| error |
	
	[ 
		part trigger: #someTrigger withPartDo: [ :aPart | aPart yourself ].
	] onErrorDo: [ :anError | error := anError ].

	self assert: error notNil.
	self assert: (error messageText endsWith: 'Action will need parentPart at execution time').
]

{ #category : #running }
APartTestAPart >> testUniqueSubPartKeyStartingWith [

	| key1 key2 subpart |
	
	subpart := APart onPart: part key: #subpart.
	subpart2 := APart onPart: part key: #subpart1.
	
	key1 := part uniqueSubPartKeyStartingWith: 'temp'.
	key2 := part uniqueSubPartKeyStartingWith: 'subpart'.
	
	self assert: key1  equals: 'temp'.
	self assert: key2  equals: 'subpart2'.

]

{ #category : #running }
APartTestAPart >> testWhenClosingDo [

	| activated form |
	
	activated := false.
	part := APart createWithClientRegistry.
	
	self flag: #todo. "this test runs in UI!"
	
	part := APartTestForm createRootPart.
	form := (APartTestForm openOnPart: part) presenter.
	part whenClosingDo: [ activated := true. ].
	part partInterface requestForPartClose.
	
	self assert: activated
]

{ #category : #running }
APartTestAPart >> testWithAllSubparts [ 

	| part2 part3 part4 |

	self assertCollection: part withAllSubparts hasSameElements: { part }.
	
	part2 := APartTestFormPart onPart: part key: #subpart1.

	self assertCollection: part withAllSubparts hasSameElements: { part. part2 }.
	
	part3 := APartTestFormPart onPart: part key:  #subpart2.

	self assertCollection: part withAllSubparts hasSameElements: { part. part2. part3 }.

	part4 := APartTestFormPart onPart: part2 key: #subpart1.

	self assertCollection: part withAllSubparts hasSameElements: { part. part2. part3. part4 }.

]

{ #category : #running }
APartTestAPart >> testconditionChainFromSelectors [

	| chain |

	chain := part conditionChainFromSelectors: #(conditionActive conditionActive2).
	self assert: chain isConditionChain.
	
	chain := part conditionChainFromSelectors: #(conditionActive).
	self deny: chain isConditionChain
]
