Extension { #name : #UndefinedObject }

{ #category : #'*APart Json Support-converting' }
UndefinedObject >> printJsonOn: s [

	s nextPutAll: #null
]
