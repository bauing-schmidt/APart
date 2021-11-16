Class {
	#name : #APBindingsTest,
	#superclass : #APTest,
	#category : #'APart PharoTests-Bindings'
}

{ #category : #tests }
APBindingsTest >> testAdditionalSubpresentersMap [
	
	self for: APBindingsTestPresenter performTest: [ :part :presenter | 
		| assocs | 
		assocs := presenter additionalSubpresentersMap associations.
		self assertCollection: assocs size equals: 1.
		self assert: assocs first key equals: #stringAspect.
		self assert: (assocs first value isKindOf: APartTextInputFieldPresenter).
		self assert: assocs first value aspectSymbol equals: #stringAspect.	
	] 
]

{ #category : #tests }
APBindingsTest >> testBindingsManager [
	
	self for: APBindingsTestPresenter performTest: [ :part :presenter | 
		| assocs | 
		self assert: (presenter presenters allSatisfy: [ :each | 
			each bindingsManager isKindOf: APartBindingsManager ]) ]
]

{ #category : #tests }
APBindingsTest >> testDifferentAspectAndPresenterName [
	
	self for: APBindingsTestPresenterWithDifferentAspectSymbol performTest: [ :part :presenter | 
		| assocs | 
		assocs := presenter additionalSubpresentersMap associations.
		self assertCollection: assocs size equals: 1.
		self assert: assocs first key equals: #stringPresenter.
		self assert: (assocs first value isKindOf: APartTextInputFieldPresenter).
		self assert: assocs first value aspectSymbol equals: #stringAspect.	
	] 
]
