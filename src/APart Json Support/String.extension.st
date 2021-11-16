Extension { #name : #String }

{ #category : #'*APart Json Support-converting' }
String >> digitCountStartingAt: startPos [

	| count |
	count := 0.
	startPos to: self size
		do: 
			[:i |
			((self at: i) between: $0 and: $9) ifFalse: [^count].
			count := count + 1].
	^count
]

{ #category : #'*APart Json Support-converting' }
String >> equalsSymbol: aSymbol [
	" 'notNil' equalsSymbol: #notNil"
	
	self size = aSymbol size ifFalse: [^false].
	1 to: self size
		do: [:i | (self at: i) == (aSymbol at: i) ifFalse: [^false]].
	^true
]

{ #category : #'*APart Json Support-converting' }
String >> equalsSymbolOrString: aSymbolOrString [

	^aSymbolOrString isSymbol
		ifTrue: [self equalsSymbol: aSymbolOrString]
		ifFalse: [self = aSymbolOrString]
]

{ #category : #'*APart Json Support-converting' }
String >> integerFromInterval: anInterval [

	| ownSize int |
	anInterval first > anInterval last ifTrue: [^nil].
	int := 0.
	ownSize := self size.
	anInterval do: 
			[:i |
			| digit |
			(i between: 1 and: ownSize) ifFalse: [^nil].
			digit := self at: i.
			(digit between: $0 and: $9) ifFalse: [^nil].
			int := int * 10 + digit digitValue].
	^int
]

{ #category : #'*APart Json Support-converting' }
String >> printCharacter: c asJsonOn: s [
	"Im Wesentlichen symmetrisch zu APJsonParser>>parseCharacter"

	| codePoint |
	c = $" ifTrue: [^s nextPutAll: '\"'].
	c = $\ ifTrue: [^s nextPutAll: '\\'].
	codePoint := c asInteger.
	codePoint < 20
		ifTrue: 
			[c = Character cr ifTrue: [^s nextPutAll: '\r'].
			c = Character lf ifTrue: [^s nextPutAll: '\n'].
			c = Character tab ifTrue: [^s nextPutAll: '\t'].
			c = Character backspace ifTrue: [^s nextPutAll: '\b'].
			c = Character newPage ifTrue: [^s nextPutAll: '\f']].
	(codePoint between: 256 and: 65535)
		ifTrue: 
			[s nextPutAll: '\u'.
			((codePoint printStringRadix: 16) allButFirst: 3) printZeroPaddedTo: 4 on: s]
		ifFalse: [s nextPut: c]
]

{ #category : #'*APart Json Support-converting' }
String >> printJsonOn: aStream [

	aStream nextPut: $".
	self do: [:c | self printCharacter: c asJsonOn: aStream].
	aStream nextPut: $"
]

{ #category : #'*APart Json Support-converting' }
String >> printZeroPaddedTo: totalSize on: aStream [

	totalSize - self size timesRepeat: [aStream nextPut: $0].
	aStream nextPutAll: self
]

{ #category : #'*APart Json Support-converting' }
String >> printZeroPaddedTo: totalSize on: aStream terminateWith: aChar [

	self = 'nil' ifTrue: [self error: 'Expecting numerical string'].
	totalSize < self size ifTrue: [self error: 'Numerical string too long'].
	self printZeroPaddedTo: totalSize on: aStream.
	aStream nextPut: aChar
]
