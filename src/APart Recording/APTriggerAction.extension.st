Extension { #name : #APTriggerAction }

{ #category : #'*APart Recording' }
APTriggerAction >> createRecordedInteraction [

	^(APRecordedInteraction trigger)
		key: key;
		value: self;
		yourself
]
