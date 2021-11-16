Class {
	#name : #APartDescriptionTest,
	#superclass : #TestCase,
	#instVars : [
		'part',
		'description',
		'actionPerformed'
	],
	#category : #'APart PharoTests'
}

{ #category : #support }
APartDescriptionTest >> performAction [ 

	actionPerformed := true
]

{ #category : #running }
APartDescriptionTest >> setUp [ 

	super setUp. 
	
	part := APartDescriptionTestPart createWithClientRegistry.
	description := part partInterface description.
	actionPerformed := false.

]

{ #category : #'tests - actions' }
APartDescriptionTest >> testActionAtIfAbsent [
			
	| anAction expected |
	
	expected := false.
	
	description actionAt: #someAction ifAbsent: [ expected := true ].
	
	self assert: expected.
	expected := false.
	
	description createAction: #someAction do: [ self performAction ].
	anAction := description actionAt: #someAction ifAbsent: [ expected := true ].
	
	self deny: expected.
	self assert: anAction key equals: #someAction.

	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testActionAtIfPresent [
			
	| anAction anAction2 expected |
	
	expected := false.
	
	description actionAt: #someAction ifPresent: [ expected := true ].
	
	self deny: expected.
	
	anAction := description createAction: #someAction do: [ self performAction ].
	anAction2 := description actionAt: #someAction ifPresent: [ expected := anAction ].
	
	self assert: anAction identicalTo: expected.
	self assert: anAction identicalTo: anAction2.
		
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testActionKinds [
			
	|  rawAction rawAction2 triggerAction triggerAction2 redirectedAction redirectedAction2 actionFromPath actionFromPath2 |

	self assert: description actionsRaw isEmpty.
	self assert: description triggerActions isEmpty.
	self assert: description actionsRedirected isEmpty.
		
	rawAction := description createAction: #rawAction do: [ self performAction ].
	self assert: description actionsRaw size equals: 1.
	rawAction2 := description createAction: #rawAction2 do: [ self performAction ].
	self assert: description actionsRaw size equals: 2.
	
	triggerAction := description putTrigger: (APTriggerAction key: #triggerAction do: [ self performAction ]).
	self assert: description triggerActions size equals: 1.
	triggerAction2 := description putTrigger: (APTriggerAction key: #triggerAction2 do: [ self performAction ]).
	self assert: description triggerActions size equals: 2.
	
	redirectedAction := description createAction: #redirectedAction redirectTo: #(some path).
	self assert: description actionsRedirected size equals: 1.
	redirectedAction2 := description createAction: #redirectedAction2 redirectTo: #(some path).
	self assert: description actionsRedirected size equals: 2.
	
	
]

{ #category : #'tests - events' }
APartDescriptionTest >> testActionsForEvent [

	self assert: (description actionNamesForEventType: APFocusEvent ifAbsent: [ #missing ]) equals: #missing.
	
	self should: [ description onEvent: APFocusEvent doActionNamed: #someAction ] raise: APMissingActionError.
	description createAction: #someAction do: [ #performed ].
	description onEvent: APFocusEvent doActionNamed: #someAction.
		
	self assertCollection: (description actionNamesForEventType: APFocusEvent ifAbsent: [ #missing ]) hasSameElements: #(someAction).
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testAllActionKeys [
			
	|  rawAction rawAction2 triggerAction triggerAction2 redirectedAction redirectedAction2 |

	self assert: description allActionKeys isEmpty.
	self assert: description triggerActions isEmpty.
	self assert: description actionsRedirected isEmpty.
	
	rawAction := description createAction: #rawAction do: [ self performAction ].
	rawAction2 := description createAction: #rawAction2 do: [ self performAction ].

	self assertCollection: description allActionKeys hasSameElements: #(rawAction rawAction2).
	
	triggerAction := description putTrigger: (APTriggerAction key: #triggerAction do: [ self performAction ]).
	triggerAction2 := description putTrigger: (APTriggerAction key: #triggerAction2 do: [ self performAction ]).
	self assertCollection: description allActionKeys hasSameElements: #(rawAction rawAction2 triggerAction triggerAction2).
	
	redirectedAction := description createAction: #redirectedAction redirectTo: #(some path).
	redirectedAction2 := description createAction: #redirectedAction2 redirectTo: #(some path).

	self assertCollection: description allActionKeys hasSameElements: #(rawAction rawAction2 triggerAction triggerAction2 redirectedAction redirectedAction2).
	
	self assert: description allActionKeys isSorted.
	
	
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testAllAspectKeysDo [ 

	| originalKeys aspect1 aspect2 keys values result |
	
	originalKeys := #(aspect1 aspect2).
	aspect1 := description createAspectNamed: #aspect1.
	aspect2 := description createAspectNamed: #aspect2.
	keys := OrderedCollection new.
	values := OrderedCollection new.
	result := description aspectKeysAndValuesDo: [ :aKey :aValue | keys add: aKey. values add: aValue ].
	self assert: result isDictionary. "dictionary of aspects"
	self assertCollection: keys sorted asArray equals: (originalKeys, {#explicitAspect}) sorted asArray.	
	self assertCollection: (values asArray last: 2) equals: { aspect1. aspect2 }.
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testAllAspectKeysInclude [ 

	| keys |
	
	keys := #(aspect1 aspect2 aspect3).
	self deny: (description allAspectKeysInclude: #aspect1).
	description createAllAspectsNamed: keys.
	self assert: (description allAspectKeysInclude: #aspect1)
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testAspectForIfAbsentIgnoreAutoAspects [

	| result |
	
	self assert: (description aspectFor: #someAspect ifAbsent: [#absent] ignoreAutoAspects: true) equals: #absent.
	self assert: (description aspectFor: #yourself ifAbsent: [#absent] ignoreAutoAspects: true) equals: #absent.
	self assert: (description aspectFor: #someAspect ifAbsent: [#absent] ignoreAutoAspects: false) equals: #absent.
	self assert: (description aspectFor: #yourself ifAbsent: [#absent] ignoreAutoAspects: false) equals: #absent.
	
	part autoAspects: true.

	self assert: (description aspectFor: #someAspect ifAbsent: [#absent] ignoreAutoAspects: true) equals: #absent.
	self assert: (description aspectFor: #yourself ifAbsent: [#absent] ignoreAutoAspects: true) equals: #absent.
	self assert: (description aspectFor: #someAspect ifAbsent: [#absent] ignoreAutoAspects: false) equals: #absent.
	self deny: (result := description aspectFor: #yourself ifAbsent: [#absent] ignoreAutoAspects: false) equals: #absent.
	self assert: result isAutoAspect
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testAutoAspectDefinition [

	self deny: description autoAspectDefinition
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testAutoDefineAspect [

	| anAspect |
	
	anAspect := part description autoDefineAspect: #yourself.
	
	self assert: anAspect name equals: #yourself.
	
	anAspect := part description autoDefineAspect: #notImplementedMessage.
	
	self assert: anAspect isNil
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCheckForActionExistence [

	self should: [ description checkForActionExistence: #someAction ] raise: APMissingActionError.

	description createAction: #someAction do: [ self performAction ].

	self shouldnt: [ description checkForActionExistence: #someAction ] raise: APMissingActionError.

]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCheckForActionRedefinition [

	self shouldnt: [ description checkForActionRedefinition: #someAction ] raise: APActionRedefinitionError.

	description createAction: #someAction do: [ self performAction ].

	self should: [ description checkForActionRedefinition: #someAction ] raise: APActionRedefinitionError.

]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testCheckForAspectExistence [

	self should: [ description checkForAspectExistence: #someAspect ] raise: APMissingAspectKeyError.

	description createAspectNamed: #someAspect.
		
	self shouldnt: [ description checkForAspectExistence: #someAspect ] raise: APMissingAspectKeyError.

]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionDo [
	
	| anAction | 
	
	anAction := description createAction: #someAction do: [ self performAction ].
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	
	self should: [ description createAction: #someAction do: [ self performAction ] ] raise: APActionRedefinitionError.
	
	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionDoIf [
	
	| anAction | 
	
	anAction := description createAction: #someAction do: [ self performAction ] if: APCondition true.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	
	self should: [ description createAction: #someAction do: [ self performAction ] if: APCondition true ] raise: APActionRedefinitionError.
	

	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionDoIfHelpText [
	
	| anAction | 
	
	anAction := description createAction: #someAction do: [ self performAction ] if: APCondition true helpText: 'help'.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	self assert: anAction helpText equals: 'help'.
	
	self should: [ description createAction: #someAction do: [ self performAction ] if: APCondition true helpText: 'help' ] raise: APActionRedefinitionError.
	

	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionDoIfaddEnumEntryTo [
	
	| anAction anEnumeration |
	
	anEnumeration := APEnumeration create. 
	
	anAction := description createAction: #someAction do: [ self performAction ] if: APCondition true addEnumEntryTo: anEnumeration.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	self assert: (anEnumeration hasKey: #someAction).
	
	self should: [ description createAction: #someAction do: [ self performAction ] if: APCondition true ] raise: APActionRedefinitionError.
	

	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionRedirectTo [
	
	| anAction | 
	
	anAction := description createAction: #redirectedAction redirectTo: #(some path).
	
	self assert: anAction key equals: #redirectedAction.
	self assert: (description hasActionNamed: #redirectedAction).
	self assert: anAction isRedirected.
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionWithArgumentDoDoIfHelpText [
	
	| anAction | 
	
	anAction := description createAction: #someAction withArgumentDo: [ :arg | self performAction ] if: APCondition true helpText: 'help'.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	self assert: anAction helpText equals: 'help'.
	
	self should: [ description createAction: #someAction withArgumentDo: [ :arg | self performAction ] if: APCondition true helpText: 'help' ] raise: APActionRedefinitionError.
	
 	self should: [ description createAction: #withoutArgument withArgumentDo: [ self performAction ] if: APCondition true helpText: 'help' ] raiseAPartError: #inconsistentAction
	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionwithArgumentDo [
	
	| anAction | 
	
	anAction := description createAction: #someAction withArgumentDo: [ :arg | self performAction ].
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	
	self should: [ description createAction: #someAction do: [ self performAction ] ] raise: APActionRedefinitionError.
	
 	self should: [description createAction: #withoutArgument withArgumentDo: [ self performAction ] ] raiseAPartError: #inconsistentAction

]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionwithArgumentDoIf [
	
	| anAction | 
	
	anAction := description createAction: #someAction withArgumentDo: [ :arg | self performAction ] if: APCondition true.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	
	self should: [ description createAction: #someAction do: [ self performAction ] if: APCondition true ] raise: APActionRedefinitionError.
	
	self should: [ description createAction: #withoutArgument withArgumentDo: [ self performAction ] if: APCondition true ] raiseAPartError: #inconsistentAction


	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionwithArgumentDoIfAddEnumEntryTo [
	
	| anAction enum | 
	
	enum := APEnumeration create.
	anAction := description createAction: #someAction withArgumentDo: [ :arg | self performAction ] if: APCondition true addEnumEntryTo: enum.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	
	self should: [ description createAction: #someAction do: [ self performAction ] if: APCondition true ] raise: APActionRedefinitionError.
	
	self should: [ description createAction: #withoutArgument withArgumentDo: [ self performAction ] if: APCondition true addEnumEntryTo: enum ] raiseAPartError: #inconsistentAction

	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateActionwithArgumentDoIfHelpText [
	
	| anAction | 
	
	anAction := description createAction: #someAction withArgumentDo: [ :arg | self performAction ] if: APCondition true helpText: 'help'.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	self assert: anAction helpText equals: 'help'.
	
	self should: [ description createAction: #someAction do: [ self performAction ] if: APCondition true helpText: 'help' ] raise: APActionRedefinitionError.
	
	self should: [ description createAction: #withoutArgument withArgumentDo: [ self performAction ] if: APCondition true helpText: 'help' ] raiseAPartError: #inconsistentAction

	
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testCreateAllAspectsNamed [

	| aspects |

	aspects := description createAllAspectsNamed: #(someAspect someAspect2 someAspect3).
	
	self assert: (aspects noneSatisfy: #isRedirected).
	self assert: (description hasAspectNamed: #someAspect).
	self assert: (description hasAspectNamed: #someAspect2).	
	self assert: (description hasAspectNamed: #someAspect3).
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testCreateAspectNamed [

	| aspect |

	aspect := description createAspectNamed: #someAspect.
	
	self deny: aspect isRedirected.
	self assert: (description hasAspectNamed: #someAspect).
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testCreateAspectNamedRedirectTo [

	| redirected | 
	
	description createAspectNamed: #yourself.
	
	redirected := description createAspectNamed: #redirected redirectTo: #(yourself explicitAspect).

	self assert: redirected isRedirected.

	self should: [ description createAspectNamed: #redirected redirectTo: #(yourself explicitAspect) ] raise: APAspectRedefinitionError.

]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testCreateAspectNamedUse [

	| adapter result |
	
	adapter := APValueAdaptor on: part key: #someAspect.
	
	result := description createAspectNamed: #someAspect use: adapter.
	self deny: result isRedirected.
	
	self assert: (description aspectFor: #someAspect ifAbsent: [nil]) subAdaptor equals: adapter.
	
	self should: [ 
		description createAspectNamed: #someAspect use: adapter.
	] raise: APAspectRedefinitionError 
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testCreateRedirectionAspectForSubpartAt [

	| subpart result |
	
	subpart := APartList onPart: part.
	part addSubPart: subpart key: #subpart.

	result := description createRedirectionAspectForSubpartAt: #subpart.
	self assert: result isRedirected.
	self assert: result path equals: #(subpart selectionInList).
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testDefineAction [

	| anAction returnedAction | 
	
	anAction := APPublicAction key: #someAction do: [ self performAction ] if: APCondition true.
	returnedAction := description defineAction: anAction.
	
	self assert: anAction key equals: #someAction.
	self assert: (description hasActionNamed: #someAction).
	self assert: anAction statefulCondition booleanValue.
	
	self assert: returnedAction identicalTo: anAction

]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testDefinesAspect [

	self deny: (description definesAspect: #someAspect).
	description createAspectNamed: #someAspect.
	self assert: (description definesAspect: #someAspect).
	
	self deny: (description definesAspect: #yourself).
	self deny: (description definesAspect: #notImplementedMessage).
	part autoAspects: true.
	self assert: (description definesAspect: #yourself).
	self deny: (description definesAspect: #notImplementedMessage).

	self assert: (description definesAspect: #someAspect).

	description createAspectNamed: #yourself.
	self assert: (description definesAspect: #yourself).

]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testEnsureAspectNamed [

	| aspect aspect2 |

	aspect := description ensureAspectNamed: #someAspect.	
	self deny: aspect isRedirected.
	self assert: (description hasAspectNamed: #someAspect).
	
	aspect2 := description ensureAspectNamed: #someAspect.	
	self assert: aspect identicalTo: aspect2
]

{ #category : #'tests - events' }
APartDescriptionTest >> testEventHandlers [
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testHasActionNamed [
	
	| anAction | 
	
	self deny: (description hasActionNamed: #someAction).
	
	anAction := description createAction: #someAction do: [ self performAction ].
	
	self assert: (description hasActionNamed: #someAction).
	

	
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testKnows [

	self deny: (description knows: #someAspect).
	description createAspectNamed: #someAspect.
	self assert: (description knows: #someAspect).

	self deny: (description knows: #someAction ).
	description createAction: #someAction do: [ self performAction ].
	self assert: (description knows: #someAction).
]

{ #category : #tests }
APartDescriptionTest >> testPart [
	
	self assert: description part equals: part.
	
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testPrivCreateAutoAspectNamed [

	self assert: (description privCreateAutoAspectNamed: #someAspect) isAutoAspect
]

{ #category : #'tests - actions' }
APartDescriptionTest >> testPutTrigger [

	| anAction | 
	
	anAction := description putTrigger: (APTriggerAction key: #triggerAction do: [ self performAction ]).
	
	self assert: anAction key equals: #triggerAction.
	self assert: (description hasActionNamed: #triggerAction).
	
	self should: [ description putTrigger: (APTriggerAction key: #inconsistent do: [ :arg | self performAction ]) ] raiseAPartError: #inconsistentTrigger.
	
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testRelease [

	description createAspectNamed: #someAspect.
	description createAction: #someAction do: [ self performAction ].
	self assert: (description hasAspectNamed: #someAspect).	
	self assert: (description hasActionNamed: #someAction).	
	description release.
	self deny: (description hasAspectNamed: #someAspect).	
	self deny: (description hasActionNamed: #someAction).	

]

{ #category : #tests }
APartDescriptionTest >> testUndefineAction [
			
	description createAction: #someAction do: [ self performAction ].
	description undefineAction: #someAction.
	
	self deny: (description hasActionNamed: #someAction).
	

	
]

{ #category : #'tests - aspects' }
APartDescriptionTest >> testUndefineAspectNamed [

	| aspect |

	aspect := description createAspectNamed: #someAspect.
	self assert: (description hasAspectNamed: #someAspect).	
	description undefineAspectNamed: #someAspect.	
	self deny: (description hasAspectNamed: #someAspect)
]
