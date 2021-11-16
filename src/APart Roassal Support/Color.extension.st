Extension { #name : #Color }

{ #category : #'*APart Roassal Support' }
Color class >> fromHexNumber: aNumber [

	| s | 
	
	s := aNumber
		printPaddedWith: $0
		to: 6
		base: 16.
	^ self fromHexString: s
]
