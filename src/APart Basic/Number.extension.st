Extension { #name : #Number }

{ #category : #'*APart Basic' }
Number >> asText [ 

	^ self asString asText
]

{ #category : #'*APart Basic' }
Number >> half [
	^ self / 2
]

{ #category : #'*APart Basic' }
Number >> midpoint: anArithmeticValue [
	^(self + anArithmeticValue) half
]
