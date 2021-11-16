"
I am an association of a key and a value for a property slot of an object. Automatic conversion of String values to Symbol is provided if the holding object requires that (without affecting the printed JSON String).
"
Class {
	#name : #APJsonProperty,
	#superclass : #APJsonBase,
	#instVars : [
		'key',
		'value'
	],
	#category : #'APart Json Support'
}

{ #category : #'instance creation' }
APJsonProperty class >> key: aKey value: aValue [

	^(self new)
		key: aKey;
		value: aValue;
		yourself
]

{ #category : #copying }
APJsonProperty >> deepCopy [

	| myCopy |
	myCopy := super deepCopy.
	myCopy key: key.
	myCopy value: value copy.
	^myCopy
]

{ #category : #comparing }
APJsonProperty >> hasSameValuesAs: other [
	
	^key = other key and: [ value = other value ]
]

{ #category : #comparing }
APJsonProperty >> hash [
	"Necessary because of implementing #= "
	
	^(self species hash bitXor: key hash) bitXor: value hash
]

{ #category : #API }
APJsonProperty >> isVolatile [

	^false
]

{ #category : #accessing }
APJsonProperty >> key [

	^key
]

{ #category : #accessing }
APJsonProperty >> key: anObject [

	key := anObject
]

{ #category : #API }
APJsonProperty >> makeSymbolKey [

	key := key asSymbol
]

{ #category : #API }
APJsonProperty >> printJsonIncludingNilOn: aStream [

	| shallPrintNewline |
	shallPrintNewline := (value respondsTo: #wantsNewline)
				and: [value wantsNewline].
	self printJsonKey: key on: aStream.
	shallPrintNewline ifTrue: [aStream cr].
	self printJsonValue: value on: aStream.
	shallPrintNewline ifTrue: [aStream cr]
]

{ #category : #API }
APJsonProperty >> printJsonOn: aStream [

	self printJsonIncludingNilOn: aStream
]

{ #category : #printing }
APJsonProperty >> printOn: s [

	super printOn: s.
	self printPreviewOn: s indent: 0
]

{ #category : #printing }
APJsonProperty >> printPreviewOn: s indent: indent [

	key isNil ifTrue: [^self].
	self printIndent: indent on: s.
	self isVolatile
		ifTrue: [s nextPutAll: ' (#']
		ifFalse: [s nextPutAll: ' ("'].
	s nextPutAll: key.
	self isVolatile ifFalse: [s nextPut: $"].
	s
		nextPut: $:;
		space.
	(value respondsTo: #printPreviewOn:indent:)
		ifTrue: 
			[value printPreviewOn: s indent: indent + 1.
			self printIndent: indent on: s]
		ifFalse: [value printOn: s].
	s
		nextPut: $);
		cr
]

{ #category : #accessing }
APJsonProperty >> value [

	^value
]

{ #category : #accessing }
APJsonProperty >> value: anObject [

	value := anObject
]
