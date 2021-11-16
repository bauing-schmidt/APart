"
APxSteppedSliderExamplePart demonstriert den Einsatz eines Sliders, der in einstellbaren Schritten gerastert ist.
"
Class {
	#name : #APxSteppedSliderExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'sliderPart',
		'receivedValue'
	],
	#category : #'APart Examples-SteppedSlider'
}

{ #category : #'initialize-release' }
APxSteppedSliderExamplePart >> defineAspects [

	partInterface description
		createAspectNamed: #steppedSlider redirectTo: #(#steppedSlider #value);
		createAspectNamed: #steppedSliderStart redirectTo: #(#steppedSlider #start);
		createAspectNamed: #steppedSliderStop redirectTo: #(#steppedSlider #stop);
		createAspectNamed: #steppedSliderStep redirectTo: #(#steppedSlider #step)
]

{ #category : #'initialize-release' }
APxSteppedSliderExamplePart >> initializeValues [

	super initializeValues.
	receivedValue := nil.
	self at: #receivedValue putCondition: APCondition false.
	sliderPart := APartSteppedSlider onPart: self key: #steppedSlider.
	sliderPart
		from: 0 to: 100 step: 5;
		trigger: #sliderValueChanged
			withArgumentDo: [:sliderValue | self receivedValue: sliderValue];
		usePolicy: #policyOnEndTransitionOrOneSecondHold;
		value: 5
]

{ #category : #accessing }
APxSteppedSliderExamplePart >> receivedValue [

	^receivedValue
]

{ #category : #accessing }
APxSteppedSliderExamplePart >> receivedValue: anObject [

	receivedValue := anObject.
	self changedAspectValue: #receivedValue
]
