"
APxPeriodSelectionPart shows how to use APPeriodSelectionPart with PeriodSelection objects.
And it shows how to control what period types are enabled/disabled


"
Class {
	#name : #APxPeriodSelectionExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'selectedPeriod',
		'enableAllOption',
		'enableYearOption',
		'enableMonthOption',
		'enableWeekOption',
		'enableDayOption',
		'enableFromToOption'
	],
	#category : #'APart Examples-PeriodSelection'
}

{ #category : #accessing }
APxPeriodSelectionExamplePart >> disabledCondition [
	<aPartAspectCondition>

	^APCondition false
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableAllOption [
	<aPartAspect>

	^enableAllOption = true
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableAllOption: aBoolean [

	enableAllOption := aBoolean
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableDayOption [
	<aPartAspect>

	^enableDayOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableDayOption: anObject [

	enableDayOption := anObject.
	anObject ifTrue: [self enableYearOption: true].
	self changedAspectValue: #enableDayOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableFromToOption [
	<aPartAspect>

	^enableFromToOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableFromToOption: anObject [

	enableFromToOption := anObject
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableMonthOption [
	<aPartAspect>

	^enableMonthOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableMonthOption: aBoolean [

	enableMonthOption := aBoolean.
	aBoolean ifTrue: [self enableYearOption: true].
	self changedAspectValue: #enableMonthOption.
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableWeekOption [
	<aPartAspect>

	^enableWeekOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableWeekOption: aBoolean [

	enableWeekOption := aBoolean.
	aBoolean ifTrue: [self enableYearOption: true].
	self changedAspectValue: #enableWeekOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableYearOption [
	<aPartAspect>

	^enableYearOption
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enableYearOption: aBoolean [

	enableYearOption = aBoolean ifTrue: [^nil].
	enableYearOption := aBoolean.
	self changedAspectValue: #enableYearOption.
	aBoolean
		ifFalse: 
			[self enableWeekOption: false.
			self enableMonthOption: false.
			self enableDayOption: false]
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> enabledPeriodTypes [

	| rst |
	rst := OrderedCollection new.
	self enableAllOption ifTrue: [rst add: #all].
	self enableYearOption ifTrue: [rst add: #year].
	self enableMonthOption ifTrue: [rst add: #month].
	self enableWeekOption ifTrue: [rst add: #week].
	self enableDayOption ifTrue: [rst add: #day].
	self enableFromToOption ifTrue: [rst add: #fromTo].
	^rst
]

{ #category : #'initialize-release' }
APxPeriodSelectionExamplePart >> initializeValues [

	super initializeValues.
	enableYearOption := true.
	enableMonthOption := true.
	enableWeekOption := true.
	enableDayOption := true.
	enableFromToOption := true.
]

{ #category : #'initialize-release' }
APxPeriodSelectionExamplePart >> selectPeriod [
	<aPartAction>

	(APPeriodSelectionPart
		onPart: self
		key: #periodSelectionPart
		postInit: 
			[:part |
			part setPeriodSelection: selectedPeriod.
			part setEnabledPeriodTypes: self enabledPeriodTypes])
		whenClosingDo: [:editor | editor result ifNotNil: [self selectedPeriod: editor result]];
		openClient
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> selectedPeriod [
	<aPartAspectEnabled: #disabledCondition>

	^selectedPeriod
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> selectedPeriod: anObject [

	selectedPeriod := anObject.
	self changedAllAspectValues
]

{ #category : #accessing }
APxPeriodSelectionExamplePart >> selectedPeriodFromToPrint [
	<aPartAspectEnabled: #disabledCondition>

	^selectedPeriod
		ifNil: ['']
		ifNotNil: 
			[selectedPeriod fromDate printString , ' -> '
				, selectedPeriod toDate printString]
]
