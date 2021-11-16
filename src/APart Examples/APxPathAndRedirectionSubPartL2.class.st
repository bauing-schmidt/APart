"
APxPathAndRedirectionSubPartL2 the second sub part of the APxPathAndRedirectionPart.
"
Class {
	#name : #APxPathAndRedirectionSubPartL2,
	#superclass : #APartExample,
	#instVars : [
		'clickTime',
		'enabled',
		'attachedObject'
	],
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #accessing }
APxPathAndRedirectionSubPartL2 >> attachedObject [

	^attachedObject
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL2 >> clickTime [

	^clickTime
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL2 >> clickTime: anObject [

	clickTime := anObject.
	self changedAspectValue: #clickTime.
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL2 >> defineAspects [

	self at: #clickTime putCondition: self isEnabled
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL2 >> enabled [

	^enabled
]

{ #category : #accessing }
APxPathAndRedirectionSubPartL2 >> enabled: anObject [

	enabled := anObject.
	self rootUpdate.
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL2 >> initializeActions [

	partInterface description
		createAction: #click
		do: [self clickTime: DateAndTime new]
		if: self isEnabled
]

{ #category : #'initialize-release' }
APxPathAndRedirectionSubPartL2 >> initializeValues [

	super initializeValues.
	enabled := true.
	attachedObject := APxPathAndRedirectionObject new.
	attachedObject name: 'Attached to L2'.
]

{ #category : #condition }
APxPathAndRedirectionSubPartL2 >> isEnabled [

	^APCondition on: [enabled = true] ifNot: #notEnabled.
]
