Extension { #name : #Fraction }

{ #category : #'*APart Json Support-converting' }
Fraction >> printJsonOn: aStream [

	self asDouble printJsonOn: aStream
]
