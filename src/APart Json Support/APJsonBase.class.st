"
I am the abstract base class for reading and writing JSON data. My subclasses substitute those classes that parsers normally use to represent the object tree 
(Association -> APJsonProperty, Dictionary -> APJsonObject, SequenceableCollection -> APJsonCollection).
"
Class {
	#name : #APJsonBase,
	#superclass : #Object,
	#instVars : [
		'wantsNewline'
	],
	#category : #'APart Json Support'
}

{ #category : #'instance creation' }
APJsonBase class >> create [

	^self basicNew initialize
]

{ #category : #API }
APJsonBase class >> durationFromJsonValue: aNumVal [

	^aNumVal
		ifNotNil: 
			[(aNumVal isKindOf: Number)
				ifTrue: [Duration period: aNumVal scale: 1]
				ifFalse: 
					[self error: 'Invalid JSON value for Duration: ' , aNumVal printString]]
]

{ #category : #API }
APJsonBase class >> jsonStringForValue: v [

	| s |
	v isNil ifTrue: [^nil].
	s := WriteStream on: String new.
	v printJsonOn: s.
	^s contents
]

{ #category : #API }
APJsonBase class >> timestampFromJsonValue: aString [

	^Timestamp readFromPlainIso8601: aString
]

{ #category : #comparing }
APJsonBase >> = other [

	^self species = other species and: [ self hasSameValuesAs: other ]
]

{ #category : #API }
APJsonBase >> atName: aName [

	self subclassResponsibility 
]

{ #category : #API }
APJsonBase >> atName: aName ifAbsent: aBlock [

	self subclassResponsibility 
]

{ #category : #API }
APJsonBase >> atPath: aPath [
	
	^ self atPath: aPath ifAbsent: [ self aPartError: #missingJSONProperty ]
]

{ #category : #API }
APJsonBase >> atPath: aPath ifAbsent: aBlock [

	| pathArray |
	
	pathArray := aPath isArray ifTrue: aPath ifFalse: [ Array with: aPath ].
	
	^ pathArray size = 1
		ifTrue: [ self atName: pathArray first ifAbsent: aBlock ]
		ifFalse: [ (self atName: pathArray first ifAbsent: aBlock) atPath: pathArray allButFirst ifAbsent: aBlock] 
]

{ #category : #API }
APJsonBase >> atPath: path put: anObject [

	^ self atPath: path put: anObject ifWrongPath: [ self aPartError: #missingJSONProperty ]
]

{ #category : #API }
APJsonBase >> atPath: path put: anObject ifWrongPath: aBlock [

	| pathArray |
	
	pathArray := path isArray ifTrue: path ifFalse: [ Array with: path ].

	^ pathArray size = 1 
		ifTrue: [ 
			| jsonObject |
			jsonObject := anObject asJsonObject.
			self at: pathArray first put: jsonObject.
			jsonObject ]
		ifFalse: [ 
			(self atName: pathArray first ifAbsent: aBlock) atPath: (pathArray allButFirst) put: anObject ifWrongPath: aBlock ]
	
	
]

{ #category : #private }
APJsonBase >> canDirectlyPrint: aValue [

	^(aValue isKindOf: Number)
		or: [(aValue isKindOf: Boolean) or: [aValue isNil]]
]

{ #category : #copying }
APJsonBase >> deepCopy [

	^(self class create)
		wantsNewline: wantsNewline;
		yourself
]

{ #category : #comparing }
APJsonBase >> hasSameValuesAs: other [
	
	self subclassResponsibility 
]

{ #category : #comparing }
APJsonBase >> hash [
	"Necessary because of implementing #= "
	
	self subclassResponsibility 
]

{ #category : #converting }
APJsonBase >> isAPJson [

	^true
]

{ #category : #private }
APJsonBase >> printIndent: indentCount on: s [

	indentCount timesRepeat: [s tab]
]

{ #category : #private }
APJsonBase >> printJsonKey: aString on: aStream [

	aStream
		nextPut: $";
		nextPutAll: aString;
		nextPut: $";
		nextPut: $:
]

{ #category : #API }
APJsonBase >> printJsonOn: aStream [

	self subclassResponsibility
]

{ #category : #private }
APJsonBase >> printJsonValue: value on: aStream [

	(self canDirectlyPrint: value) ifTrue: [^value printOn: aStream].
	value printJsonOn: aStream
]

{ #category : #accessing }
APJsonBase >> wantsNewline [

	^wantsNewline == true
]

{ #category : #accessing }
APJsonBase >> wantsNewline: aBoolean [

	wantsNewline := aBoolean
]
