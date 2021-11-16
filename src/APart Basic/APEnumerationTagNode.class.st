"
APEnumerationTagNode

"
Class {
	#name : #APEnumerationTagNode,
	#superclass : #Object,
	#instVars : [
		'parentNode',
		'childrenNodes',
		'childrenKeys',
		'tag'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #'instance creation' }
APEnumerationTagNode class >> on: aParentNodeOrNil tag: aSymbol [

	^self new initOn: aParentNodeOrNil tag: aSymbol.
]

{ #category : #accessing }
APEnumerationTagNode >> addKey: aKey toTagPath: aTagPath [

	| childNode |
	aTagPath isEmpty
		ifTrue: [childrenKeys add: aKey]
		ifFalse: 
			[childNode := childrenNodes detect: [:node | node tag = aTagPath first]
						ifNone: 
							[childrenNodes
								add: (self class on: self tag: aTagPath first)].
			childNode addKey: aKey toTagPath: (aTagPath copy removeFirst; yourself)]
]

{ #category : #accessing }
APEnumerationTagNode >> childrenKeys [

	^childrenKeys
]

{ #category : #accessing }
APEnumerationTagNode >> childrenKeys: anObject [

	childrenKeys := anObject
]

{ #category : #accessing }
APEnumerationTagNode >> childrenNodes [

	^childrenNodes
]

{ #category : #accessing }
APEnumerationTagNode >> childrenNodes: anObject [

	childrenNodes := anObject
]

{ #category : #'initialize-release' }
APEnumerationTagNode >> initOn: aParentNodeOrNil tag: aSymbol [

	parentNode := aParentNodeOrNil.
	tag := aSymbol.
	self initialize.
]

{ #category : #'initialize-release' }
APEnumerationTagNode >> initialize [

	childrenKeys := OrderedCollection new.
	childrenNodes := OrderedCollection new
]

{ #category : #accessing }
APEnumerationTagNode >> parentNode [

	^parentNode
]

{ #category : #accessing }
APEnumerationTagNode >> parentNode: anObject [

	parentNode := anObject
]

{ #category : #printing }
APEnumerationTagNode >> printOn: s [

	<ignoreForCoverage>
	super printOn: s.
	tag notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: tag printString;
				nextPut: $)].
	childrenKeys size > 0
		ifTrue: 
			[s
				nextPut: ${;
				nextPutAll: childrenKeys size printString;
				nextPutAll: ' childrenKeys}']
]

{ #category : #accessing }
APEnumerationTagNode >> tag [

	^tag
]

{ #category : #accessing }
APEnumerationTagNode >> tag: anObject [

	tag := anObject
]
