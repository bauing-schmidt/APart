Extension { #name : #SortedCollection }

{ #category : #'*APart Basic' }
SortedCollection class >> withAll: aList sortBlock: filterBlock [

	| collection |
	
	collection := self sortBlock: filterBlock.
	collection addAll: aList.
	
	^ collection
]
