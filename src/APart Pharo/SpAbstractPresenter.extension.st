Extension { #name : #SpAbstractPresenter }

{ #category : #'*APart Pharo' }
SpAbstractPresenter >> detachFromPart [ 

	(self class allSlots select: [ :e | e isKindOf: SpObservableSlot  ]) do: [ :aSlot |
		| val | 
		val := aSlot rawRead: self.
		(val isKindOf: SpValueHolder) ifTrue: [ 
			val subscriptions do: [ :sub | 
				(sub receiver isKindOf: SpAbstractAdapter)	ifTrue: [ 
						val unsubscribe: sub receiver  ] ] ]
		 ].

]

{ #category : #'*APart Pharo' }
SpAbstractPresenter >> privHelp: aString [


]
