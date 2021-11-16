"
I represent a JSON Array, but internally use an OrderedCollection for better efficiency.
"
Class {
	#name : #APJsonCollection,
	#superclass : #APJsonBase,
	#instVars : [
		'elements'
	],
	#category : #'APart Json Support'
}

{ #category : #'instance creation' }
APJsonCollection class >> collectJsonObjectsFrom: plainCollection [

	^self withAll: (plainCollection collect: [:o | o asJsonObject])
]

{ #category : #'instance creation' }
APJsonCollection class >> with: jsonObj [

	^(self create)
		add: jsonObj;
		yourself
]

{ #category : #'instance creation' }
APJsonCollection class >> withAll: collOfJson [

	^(self create)
		addAll: collOfJson;
		yourself
]

{ #category : #API }
APJsonCollection >> add: aJsonObj [

	elements add: aJsonObj
]

{ #category : #API }
APJsonCollection >> addAll: collOfJson [

	elements addAll: collOfJson
]

{ #category : #API }
APJsonCollection >> allSatisfy: aBlock [

	^elements allSatisfy: aBlock
]

{ #category : #API }
APJsonCollection >> asArray [

	^elements asArray
]

{ #category : #accessing }
APJsonCollection >> at: anIndex [

	^self at: anIndex ifAbsent: []
]

{ #category : #API }
APJsonCollection >> at: anIndex ifAbsent: absentBlock [

	(anIndex between: 1 and: elements size) ifFalse: [^absentBlock value].
	^elements at: anIndex
]

{ #category : #accessing }
APJsonCollection >> at: anIndex put: aJsonObject [

	^elements at: anIndex put: aJsonObject
]

{ #category : #accessing }
APJsonCollection >> atName: aName [

	^ self atName: aName ifAbsent: [ self aPartError: #missingJSONProperty ]

]

{ #category : #accessing }
APJsonCollection >> atName: aName ifAbsent: aBlock [

	^ self detect: [ :each | (each atName: #name) = aName ] ifNone: aBlock

]

{ #category : #API }
APJsonCollection >> collect: aBlock [

	^elements collect: aBlock
]

{ #category : #copying }
APJsonCollection >> deepCopy [

	| myCopy |
	myCopy := super deepCopy.
	myCopy addAll: (elements collect: [:e | e deepCopy]).
	^myCopy
]

{ #category : #API }
APJsonCollection >> detect: aBlock [

	^elements detect: aBlock
]

{ #category : #API }
APJsonCollection >> detect: aBlock ifNone: absentBlock [

	^elements detect: aBlock ifNone: absentBlock
]

{ #category : #API }
APJsonCollection >> do: aBlock [

	elements do: aBlock
]

{ #category : #API }
APJsonCollection >> do: aBlock separatedBy: sepBlock [

	elements do: aBlock separatedBy: sepBlock
]

{ #category : #API }
APJsonCollection >> doWithIndex: aBlock [

	elements doWithIndex: aBlock
]

{ #category : #API }
APJsonCollection >> first [

	^elements first
]

{ #category : #comparing }
APJsonCollection >> hasSameValuesAs: other [
	
	self size = other size ifFalse: [ ^false ].
	self doWithIndex: [ :val :i |
		val = (other at: i) ifFalse: [ ^false ].
	].
	^true
]

{ #category : #comparing }
APJsonCollection >> hash [
	"Necessary because of implementing #= "
	
	| h |
	h := self species hash.
	self do: [ :obj |
		h := h bitXor: obj hash.
	].
	^h
]

{ #category : #'initialize-release' }
APJsonCollection >> initialize [

	elements := OrderedCollection new
]

{ #category : #API }
APJsonCollection >> inject: val into: binaryBlock [

	^elements inject: val into: binaryBlock
]

{ #category : #API }
APJsonCollection >> isEmpty [

	^self size = 0
]

{ #category : #testing }
APJsonCollection >> isJsonCollection [

	^true
]

{ #category : #API }
APJsonCollection >> last [

	^elements last
]

{ #category : #API }
APJsonCollection >> printJsonOn: aStream [

	| shallPrintNewline |
	aStream
		space;
		nextPut: $[.
	shallPrintNewline := elements notEmpty and: 
					[(elements last respondsTo: #wantsNewLine)
						and: [elements last wantsNewline]].
	shallPrintNewline ifTrue: [aStream cr].
	elements do: 
			[:e |
			shallPrintNewline ifTrue: [aStream cr].
			self printJsonValue: e on: aStream]
		separatedBy: 
			[aStream nextPut: $,.
			shallPrintNewline ifTrue: [aStream cr]].
	aStream nextPut: $].
	self wantsNewline ifTrue: [aStream cr]
]

{ #category : #printing }
APJsonCollection >> printOn: s [

	super printOn: s.
	elements size > 0
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: elements size printString;
				nextPutAll: ' elements)']
]

{ #category : #API }
APJsonCollection >> reject: aBlock [

	^elements reject: aBlock
]

{ #category : #API }
APJsonCollection >> select: aBlock [

	^elements select: aBlock
]

{ #category : #accessing }
APJsonCollection >> size [

	^elements size
]

{ #category : #API }
APJsonCollection >> withIndexCollect: aBlock [

	^elements withIndexCollect: aBlock
]
