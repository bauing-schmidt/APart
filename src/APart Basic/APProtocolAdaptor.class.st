Class {
	#name : #APProtocolAdaptor,
	#superclass : #APModelWithValue,
	#instVars : [
		'defaultSubject',
		'subjectChannel',
		'path',
		'sendsUpdates'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'instance creation' }
APProtocolAdaptor class >> path: aPath [
	
	^ self new path: aPath
]

{ #category : #'instance creation' }
APProtocolAdaptor class >> subject: aSubject [

	^self subject: aSubject sendsUpdates: false
]

{ #category : #'instance creation' }
APProtocolAdaptor class >> subject: aSubject sendsUpdates: aBoolean [

	^(self new)
		subject: aSubject;
		sendsUpdates: aBoolean
]

{ #category : #'instance creation' }
APProtocolAdaptor class >> subjectChannel: anObject [
	^self subjectChannel: anObject sendsUpdates: false
]

{ #category : #'instance creation' }
APProtocolAdaptor class >> subjectChannel: aValueModel sendsUpdates: aBoolean [

	^self new
		sendsUpdates: aBoolean;
		subjectChannel: aValueModel
]

{ #category : #accessing }
APProtocolAdaptor >> access: anObject with: anAccessor [
	^ anAccessor isSymbol
		ifTrue: [ anObject aPartPerform: anAccessor ]
		ifFalse: [ anAccessor isInteger
				ifTrue: [ anObject at: anAccessor ]
				ifFalse: [ anAccessor value: anObject ] ]
]

{ #category : #accessing }
APProtocolAdaptor >> addDependent: anObject [

	dependents ifNil: [ self subscribeToDefaultSubject ].
	^ super addDependent: anObject
]

{ #category : #accessing }
APProtocolAdaptor >> changedSubject [

	self setSubject: self subjectChannel value
]

{ #category : #accessing }
APProtocolAdaptor >> initialize [

	super initialize.
	sendsUpdates := false
]

{ #category : #accessing }
APProtocolAdaptor >> isAPAdaptor [

	^true
]

{ #category : #accessing }
APProtocolAdaptor >> path [

	^ path
]

{ #category : #accessing }
APProtocolAdaptor >> path: aPath [

	path := aPath
]

{ #category : #accessing }
APProtocolAdaptor >> privValueUsing: anObject [

	<ignoreForCoverage>

	^ self subclassResponsibility
]

{ #category : #accessing }
APProtocolAdaptor >> releaseRequisites [
	self safeUnsubscribeFromDefaultSubject.
	subjectChannel notNil
		ifTrue: [ subjectChannel removeDependent: self ]
]

{ #category : #accessing }
APProtocolAdaptor >> removeDependent: anObject [

	super removeDependent: anObject.
	dependents ifNil: [ self unsubscribeFromDefaultSubject ].
	^ anObject
]

{ #category : #private }
APProtocolAdaptor >> safeSubscribeToDefaultSubject [
	(defaultSubject notNil and: [ dependents notNil ])
		ifTrue: [ self subscribeToDefaultSubject ]
]

{ #category : #private }
APProtocolAdaptor >> safeUnsubscribeFromDefaultSubject [
	(defaultSubject notNil and: [ dependents notNil ])
		ifTrue: [ self unsubscribeFromDefaultSubject ].
]

{ #category : #accessing }
APProtocolAdaptor >> sendsUpdates: aBoolean [
	self safeUnsubscribeFromDefaultSubject.
	sendsUpdates := aBoolean.
	self safeSubscribeToDefaultSubject.
]

{ #category : #accessing }
APProtocolAdaptor >> setSubject: anObject [
	self safeUnsubscribeFromDefaultSubject.
	defaultSubject := anObject.
	self safeSubscribeToDefaultSubject.	
	dependents update: #value with: nil from: self
]

{ #category : #accessing }
APProtocolAdaptor >> setValue: newValue [

	self setValueIn: self target to: newValue
]

{ #category : #accessing }
APProtocolAdaptor >> setValueIn: anObject to: newValue [

	<ignoreForCoverage>

	^ self subclassResponsibility
]

{ #category : #accessing }
APProtocolAdaptor >> subject [

	^ defaultSubject
]

{ #category : #accessing }
APProtocolAdaptor >> subject: anObject [
	(self subjectChannel)
		ifNotNil: [ :aSubjectChannel | aSubjectChannel value: anObject ]
		ifNil: [ self setSubject: anObject ]
]

{ #category : #accessing }
APProtocolAdaptor >> subjectChannel [
	
	^ subjectChannel
]

{ #category : #accessing }
APProtocolAdaptor >> subjectChannel: aValueModel [

	subjectChannel notNil
		ifTrue: [ subjectChannel removeDependent: self ].
	subjectChannel := aValueModel.
	subjectChannel notNil
		ifTrue: [ subjectChannel addDependent: self ].
	self changedSubject
]

{ #category : #accessing }
APProtocolAdaptor >> subjectSendsUpdates: aBoolean [
	self safeUnsubscribeFromDefaultSubject.
	sendsUpdates := aBoolean.
	self safeSubscribeToDefaultSubject.
]

{ #category : #private }
APProtocolAdaptor >> subscribeToDefaultSubject [
	(sendsUpdates and: [ defaultSubject notNil ])
		ifTrue: [ defaultSubject addDependent: self ] 
]

{ #category : #accessing }
APProtocolAdaptor >> target [

	^ self targetUsingSubject: defaultSubject
]

{ #category : #accessing }
APProtocolAdaptor >> targetUsingSubject: anObject [
	| aSubject |
	aSubject := anObject.
	self path ifNotNil: [ :aPath |
		aPath
			do: [ :pathSegment | 
				aSubject ifNil: [ ^ nil ].
				aSubject := self access: aSubject with: pathSegment ]].
	^ aSubject
]

{ #category : #private }
APProtocolAdaptor >> unsubscribeFromDefaultSubject [
	(sendsUpdates and: [ defaultSubject notNil ])
		ifTrue: [ defaultSubject removeDependent: self ]
]

{ #category : #accessing }
APProtocolAdaptor >> update: anAspect with: parameters from: anObject [

	anObject == subjectChannel
		ifTrue: [ self changedSubject ]
]

{ #category : #accessing }
APProtocolAdaptor >> value [
	^ self valueUsingSubject: defaultSubject
]

{ #category : #accessing }
APProtocolAdaptor >> value: newValue [

	self setValue: newValue.
	sendsUpdates
		ifFalse: [ self changed: #value ]
]

{ #category : #accessing }
APProtocolAdaptor >> valueUsingSubject: aSubject [

	^ self privValueUsing: (self targetUsingSubject: aSubject)
]
