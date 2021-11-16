Extension { #name : #SpCollectionListModel }

{ #category : #'*APart Pharo' }
SpCollectionListModel >> privateCollection: anObject [
	| oldValue |

	oldValue := collection.
	collection := anObject.
	self refreshList.
	
]
