"
I am an abstract aspect that has a name and a value adaptor
"
Class {
	#name : #APAspect,
	#superclass : #APartMember,
	#instVars : [
		'name',
		'subAdaptor'
	],
	#category : #'APart Basic-Aspects'
}

{ #category : #'instance creation' }
APAspect class >> named: aName for: anAspectAdaptor [

	^ self new 
		subAdaptor: anAspectAdaptor;
		name: aName;
		yourself.
]

{ #category : #adding }
APAspect >> addAnnouncedStatesTo: aCollection in: partInterface name: k collectAll: collectAll [
]

{ #category : #accessing }
APAspect >> asRedirectedNamed: aName on: aPart path: aPath [

	^ APRedirectedAspect named: aName on: aPart path: (aPath, {self memberName})
]

{ #category : #evaluating }
APAspect >> changed: anAspectSymbol [

	^ self subAdaptor changed: anAspectSymbol
]

{ #category : #evaluating }
APAspect >> hasAPValueAdaptor [

	^ subAdaptor isAPValueAdaptor
]

{ #category : #testing }
APAspect >> isAspect [

	^ true
]

{ #category : #testing }
APAspect >> isAutoAspect [

	^ false
]

{ #category : #testing }
APAspect >> isListHolderAspect [

	^ false
]

{ #category : #testing }
APAspect >> isRedirected [

	^ false
]

{ #category : #evaluating }
APAspect >> listHolder [ 

	^ subAdaptor listHolder
]

{ #category : #accessing }
APAspect >> memberName [

	^ self name
]

{ #category : #accessing }
APAspect >> name [
	^ name
]

{ #category : #accessing }
APAspect >> name: anObject [
	name := anObject
]

{ #category : #accessing }
APAspect >> subAdaptor [

	^ subAdaptor
]

{ #category : #accessing }
APAspect >> subAdaptor: anObject [

	subAdaptor := anObject
]

{ #category : #evaluating }
APAspect >> targetAspect [

	^ self
]

{ #category : #evaluating }
APAspect >> targetAspectIfAbsent: absentBlock [

	^ self
]

{ #category : #evaluating }
APAspect >> value [ 

	^ subAdaptor value
]

{ #category : #evaluating }
APAspect >> value: anObject [

	^ subAdaptor value: anObject
]
