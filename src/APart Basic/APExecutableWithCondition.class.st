"
APExecutableWithCondition enhances its superclass by holding a kind of APStatefulCondition. This condition determines if the piece of code held (or pointed to) by the APExecutable instance currently is executable or if it is disabled.
"
Class {
	#name : #APExecutableWithCondition,
	#superclass : #APExecutable,
	#instVars : [
		'statefulCondition',
		'helpText'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #'instance creation' }
APExecutableWithCondition class >> key: aKey do: anActionBlock if: aCondition [

	^(self key: aKey do: anActionBlock)
		setStatefulConditionOn: aCondition;
		yourself
]

{ #category : #'instance creation' }
APExecutableWithCondition class >> key: aKey do: anActionBlock if: aCondition helpText: aHelpText [

	^(self key: aKey do: anActionBlock)
		setStatefulConditionOn: aCondition;
		helpText: aHelpText;
		yourself
]

{ #category : #API }
APExecutableWithCondition >> condition [
	^ statefulCondition condition
]

{ #category : #API }
APExecutableWithCondition >> disabledByFocusReason [

	^ #noFocus
]

{ #category : #accessing }
APExecutableWithCondition >> helpText [

	^helpText
]

{ #category : #accessing }
APExecutableWithCondition >> helpText: aHelpText [

	helpText := aHelpText
]

{ #category : #testing }
APExecutableWithCondition >> isActive [
	"Kompatibilitätsanschluss"

	^self isExecutable
]

{ #category : #testing }
APExecutableWithCondition >> isChanged [

	^statefulCondition ifNotNil: [statefulCondition isChanged] ifNil: [false]
]

{ #category : #testing }
APExecutableWithCondition >> isExecutable [

	self disabledByFocus ifTrue: [ ^ false ].
	^statefulCondition ifNotNil: [statefulCondition booleanValue] ifNil: [true]
]

{ #category : #API }
APExecutableWithCondition >> isInactiveForReason: aReason [

	^statefulCondition reason == aReason
]

{ #category : #API }
APExecutableWithCondition >> reasonForInactivity [

	self disabledByFocus ifTrue: [ ^ self disabledByFocusReason ].
	^statefulCondition ifNotNil: [statefulCondition reason]
]

{ #category : #'initialize-release' }
APExecutableWithCondition >> setStatefulConditionOn: aCondition [

	statefulCondition := aCondition
				ifNotNil: [APStatefulCondition on: aCondition]
]

{ #category : #updating }
APExecutableWithCondition >> statefulCondition [

	^statefulCondition
]

{ #category : #updating }
APExecutableWithCondition >> updateCondition [

	statefulCondition updateCondition
]

{ #category : #updating }
APExecutableWithCondition >> updateConditionUsingCache: conditionCache [

	statefulCondition updateConditionUsingCache: conditionCache
]

{ #category : #updating }
APExecutableWithCondition >> updateOnCondition: newCondition [

	statefulCondition updateOnCondition: newCondition
]

{ #category : #updating }
APExecutableWithCondition >> updateOnFinalReason: reason [

	self updateOnCondition: (APConditionFinal on: reason)
]

{ #category : #evaluating }
APExecutableWithCondition >> value [
	"Protocol used by action widget"
	
	^false
]
