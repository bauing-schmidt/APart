Extension { #name : #Collection }

{ #category : #'*APart Basic' }
Collection >> asOrderedCollectionWithDependants [

	^ OrderedCollectionWithDependants new addAll: self;
		yourself.
]

{ #category : #'*APart Basic' }
Collection >> wipe [

	^ self removeAll.
]
