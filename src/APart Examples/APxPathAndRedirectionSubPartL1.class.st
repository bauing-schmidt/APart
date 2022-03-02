"
APxPathAndRedirectionSubPartL1 the first sub part of the APxPathAndRedirectionPart.
"
Class {
	#name : #APxPathAndRedirectionSubPartL1,
	#superclass : #APartExample,
	#instVars : [
		'enabled',
		'clickDate',
		'partL2',
		'attachedObject'
	],
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #accessing }
APxPathAndRedirectionSubPartL1 >> attachedObject [

	^attachedObject
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL1 >> clickDate [

	^clickDate
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL1 >> clickDate: anObject [

	clickDate := anObject.
	self changedAspectValue: #clickDate.
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL1 >> defineAspects [

	self at: #clickDate putCondition: self isEnabled.
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL1 >> enabled [

	^enabled
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL1 >> enabled: anObject [

	enabled := anObject.
	self rootUpdate.
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL1 >> initializeActions [

	partInterface description
		createAction: #click
		do: 
			[self clickDate
				ifNotNil: [self clickDate: (self clickDate addDays: 1)]
				ifNil: [self clickDate: Date today]]
		if: self isEnabled
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL1 >> initializeValues [

	super initializeValues.
	enabled := true.
	partL2 := APxPathAndRedirectionSubPartL2 onPart: self key: #partL2.
	partL2 setStatefulConditionOn: self isEnabled.
	attachedObject := APxPathAndRedirectionObject new.
	attachedObject name: 'Attached to L1'.
]

{ #category : #condition }
APxPathAndRedirectionSubPartL1 >> isEnabled [

	^APCondition on: [enabled = true] ifNot: #notEnabled.
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL1 >> partL2 [

	^partL2
]
