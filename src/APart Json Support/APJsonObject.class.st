"
I represent a structured object as JSON. I use an OrderedCollection of APJsonProperty objects.
"
Class {
	#name : #APJsonObject,
	#superclass : #APJsonBase,
	#instVars : [
		'properties',
		'shallUseSymbolKeys',
		'key'
	],
	#category : #'APart Json Support'
}

{ #category : #accessing }
APJsonObject class >> at: aKey put: aValue [

	^self create
		at: aKey put: aValue;
		yourself
]

{ #category : #'instance creation' }
APJsonObject class >> key: aKey [

	^(self create)
		key: aKey;
		yourself
]

{ #category : #'instance creation' }
APJsonObject class >> onAllInstanceVariablesOf: anObject [

	| result |
	result := self create.
	anObject class instVarNames
		doWithIndex: [:ivarName :i | result at: ivarName putIfNotNil: (anObject instVarAt: i)].
	^result
]

{ #category : #'instance creation' }
APJsonObject class >> with: el1 [

	^self withAll: (Array with: el1)
]

{ #category : #'instance creation' }
APJsonObject class >> with: el1 with: el2 [

	^self withAll: (Array with: el1 with: el2)
]

{ #category : #'instance creation' }
APJsonObject class >> with: el1 with: el2 with: el3 [

	^self withAll: (Array with: el1 with: el2 with: el3)
]

{ #category : #'instance creation' }
APJsonObject class >> with: el1 with: el2 with: el3 with: el4 [

	^self withAll: (Array
				with: el1
				with: el2
				with: el3
				with: el4)
]

{ #category : #'instance creation' }
APJsonObject class >> withAll: someElements [

	^(self create)
		addAll: someElements;
		yourself
]

{ #category : #API }
APJsonObject >> add: aProperty [

	^properties add: aProperty
]

{ #category : #API }
APJsonObject >> addAll: aPropertyColl [

	^properties addAll: aPropertyColl
]

{ #category : #API }
APJsonObject >> at: aKey [

	^self at: aKey ifAbsent: []
]

{ #category : #API }
APJsonObject >> at: aKey collectJsonIfNotEmpty: plainCollection [

	plainCollection isEmpty ifTrue: [^nil].
	^APJsonCollection collectJsonObjectsFrom: plainCollection
]

{ #category : #API }
APJsonObject >> at: aKey ifAbsent: absentBlock [

	properties do: [:p | p key = aKey ifTrue: [^p value]].
	^absentBlock value
]

{ #category : #API }
APJsonObject >> at: aKey ifAbsent: absentBlock ifPresent: presentBlock [

	properties do: [:p | p key = aKey ifTrue: [^presentBlock value: p value]].
	^absentBlock value
]

{ #category : #API }
APJsonObject >> at: aKey ifAbsentPut: absentBlock [

	^self at: aKey
		ifAbsent: 
			[| v |
			v := absentBlock value.
			properties add: (APJsonProperty key: aKey value: v).
			v]
]

{ #category : #API }
APJsonObject >> at: aKey ifPresent: presentBlock [

	properties do: [:p | p key = aKey ifTrue: [^presentBlock value: p value]].
	^nil
]

{ #category : #API }
APJsonObject >> at: aKey ifPresent: presentBlock ifAbsent: absentBlock [
	
	^ self at: aKey ifAbsent: absentBlock ifPresent: presentBlock
]

{ #category : #API }
APJsonObject >> at: aKey put: aValue [

	properties do: 
			[:p |
			p key = aKey
				ifTrue: 
					[p value: aValue.
					^aValue]].
	properties add: (APJsonProperty key: aKey value: aValue).
	^aValue
]

{ #category : #API }
APJsonObject >> at: aKey putIfNotNil: aValue [

	^aValue ifNotNil: [self at: aKey put: aValue]
]

{ #category : #API }
APJsonObject >> at: aKey putVolatile: aValue [

	aKey isSymbol ifFalse: [self error: 'Expecting Symbol key for volatile property'].
	self
		at: aKey
		ifAbsent: [properties add: (APJsonPropertyVolatile key: aKey value: aValue)]
		ifPresent: 
			[:property |
			property isVolatile
				ifFalse: [self error: 'Should not mix volatile and normal properties'].
			property value: aValue].
	^aValue
]

{ #category : #API }
APJsonObject >> atName: aKey [

	^self atName: aKey ifAbsent: [ self aPartError: #missingJSONProperty ]
]

{ #category : #API }
APJsonObject >> atName: aKey ifAbsent: aBlock [

	^self at: aKey ifAbsent: aBlock
]

{ #category : #API }
APJsonObject >> buildInstance: instCreateBlock forBaseClass: aBaseClass [

	^self
		buildInstance: instCreateBlock
		forBaseClass: aBaseClass
		use: APJsonObject create
		logTo: [:reason :jso |
			self
				error: 'Error when trying to build instance of ' , aBaseClass name
						, ' from json, reason: ' , reason printString
						, ', json: ' , jso printString]
]

{ #category : #API }
APJsonObject >> buildInstance: instCreateBlock forBaseClass: aBaseClass use: additionalProperties [

	^self
		buildInstance: instCreateBlock
		forBaseClass: aBaseClass
		use: additionalProperties
		logTo: 
			[:reason :jso |
			self
				error: 'Error when trying to build instance of ' , aBaseClass name
						, ' from json, reason: ' , reason printString
						, ', json: ' , jso printString]
]

{ #category : #API }
APJsonObject >> buildInstance: instCreateBlock forBaseClass: aBaseClass use: additionalProperties logTo: aLoggingBlock [

	| clsName instantiationClass inst |
	clsName := self at: aBaseClass jsonClassIdentifier
				ifAbsent: 
					[aLoggingBlock value: 'Missing ' , aBaseClass jsonClassIdentifier
						value: self.
					^nil].
	instantiationClass := (Smalltalk at: clsName asSymbol ifAbsent: [])
				ifNotNil: [:cls | (cls allSuperclasses includes: aBaseClass) ifTrue: [cls]].
	instantiationClass isNil
		ifTrue: 
			[aLoggingBlock
				value: 'Invalid instantiationClass class ' , clsName printString
				value: self.
			^nil].
	inst := (instCreateBlock value: instantiationClass)
				initOnJsonObject: self
				use: additionalProperties
				logTo: 
					[:reason :jsonObj |
					aLoggingBlock value: reason value: jsonObj.
					^nil].
	^inst
]

{ #category : #API }
APJsonObject >> buildInstanceForBaseClass: aBaseClass [

	^self buildInstance: [:instCl | instCl new initialize]
		forBaseClass: aBaseClass
]

{ #category : #API }
APJsonObject >> buildInstanceForBaseClass: aBaseClass use: additionalProperties logTo: aLoggingBlock [

	^self
		buildInstance: [:instClass | instClass new]
		forBaseClass: aBaseClass
		use: additionalProperties
		logTo: aLoggingBlock
]

{ #category : #copying }
APJsonObject >> deepCopy [

	| myCopy |
	myCopy := super deepCopy.
	myCopy key: key.
	myCopy shallUseSymbolKeys: shallUseSymbolKeys.
	myCopy addAll: (properties collect: [:e | e deepCopy]).
	^myCopy
]

{ #category : #API }
APJsonObject >> downToAllNodesMatching: matchingBlock doWithResult: othersBlock targetDoWithResult: targetBlock using: result parentChain: parentChain [

	(matchingBlock value: self)
		ifTrue: [targetBlock value: self value: parentChain value: result]
		ifFalse: 
			[| branchResult |
			branchResult := othersBlock value: self value: parentChain value: result.
			parentChain add: self.
			self subObjectsDo: 
					[:subnode |
					subnode
						downToAllNodesMatching: matchingBlock
						doWithResult: othersBlock
						targetDoWithResult: targetBlock
						using: branchResult
						parentChain: parentChain].
			parentChain removeLast].
	^result
]

{ #category : #comparing }
APJsonObject >> hasSameValuesAs: other [
	
	self size = other size ifFalse: [ ^false ].
	self keysAndValuesDo: [ :k :v | 
		(other at: k ifAbsent: [ false ] ifPresent: [ :otherVal | otherVal = v ])
			ifFalse: [ ^false ].
	].
	^true
]

{ #category : #comparing }
APJsonObject >> hash [
	
	| h |
	h := self species hash.
	self keysAndValuesDo: [ :k :v | 
		h := (h bitXor: k hash) bitXor: v hash
	].
	^h
]

{ #category : #private }
APJsonObject >> indexForKey: aKey [

	properties doWithIndex: [:p :i | p key = aKey ifTrue: [^i]].
	^nil
]

{ #category : #'initialize-release' }
APJsonObject >> initialize [

	properties := OrderedCollection new.
	shallUseSymbolKeys := false.
]

{ #category : #API }
APJsonObject >> isEmpty [

	^self size = 0
]

{ #category : #API }
APJsonObject >> isJsonObject [

	^true
]

{ #category : #'API Property' }
APJsonObject >> isVolatile [

	^false
]

{ #category : #accessing }
APJsonObject >> key [

	^key
]

{ #category : #accessing }
APJsonObject >> key: anObject [

	key := anObject
]

{ #category : #API }
APJsonObject >> keysAndValuesDo: aBlock [

	properties do: [:p | aBlock value: p key value: p value]
]

{ #category : #API }
APJsonObject >> makeSymbolKey [

	key := key asSymbol
]

{ #category : #'API Property' }
APJsonObject >> printJsonIncludingNilOn: aStream [

	self printJsonKey: key on: aStream.
	wantsNewline == true ifTrue: [aStream cr].
	self printJsonOn: aStream.
	wantsNewline == true ifTrue: [aStream cr]
]

{ #category : #API }
APJsonObject >> printJsonOn: aStream [

	| propsToPrint |
	key notNil
		ifTrue: 
			[ aStream position > 0 ifTrue: [aStream space].
			self printJsonKey: key on: aStream].
	aStream position > 0 ifTrue: [aStream space].
	aStream nextPut: ${.
	propsToPrint := properties reject: [:p | p isVolatile or: [p value isNil]].
	propsToPrint do: [:e | e printJsonOn: aStream]
		separatedBy: [aStream nextPut: $,].
	aStream nextPut: $}
]

{ #category : #printing }
APJsonObject >> printOn: s [

	super printOn: s.
	key notNil ifTrue: [s nextPutAll: '{PropertyWithObject}'].
	properties size > 0
		ifTrue: [self printPreviewOn: s indent: 0]
		ifFalse: 
			[key notNil
				ifTrue: 
					[s
						nextPutAll: ' ("';
						nextPutAll: key;
						nextPutAll: '": {} )';
						cr]]
]

{ #category : #printing }
APJsonObject >> printPreviewOn: s indent: indent [

	key notNil
		ifTrue: 
			[self printIndent: indent on: s.
			s
				nextPutAll: ' ("';
				nextPutAll: key;
				nextPutAll: '":'.
			self printPropertiesPreviewOn: s indent: indent + 1.
			self printIndent: indent on: s.
			s
				nextPut: $);
				cr]
		ifFalse: [self printPropertiesPreviewOn: s indent: indent]
]

{ #category : #printing }
APJsonObject >> printPropertiesPreviewOn: s indent: indent [

	| propsToPrint restProps |
	propsToPrint := 5.
	s cr.
	1 to: (properties size min: propsToPrint)
		do: [:i | (properties at: i) printPreviewOn: s indent: indent].
	restProps := properties size - propsToPrint.
	restProps > 0
		ifTrue: 
			[self printIndent: indent on: s.
			s
				nextPut: $(;
				nextPutAll: restProps printString;
				nextPutAll: ' more properties exist)';
				cr]
]

{ #category : #'initialize-release' }
APJsonObject >> properties: anObject [

	properties := anObject
]

{ #category : #API }
APJsonObject >> propertiesDo: aBlock [

	properties do: aBlock
]

{ #category : #API }
APJsonObject >> removeAllProperties [

	properties := OrderedCollection new
]

{ #category : #API }
APJsonObject >> removeKey: aKey [

	^ self removeKey: aKey ifAbsent: []
]

{ #category : #API }
APJsonObject >> removeKey: aKey ifAbsent: absentBlock [

	^ (self indexForKey: aKey)
		ifNotNil: [:i | properties removeAt: i]
		ifNil: absentBlock
]

{ #category : #accessing }
APJsonObject >> shallUseSymbolKeys [

	^shallUseSymbolKeys
]

{ #category : #accessing }
APJsonObject >> shallUseSymbolKeys: anObject [

	shallUseSymbolKeys := anObject
]

{ #category : #accessing }
APJsonObject >> size [

	^properties size
]

{ #category : #API }
APJsonObject >> subObjectsDo: aBlock [

	properties do: [:p | (p isKindOf: self class) ifTrue: [aBlock value: p]]
]

{ #category : #roassal2 }
APJsonObject >> value [

	^key notNil ifTrue: [self]
]
