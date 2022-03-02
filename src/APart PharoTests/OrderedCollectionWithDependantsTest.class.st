Class {
	#name : #OrderedCollectionWithDependantsTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
OrderedCollectionWithDependantsTest >> testAddAll [ 

	| aCollection dependant |
	
	aCollection := OrderedCollectionWithDependants new.
	dependant := OrderedCollectionWithDependantsTestDependent new.
	aCollection addDependent: dependant.
	aCollection addAll: #(a b c).
	self assert: dependant lastAspect equals: #appendCollection:.
	self assert: dependant changes equals: 3 
]

{ #category : #tests }
OrderedCollectionWithDependantsTest >> testAddLast [ 

	| aCollection dependant |
	
	aCollection := OrderedCollectionWithDependants new.
	dependant := OrderedCollectionWithDependantsTestDependent new.
	aCollection addDependent: dependant.
	aCollection addLast: #a.
	self assert: dependant lastAspect equals: #insert:.
	self assert: dependant changes equals: 1.
	aCollection addLast: #b.
	self assert: dependant lastAspect equals: #insert:.
	self assert: dependant changes equals: 2
]

{ #category : #tests }
OrderedCollectionWithDependantsTest >> testAsOrderedCollectionWithDependants [

	| aCollection dependant |
	
	aCollection := #(a b c) asOrderedCollectionWithDependants.
	dependant := OrderedCollectionWithDependantsTestDependent new.
	aCollection addDependent: dependant.
	aCollection addLast: #d.
	self assert: dependant lastAspect equals: #insert:.
	self assert: dependant changes equals: 4
]

{ #category : #tests }
OrderedCollectionWithDependantsTest >> testAtPut [

	| aCollection dependant |
	
	aCollection := OrderedCollectionWithDependants new.
	dependant := OrderedCollectionWithDependantsTestDependent new.
	aCollection addDependent: dependant.
	aCollection addAll: #(a b c).
	aCollection at: 2 put: #d.
	self assert: dependant lastAspect equals: #at:.
	self assert: dependant changes equals: 2
]

{ #category : #tests }
OrderedCollectionWithDependantsTest >> testRemoveIfAbsent [

	| aCollection dependant returned |
	
	aCollection := #(a b c) asOrderedCollectionWithDependants.
	dependant := OrderedCollectionWithDependantsTestDependent new.
	aCollection addDependent: dependant.
	returned := aCollection remove: #c ifAbsent: [ #missing ].
	self assert: dependant lastAspect equals: #remove:.
	self assert: dependant changes equals: #c.
	returned := aCollection remove: #e ifAbsent: [ #missing ].
	self assert: dependant lastAspect equals: #remove:.
	self assert: dependant changes equals: #e.
	self assert: returned equals: #missing.
]

{ #category : #tests }
OrderedCollectionWithDependantsTest >> testRemoveLast [

	| aCollection dependant returned |
	
	aCollection := #(a b c) asOrderedCollectionWithDependants.
	dependant := OrderedCollectionWithDependantsTestDependent new.
	aCollection addDependent: dependant.
	returned := aCollection removeLast.
	self assert: dependant lastAspect equals: #remove:.
	self assert: dependant changes equals: 3.
]
