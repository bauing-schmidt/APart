Extension { #name : #SequenceableCollection }

{ #category : #'*APart Json Support-converting' }
SequenceableCollection >> printJsonOn: s [

	s nextPut: $[.
	self do: [:el | el printJsonOn: s] separatedBy: [s nextPut: $,].
	s nextPut: $]
]
