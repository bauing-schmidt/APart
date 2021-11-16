Class {
	#name : #MAAspectAccessor,
	#superclass : #MAAccessor,
	#instVars : [
		'aspectName'
	],
	#category : #'Apart-Magritte'
}

{ #category : #'instance creation' }
MAAspectAccessor class >> aspectName: aSelector [
	^ self new
		aspectName: aSelector;
		yourself
]

{ #category : #testing }
MAAspectAccessor class >> isAbstract [
	^ false
]

{ #category : #'instance creation' }
MAAspectAccessor class >> selector: aSelector [
	^ self new
		selector: aSelector;
		yourself
]

{ #category : #comparing }
MAAspectAccessor >> = anObject [
	^ super = anObject
		and: [ self aspectName = anObject aspectName ]
]

{ #category : #accessing }
MAAspectAccessor >> aspectName [

	^ aspectName
]

{ #category : #accessing }
MAAspectAccessor >> aspectName: anObject [

	aspectName := anObject
]

{ #category : #testing }
MAAspectAccessor >> canRead: aModel [
	^ self aspectName notNil and: [ aModel description hasAspectNamed: aspectName ]
]

{ #category : #testing }
MAAspectAccessor >> canWrite: aModel [
	^ self aspectName notNil and: [ aModel description hasAspectNamed: aspectName ]
]

{ #category : #accessing }
MAAspectAccessor >> defaultLabelFor: aDescription [
	^ self aspectName asString normalizeCamelCase capitalized
]

{ #category : #'accessing-magritte' }
MAAspectAccessor >> descriptionAspectName [
	<magritteDescription>
	^ MASymbolDescription new
			accessor: #aspectName;
			yourself
]

{ #category : #testing }
MAAspectAccessor >> handlesSelector: aSelector [
	^ aSelector = self aspectName 
]

{ #category : #comparing }
MAAspectAccessor >> hash [
	^  super hash bitXor: self aspectName hash 
]

{ #category : #model }
MAAspectAccessor >> read: aModel [
	^ aModel perform: aspectName
]

{ #category : #'accessing-dynamic' }
MAAspectAccessor >> selector [
	^ self aspectName
]

{ #category : #'accessing-dynamic' }
MAAspectAccessor >> selector: aSelector [ 
	self aspectName: aSelector asSymbol.

]

{ #category : #printing }
MAAspectAccessor >> storeOn: aStream [
	aStream nextPut: $(.
	self class storeOn: aStream.
	aStream space.
	aStream nextPutAll: 'aspectName: '.
	aspectName storeOn: aStream.
	aStream nextPut: $)
]

{ #category : #model }
MAAspectAccessor >> write: anObject to: aModel [
	^ aModel perform: (aspectName asMutator) with: anObject
]
