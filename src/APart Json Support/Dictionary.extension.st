Extension { #name : #Dictionary }

{ #category : #'*APart Json Support-converting' }
Dictionary >> printJsonOn: s [
	"Da es sich um ein Dictionary handelt, werden nil-Values in jedem Fall geschrieben."

	s nextPut: ${.
	(self associations sorted: [ :a :b | a key <= b key ]) do: [ :anAssociation |
		| key value |
		key := anAssociation key.
		value := anAssociation value.
		key isString
			ifFalse: [self error: 'Expecting String as Dictionary key in JSON'].
		key printJsonOn: s.
		s nextPut: $:.
		value printJsonOn: s.
		s nextPut: $,].
	self notEmpty ifTrue: [s skip: -1].
	s nextPut: $}
]
