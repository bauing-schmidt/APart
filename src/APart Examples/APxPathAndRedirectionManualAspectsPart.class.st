"
APxPathAndRedirectionManualAspectsPart an inherited example part, showing the extra required definitions when setting autoAspectDefinition to false.
"
Class {
	#name : #APxPathAndRedirectionManualAspectsPart,
	#superclass : #APxPathAndRedirectionPart,
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #'initialize-release' }
APxPathAndRedirectionManualAspectsPart >> defineAspects [

	partInterface description
		createAspectNamed: #enabled;
		createAspectNamed: #attachedObject;
		createAspectNamed: #partL1;
		createAspectNamed: #currentPartKey;
		createAspectNamed: #switchingPart.
	super defineAspects
]

{ #category : #'initialize-release' }
APxPathAndRedirectionManualAspectsPart >> initializeValues [

	enabled := true.
	partL1 := APxPathAndRedirectionSubPartL1ManualAspect onPart: self
				key: #partL1.
	partL1 partInterface acceptActionPaths.
	partL1 setStatefulConditionOn: self isEnabled.
	attachedObject := APxPathAndRedirectionObject new.
	attachedObject name: 'Attached to root'.
	
	switchingPart := APSwitchingPart onPart: self key: #switchingPart.
	switchingPart releaseInactivePart: false.
	APxPathAndRedirectionSubPartL1 onPart: switchingPart key: #part1.
	APxPathAndRedirectionSubPartL1 onPart: switchingPart key: #part2.
	switchingPart currentPartKey: #part1
]
