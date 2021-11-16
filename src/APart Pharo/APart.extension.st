Extension { #name : #APart }

{ #category : #'*APart Pharo' }
APart class >> new [ 

	"for compatibility with VisualWorks initialization"
	^self basicNew
]

{ #category : #'*APart Pharo' }
APart >> newApplication [

	^ APartSpecApplication defaultApplication
]

{ #category : #'*APart Pharo' }
APart >> openClientInApplication: anApplication [

	^clientRegistry openClientsForPart: self application: anApplication 
]
