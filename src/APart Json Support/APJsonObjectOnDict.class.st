"
As opposed to my superclass, I use a Dictionary for holding my properties.
"
Class {
	#name : #APJsonObjectOnDict,
	#superclass : #APJsonObject,
	#category : #'APart Json Support'
}

{ #category : #API }
APJsonObjectOnDict >> at: aKey ifAbsent: absentBlock [

	^properties at: aKey ifAbsent: absentBlock
]

{ #category : #API }
APJsonObjectOnDict >> at: aKey ifAbsent: absentBlock ifPresent: presentBlock [

	properties at: aKey ifPresent: [:v | ^presentBlock value: v].
	^absentBlock value
]

{ #category : #API }
APJsonObjectOnDict >> at: aKey ifAbsentPut: absentBlock [

	^properties at: aKey ifAbsentPut: absentBlock
]

{ #category : #API }
APJsonObjectOnDict >> at: aKey ifPresent: presentBlock [

	^properties at: aKey ifPresent: presentBlock
]

{ #category : #API }
APJsonObjectOnDict >> at: aKey put: aValue [

	^properties at: aKey put: aValue
]

{ #category : #copying }
APJsonObjectOnDict >> deepCopy [

	| myCopy |
	myCopy := super deepCopy.
	properties keysAndValuesDo: [:k :v | self at: k put: v copy].
	^myCopy
]

{ #category : #'initialize-release' }
APJsonObjectOnDict >> initialize [

	properties := Dictionary new.
	shallUseSymbolKeys := true
]

{ #category : #API }
APJsonObjectOnDict >> keysAndValuesDo: aBlock [

	properties keysAndValuesDo: aBlock
]

{ #category : #API }
APJsonObjectOnDict >> printJsonOn: aStream [

	| jsonProps |
	aStream
		space;
		nextPut: ${.
	jsonProps := OrderedCollection new: properties size.
	properties
		keysAndValuesDo: [:k :v | jsonProps add: (APJsonProperty key: k value: v)].
	jsonProps do: [:e | e printJsonIncludingNilOn: aStream]
		separatedBy: [aStream nextPut: $,].
	aStream nextPut: $}
]

{ #category : #API }
APJsonObjectOnDict >> removeAllProperties [

	properties := Dictionary new
]

{ #category : #API }
APJsonObjectOnDict >> removeKey: aKey ifAbsent: absentBlock [

	^properties removeKey: aKey ifAbsent: absentBlock
]
