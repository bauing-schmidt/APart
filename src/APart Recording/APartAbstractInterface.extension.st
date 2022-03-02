Extension { #name : #APartAbstractInterface }

{ #category : #'*APart Recording' }
APartAbstractInterface >> cloneInteractionListenersOn: anInterface [

	^(interactionListeners collect: 
			[:ial |
			ial
				privateRecordInteraction: ((anInterface part isSimplePrompt
							ifTrue: [APRecordedInteraction simplePrompt]
							ifFalse: [APRecordedInteraction complexPrompt])
							key: anInterface part key;
							yourself);
				cloneOnSubInterface: anInterface])
		reject: [:e | e isNil]
]
