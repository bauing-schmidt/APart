Extension { #name : #UUID }

{ #category : #'*APart Json Support-converting' }
UUID >> asJsonObject [

	^self printString
]

{ #category : #'*APart Json Support-converting' }
UUID >> printJsonOn: s [

	self printOn: s
]
