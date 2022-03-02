Extension { #name : #APPublicAction }

{ #category : #'*APart Recording' }
APPublicAction >> createRecordedInteraction [

	^(APRecordedInteraction action)
		key: key;
		value: self;
		yourself
]
