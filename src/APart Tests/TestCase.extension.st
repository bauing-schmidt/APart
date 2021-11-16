Extension { #name : #TestCase }

{ #category : #'*APart Tests' }
TestCase >> should: aBlock raiseAPartError: aTag [
	
	^ self should: aBlock raise: APError withExceptionDo: [ :anException |
		self assert: anException tag equals: aTag ]
]

{ #category : #'*APart Tests' }
TestCase >> should: aBlock raiseAPartError: aTag attribute: anAttribute [
	
	^ self should: aBlock raise: APError withExceptionDo: [ :anException |
		self assert: anException tag equals: aTag.
		self assert: anException attribute equals: anAttribute ]
]

{ #category : #'*APart Tests' }
TestCase >> shouldntRaiseAPartError: aBlock [

	^ self shouldnt: aBlock raise: APError
]
