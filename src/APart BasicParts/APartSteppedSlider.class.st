"
APartSteppedSlider unterstützt die Übergabe von Zahlenwerten, die vom GUI per Slider an das Modell übergeben werden. Hierbei ist mit einer hohen Frequenz an Änderungen zu rechnen, wobei unter Umständen die vom ParentPart Zeit zur Bearbeitung jeder einzelnen Änderung nicht ausreicht. Von daher registriert APartSteppedSlider mehr Daten als nur den letzten Zahlenwert und bietet dazu verschiedene Policies an, um in speziellen Konstellationen die Weiterleitung von Änderungen zu unterbinden.
"
Class {
	#name : #APartSteppedSlider,
	#superclass : #APart,
	#instVars : [
		'start',
		'stop',
		'step',
		'value',
		'valueBefore',
		'isInTransition',
		'wasInTransitionBefore',
		'lastMillisecondClockValue',
		'lastMSOffset',
		'valueChangedBlock'
	],
	#category : #'APart BasicParts'
}

{ #category : #API }
APartSteppedSlider >> aspectBuilderClass [

	^APInterfaceSteppedSliderAspectBuilder
]

{ #category : #'initialize-release' }
APartSteppedSlider >> defineAspects [

	partInterface  description createAllAspectsNamed: #(#start #stop #step #value)
]

{ #category : #'initialize-release' }
APartSteppedSlider >> from: aStart to: aStop step: aStep [

	start := aStart.
	stop := aStop.
	step := aStep
]

{ #category : #API }
APartSteppedSlider >> initializeValue: newValue [

	value := newValue.
]

{ #category : #'initialize-release' }
APartSteppedSlider >> initializeValues [
	
	start := 0.
	stop := 100.
	step := 5.
	value := 0.
	lastMillisecondClockValue := Time millisecondClockValue.
	isInTransition := false
]

{ #category : #API }
APartSteppedSlider >> mayChangeSelection [

	^partInterface executeTrigger: #requestSelectionChange ifAbsent: [true]
]

{ #category : #'initialize-release' }
APartSteppedSlider >> policyOnDuringAndEndTransitionOrOneSecondHold [

	^
	[:values :transitions |
	transitions last = true
		ifTrue: [self executeTrigger: #sliderValueInTransition with: values last].
	(transitions last = false or: [lastMSOffset > 1000])
		ifTrue: [self executeTrigger: #sliderValueChanged with: values last]]
]

{ #category : #'initialize-release' }
APartSteppedSlider >> policyOnEndTransitionOnly [

	^
	[:values :transitions |
	transitions last = false
		ifTrue: [self executeTrigger: #sliderValueChanged with: values last]]
]

{ #category : #'initialize-release' }
APartSteppedSlider >> policyOnEndTransitionOrOneSecondHold [

	^
	[:values :transitions |
	(transitions last = false or: [lastMSOffset > 1000])
		ifTrue: [self executeTrigger: #sliderValueChanged with: values last]]
]

{ #category : #API }
APartSteppedSlider >> start [

	^start
]

{ #category : #'initialize-release' }
APartSteppedSlider >> start: anObject [

	start := anObject.
	self updateDependents
]

{ #category : #API }
APartSteppedSlider >> step [

	^step
]

{ #category : #'initialize-release' }
APartSteppedSlider >> step: anObject [

	step := anObject.
	self updateDependents
]

{ #category : #API }
APartSteppedSlider >> stop [

	^stop
]

{ #category : #'initialize-release' }
APartSteppedSlider >> stop: anObject [

	stop := anObject.
	self updateDependents
]

{ #category : #updating }
APartSteppedSlider >> updateDependents [

	partInterface aspectBuilder updateSteppedSliderRangeFor: key in: nil.
]

{ #category : #'initialize-release' }
APartSteppedSlider >> usePolicy: aChangePolicySelector [

	valueChangedBlock := self perform: aChangePolicySelector
]

{ #category : #API }
APartSteppedSlider >> value [

	^value
]

{ #category : #API }
APartSteppedSlider >> value: newValue [

	| currentMSValue |
	newValue class = Array ifTrue: [^self valueWithState: newValue].
	valueBefore := value.
	currentMSValue := Time millisecondClockValue.
	lastMSOffset := currentMSValue - lastMillisecondClockValue.
	lastMillisecondClockValue := currentMSValue.
	value := (newValue between: start and: stop)
				ifTrue: [newValue]
				ifFalse: [start].
	self changedAspectValue: #value.
	valueChangedBlock notNil
		ifTrue: 
			[valueChangedBlock value: (Array with: valueBefore with: value)
				value: (Array with: wasInTransitionBefore with: isInTransition)]
]

{ #category : #'initialize-release' }
APartSteppedSlider >> valueChangedBlock: aTwoArgsBlock [
	"2 Arrays: #(first = old value, last = new value) #(first = old transition, last = new transition)"

	valueChangedBlock := aTwoArgsBlock
]

{ #category : #API }
APartSteppedSlider >> valueWithState: anArray [

	wasInTransitionBefore := isInTransition.
	isInTransition := anArray last.
	self value: anArray first.
	self changedAspectValue: #value
]
