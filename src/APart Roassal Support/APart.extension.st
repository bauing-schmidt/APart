Extension { #name : #APart }

{ #category : #'*APart Roassal Support' }
APart >> isShapeNode [

	^ false
]

{ #category : #'*APart Roassal Support' }
APart >> isShapePart [

	^ false
]

{ #category : #'*APart Roassal Support' }
APart >> rootShapePart [

	^parentPart ifNotNil: [:pc | pc rootShapePart] ifNil: [self]
]
