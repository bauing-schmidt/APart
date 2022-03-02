Extension { #name : #Object }

{ #category : #'*APart Basic-message handling' }
Object >> aPartError: aSymbol [ 

	^(APError new tag: aSymbol) signal
]

{ #category : #'*APart Basic-message handling' }
Object >> aPartError: aSymbol attribute: anAttribute [

	^(APError new 
		tag: aSymbol;
		attribute: anAttribute) signal
]

{ #category : #'*APart Basic-message handling' }
Object >> aPartError: aSymbol text: aString [

	^(APError new 
		tag: aSymbol;
		messageText: aString) signal
]

{ #category : #'*APart Basic-message handling' }
Object >> aPartError: aSymbol text: aString attribute: anAttribute [

	^(APError new 
		tag: aSymbol;
		messageText: aString;
		attribute: anAttribute) signal
]

{ #category : #'*APart Basic-message handling' }
Object >> aPartPerform: aKey [

	^self perform: aKey
]

{ #category : #'*APart Basic-message handling' }
Object >> aPartPerform: aKey with: aValue [

	<ignoreForCoverage>

	^self perform: aKey with: aValue
]

{ #category : #'*APart Basic-message handling' }
Object >> asAPAspectNamed: aKey [

	^ APAspect named: aKey for: self
]

{ #category : #'*APart Basic' }
Object >> asAPModelDependentsWith: anObject [
	^ APModelDependentsCollection with: self with: anObject
]

{ #category : #'*APart Basic' }
Object >> dependencySubscriptionsDo: aBlock [

	| dependents |
	dependents := self myDependents.
	dependents == nil
		ifTrue: [ ^ self ].
	dependents class == APDependencySubscription
		ifTrue: [ aBlock value: dependents.
			^ self ].
	dependents class == APModelDependentsCollection
		ifTrue: [ dependents
				do: [ :each | 
					each class == APDependencySubscription
						ifTrue: [ aBlock value: each ] ] ]
]

{ #category : #'*APart Basic-message handling' }
Object >> isAPValueAdaptor [

	^ false
]

{ #category : #'*APart Basic-message handling' }
Object >> isInPharo [ 

	<ignoreForCoverage>

	^ (Smalltalk at: 'Core.Object' ifAbsent: [ nil ]) isNil
]

{ #category : #'*APart Basic-message handling' }
Object >> isPart [ 

	^ false
]

{ #category : #'*APart Basic-message handling' }
Object >> supportsAPartRedirection [

	"APart framework provides redirections on parts. However, sometimes may be useful to use a redirection on objects that are not parts. These objects should answer 'true' on this message. See TRedirectionProvider"

	^ false
]

{ #category : #'*APart Basic' }
Object >> unsubscribeInterestIn: anAspect for: anObject [
	self
		dependencySubscriptionsDo: [ :each | 
			(each isFor: anObject aspect: anAspect)
				ifTrue: [ self removeDependent: each ] ]
]

{ #category : #'*APart Basic' }
Object >> update: anAspectSymbol with: aParameter from: aSender [

	^self update: anAspectSymbol with: aParameter

]
