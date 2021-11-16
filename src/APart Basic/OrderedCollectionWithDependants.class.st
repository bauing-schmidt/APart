"
I am na ordered collection with ability to subscribe to my basic operations like adding and removing of elements.
"
Class {
	#name : #OrderedCollectionWithDependants,
	#superclass : #OrderedCollection,
	#category : #'APart Basic-Support'
}

{ #category : #adding }
OrderedCollectionWithDependants >> addAll: aCollection [ 

	| result |
	
	result := super addAll: aCollection .
	self dependents ifNotEmpty: [self changed: #appendCollection: with: aCollection size].
	^ result
]

{ #category : #adding }
OrderedCollectionWithDependants >> addLast: newObject [ 

	| result |
	result := super addLast: newObject.
	self dependents ifNotEmpty: [self changed: #insert: with: lastIndex].
	^ result
]

{ #category : #adding }
OrderedCollectionWithDependants >> at: anIndex put: anObject [

	| result |
	
	result := super at: anIndex put: anObject.
	self dependents ifNotEmpty: [self changed: #at: with: anIndex].
	^ result
]

{ #category : #adding }
OrderedCollectionWithDependants >> remove: oldObject ifAbsent: absentBlock [

	| result |
	
	result := super remove: oldObject ifAbsent: absentBlock.
	self dependents == nil ifFalse: [self changed: #remove: with: oldObject].
	^ result
]

{ #category : #adding }
OrderedCollectionWithDependants >> removeLast [

	| result |
	
	result := super removeLast.
	self dependents ifNotEmpty: [self changed: #remove: with: self size+1].
	^ result
]

{ #category : #adding }
OrderedCollectionWithDependants >> setCollection: anArray limit: aSmallInteger [

	self flag: #todo "remove me"
	
	"collection := anArray.
	limit := aSmallInteger.
	collectionSize := collection size"
]
