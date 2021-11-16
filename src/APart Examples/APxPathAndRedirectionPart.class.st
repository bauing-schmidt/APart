"
APxPathAndRedirectionPart the root part for the path and redirection example.
The example shows three different methods of connecting UI elements to their counterparts in a deep hierarchical part structure.
The three methods are:
	- Using paths.
	- Using redirection.
	- Using sub canvas.

The example helps in examining the following behavior: 
	- Enablement/Disablement propagation, covering two types:
		- enablement/disablement through part conditions.
		- enablement/disablement through aspect and action conditions.
	- value change notification handling.
	- The enablement/disablement and the value change notification through APSwitchingPart for actions and aspects from paths.

This root part provides the following:
	- a hierarchy of sub parts #partL1>>partL2  which are instances of the classes APxPathAndRedirectionSubPartL1, APxPathAndRedirectionSubPartL2
	- a set of redirected actions and aspects that are pointing to the sub parts in the hierarchy.
	- an own attached non-part object, an instance of APxPathAndRedirectionObject.
	- an ""enabled"" aspect. which is used to configure the statefulCondition of the first sub part #partL1.
	- an attachedObject instance, to demonstrate the behavior of aspects that are ending outside the APart hierarchy.
	- a switching part, with two sub parts.

Instance Variables:
	attachedObject	<APxPathAndRedirectionObject>	description of attachedObject
	enabled	<Boolean>	description of enabled
	partL1	<APxPathAndRedirectionSubPartL1>	description of partL1
	partL1ManualAspects <APxPathAndRedirectionSubPartL1ManualAspect>
	switchingPart <APSwitchingPart>


"
Class {
	#name : #APxPathAndRedirectionPart,
	#superclass : #APartExample,
	#instVars : [
		'partL1',
		'attachedObject',
		'enabled',
		'partL1ManualAspects',
		'switchingPart'
	],
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #accessing }
APxPathAndRedirectionPart >> attachedObject [

	^attachedObject
]

{ #category : #accessing }
APxPathAndRedirectionPart >> currentPartKey [

	^switchingPart currentPartKey
]

{ #category : #accessing }
APxPathAndRedirectionPart >> currentPartKey: aKey [

	switchingPart currentPartKey: aKey
]

{ #category : #'initialize-release' }
APxPathAndRedirectionPart >> defineAspects [

	partInterface description
		createAspectNamed: #rootAttachedObjectName
			redirectTo: #(#attachedObject #name);
		
		createAspectNamed: #partL1Enabled
			redirectTo: #(#partL1 #enabled);
		createAspectNamed: #partL1ClickDate
			redirectTo: #(#partL1 #clickDate);
		createAspectNamed: #partL1AttachedObjectName
			redirectTo: #(#partL1 #attachedObject #name);
		
		createAspectNamed: #partL2Enabled
			redirectTo: #(#partL1 #partL2 #enabled);
		createAspectNamed: #partL2ClickTime
			redirectTo: #(#partL1 #partL2 #clickTime);
		createAspectNamed: #partL2AttachedObjectName
			redirectTo: #(#partL1 #partL2 #attachedObject #name)
]

{ #category : #accessing }
APxPathAndRedirectionPart >> enabled [

	^enabled
]

{ #category : #accessing }
APxPathAndRedirectionPart >> enabled: anObject [

	enabled := anObject.
	self rootUpdate.
]

{ #category : #'initialize-release' }
APxPathAndRedirectionPart >> initializeActions [

	partInterface description
		createAction: #partL1Click redirectTo: #(#partL1 #click);
		createAction: #partL2Click redirectTo: #(#partL1 #partL2 #click)
]

{ #category : #'initialize-release' }
APxPathAndRedirectionPart >> initializeValues [

	super initializeValues.
	enabled := true.
	partL1 := APxPathAndRedirectionSubPartL1 onPart: self key: #partL1.
	partL1 partInterface acceptActionPaths.
	partL1 setStatefulConditionOn: self isEnabled.
	attachedObject := APxPathAndRedirectionObject new.
	attachedObject name: 'Attached to root'.
	
	switchingPart := APSwitchingPart onPart: self key: #switchingPart.
	switchingPart releaseInactivePart: false.
	APxPathAndRedirectionSubPartL1 onPart: switchingPart key: #part1.
	APxPathAndRedirectionSubPartL1 onPart: switchingPart key: #part2.
	switchingPart currentPartKey: #part1.
]

{ #category : #condition }
APxPathAndRedirectionPart >> isEnabled [

	^APCondition on: [enabled = true] ifNot: #NotEnabled.
]

{ #category : #accessing }
APxPathAndRedirectionPart >> partL1 [

	^partL1
]

{ #category : #accessing }
APxPathAndRedirectionPart >> switchingPart [

	^switchingPart
]
