Extension { #name : #APUseCaseAction }

{ #category : #'*APart Recording' }
APUseCaseAction >> createRecordedInteraction [

	^(APRecordedInteraction action)
		key: key;
		value: self;
		yourself
]

{ #category : #'*APart Recording' }
APUseCaseAction >> isExecutable [

	self disabledByFocus ifTrue: [ ^ false ].
	^statefulCondition ifNotNil: [statefulCondition booleanValue] ifNil: [true]
]
