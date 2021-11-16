"
Collection of dependents for an object.
"
Class {
	#name : #APModelDependentsCollection,
	#superclass : #Array,
	#type : #variable,
	#category : #'APart Basic-Support'
}

{ #category : #converting }
APModelDependentsCollection >> asAPModelDependentsWith: anObject [
	^ self copyWith: anObject
]

{ #category : #converting }
APModelDependentsCollection >> update: anAspect with: anArgument from: anObject [

	self do: [ :each | each update: anAspect with: anArgument from: anObject]
]

{ #category : #converting }
APModelDependentsCollection >> updateRequest [

	self do: [ :each |
		each updateRequest ifFalse: [^false]].
	^true
]

{ #category : #converting }
APModelDependentsCollection >> updateRequest: anAspectSymbol [

	self do: [ :each | 
		(each updateRequest: anAspectSymbol)
			ifFalse: [ ^ false ] ].
	^ true
]
