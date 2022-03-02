Class {
	#name : #OrderedCollectionWithDependantsTestDependent,
	#superclass : #Object,
	#instVars : [
		'changes',
		'lastAspect'
	],
	#category : #'APart PharoTests'
}

{ #category : #accessing }
OrderedCollectionWithDependantsTestDependent >> changes [
 
	^ changes 
]

{ #category : #accessing }
OrderedCollectionWithDependantsTestDependent >> lastAspect [
 
	^ lastAspect 
]

{ #category : #updating }
OrderedCollectionWithDependantsTestDependent >> update: anAspect with: anObject [

	lastAspect := anAspect.
	changes := anObject.

	
]
