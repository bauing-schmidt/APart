Class {
	#name : #APModelWithValue,
	#superclass : #APModel,
	#category : #'APart Basic-Support'
}

{ #category : #converting }
APModelWithValue >> dependentBlock: aBlock [

	^ APBlockWithDependents block: aBlock arguments: (Array with: self)
]

{ #category : #converting }
APModelWithValue >> evaluate [
	^self value
]

{ #category : #converting }
APModelWithValue >> onChangeSend: aSymbol to: anObject [ 

	self
		subscribe: anObject
		aspect: #value
		selector: aSymbol
]

{ #category : #converting }
APModelWithValue >> release [
	self releaseRequisites.
	super release
]

{ #category : #converting }
APModelWithValue >> releaseRequisites [

	

	
]

{ #category : #converting }
APModelWithValue >> setValue: newValue [

	<ignoreForCoverage>

	self subclassResponsibility
]

{ #category : #converting }
APModelWithValue >> subscribe: anObject aspect: anAspect selector: aSelector [
	| dependencySubscription deps |
	dependencySubscription := APDependencySubscription
		receiver: anObject
		aspect: anAspect
		selector: aSelector.
	deps := self myDependents.
	(deps class == APModelDependentsCollection
		ifTrue: [ deps includes: dependencySubscription ]
		ifFalse: [ deps = dependencySubscription ])
		ifTrue: [ ^ self ].
	self addDependent: dependencySubscription 
]

{ #category : #converting }
APModelWithValue >> unsubscribeInterestsFor: anObject [

	self unsubscribeInterestIn: #value for: anObject
]

{ #category : #converting }
APModelWithValue >> value [

	<ignoreForCoverage>
	^self subclassResponsibility
]

{ #category : #converting }
APModelWithValue >> value: newValue [
	self setValue: newValue.
	self changed: #value
]

{ #category : #converting }
APModelWithValue >> valueUsingSubject: aSubject [

	^aSubject value
]
