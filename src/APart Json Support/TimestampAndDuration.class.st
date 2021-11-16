"
TimestampAndDuration kombiniert einen Timestamp mit einer Duration und repräsentiert somit ein absolutes Zeitintervall. Ein typischer Anwendungsfall dafür ist die Definition eines Intervalls an Wartezeit für den nächsten Schritt in einem Workflow.
"
Class {
	#name : #TimestampAndDuration,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'duration'
	],
	#category : #'APart Json Support'
}

{ #category : #'instance creation' }
TimestampAndDuration class >> timestamp: aTimestamp duration: aDuration [

	^(self new)
		timestamp: aTimestamp;
		duration: aDuration;
		yourself.
]

{ #category : #comparing }
TimestampAndDuration >> = anotherTimestampAndDuration [

	^self class = anotherTimestampAndDuration class and: 
			[timestamp = anotherTimestampAndDuration timestamp
				and: [duration = anotherTimestampAndDuration duration]]
]

{ #category : #API }
TimestampAndDuration >> begin [

	^timestamp
]

{ #category : #copying }
TimestampAndDuration >> copyAddDuration: durationDelta [

	| copy |
	copy := self class new.
	copy timestamp: timestamp copy.
	copy duration: duration + durationDelta.
	^copy
]

{ #category : #accessing }
TimestampAndDuration >> duration [

	^duration
]

{ #category : #accessing }
TimestampAndDuration >> duration: anObject [

	duration := anObject
]

{ #category : #API }
TimestampAndDuration >> end [

	^timestamp + duration
]

{ #category : #comparing }
TimestampAndDuration >> hash [

	^timestamp hash hashMultiply bitXor: duration hash
]

{ #category : #conversion }
TimestampAndDuration >> printJsonOn: aStream [

	(APJsonObject
		with: (APJsonProperty key: 'timestamp' value: timestamp)
		with: (APJsonProperty key: 'duration' value: duration))
			printJsonOn: aStream
]

{ #category : #accessing }
TimestampAndDuration >> timestamp [

	^timestamp
]

{ #category : #accessing }
TimestampAndDuration >> timestamp: anObject [

	timestamp := anObject
]
