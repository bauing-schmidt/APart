Extension { #name : #ClassDescription }

{ #category : #'*APart-Magritte' }
ClassDescription >> needToAdaptToMethod: aRGMethod [
	^ self
		compiledMethodAt: aRGMethod selector
		ifPresent: [ :realMethod | (aRGMethod sourceCode = realMethod sourceCode and: [ aRGMethod protocol = realMethod protocol ]) not ]
		ifAbsent: [ true ]
]
