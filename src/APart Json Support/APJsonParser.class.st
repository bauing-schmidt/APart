"
I am a JSON parser using subclasses of APJsonBase to represent the parsed data tree.
"
Class {
	#name : #APJsonParser,
	#superclass : #Object,
	#instVars : [
		'stream',
		'shallUseDictionaries'
	],
	#category : #'APart Json Support'
}

{ #category : #'instance creation' }
APJsonParser class >> on: aStream [
	^ self basicNew initializeOn: aStream
]

{ #category : #API }
APJsonParser class >> parse: aStringOrNil [
	"[self parse: ('[{%id%:60911,%changestamp%:%abc\%de%}, {%id%:60912,%changestamp%:%2015-11-23T09:10:55.937%}]'
	copy replaceAll: $% with: (Character value: 34)) ]
	[self parse: '123']
	[self parse: '']
	"

	aStringOrNil size = 0 ifTrue: [^nil].
	^self parseStream: aStringOrNil readStream
]

{ #category : #API }
APJsonParser class >> parse: aStringOrNil handleSyntaxError: handlerBlock [
	"[self parse: ('[{%id%:60911,%changestamp%:%abc\%de%}, {%id%:60912,%changestamp%:%2015-11-23T09:10:55.937%}]'
	copy replaceAll: $% with: (Character value: 34)) ]
	[self parse: '123']
	[self parse: '']
	"

	aStringOrNil size = 0 ifTrue: [^nil].
	^[self parse: aStringOrNil] on: APJsonSyntaxError
		do: handlerBlock
]

{ #category : #API }
APJsonParser class >> parseStream: aStream [

	^(self on: aStream) parse
]

{ #category : #API }
APJsonParser class >> usingDictionariesParse: aStringOrNil [
	"[self usingDictionariesParse: ('[{%id%:60911,%changestamp%:%abc\%de%}, {%id%:60912,%changestamp%:%2015-11-23T09:10:55.937%}]'
	copy replaceAll: $% with: (Character value: 34)) ]
	[self parse: '123']
	[self parse: '']
	"

	aStringOrNil size = 0 ifTrue: [^nil].
	^self usingDictionariesParseStream: aStringOrNil readStream
]

{ #category : #API }
APJsonParser class >> usingDictionariesParseStream: aStream [

	^(self on: aStream) useDictionaries parse
]

{ #category : #adding }
APJsonParser >> addProperty: aProperty to: anObject [

	shallUseDictionaries
		ifTrue: [anObject at: aProperty key put: aProperty value]
		ifFalse: 
			[anObject shallUseSymbolKeys ifTrue: [aProperty makeSymbolKey].
			anObject add: aProperty].
	^anObject
]

{ #category : #adding }
APJsonParser >> addValue: anObject to: aCollection [

	aCollection add: anObject.
	^aCollection
]

{ #category : #private }
APJsonParser >> consumeWhitespace [

	[stream atEnd not and: [stream peek isSeparator]] whileTrue: [stream next]
]

{ #category : #creating }
APJsonParser >> createArray [

	^APJsonCollection create
]

{ #category : #creating }
APJsonParser >> createFalse [

	^false
]

{ #category : #creating }
APJsonParser >> createNull [

	^nil
]

{ #category : #creating }
APJsonParser >> createNumber: aString [

	^aString asNumber
]

{ #category : #creating }
APJsonParser >> createObject [

	^shallUseDictionaries
		ifTrue: [Dictionary new: 10]
		ifFalse: [APJsonObject create]
]

{ #category : #creating }
APJsonParser >> createProperty: aKey with: aValue [

	^APJsonProperty key: aKey value: aValue
]

{ #category : #creating }
APJsonParser >> createString: aString [

	^aString
]

{ #category : #creating }
APJsonParser >> createTrue [

	^true
]

{ #category : #private }
APJsonParser >> error: aString [

	^APJsonSyntaxError
		signal: aString , ' at position ' , stream position printString
				, ' before ' , (stream next: 30) printString
]

{ #category : #private }
APJsonParser >> expect: aString [

	^(self match: aString) ifFalse: [self error: aString , ' expected']
]

{ #category : #initialization }
APJsonParser >> initializeOn: aStream [

	self initialize.
	stream := aStream.
	shallUseDictionaries := false
]

{ #category : #private }
APJsonParser >> match: aString [

	| position |
	position := stream position.
	aString do: 
			[:each |
			(stream atEnd or: [stream next ~= each])
				ifTrue: 
					[stream position: position.
					^false]].
	self consumeWhitespace.
	^true
]

{ #category : #parsing }
APJsonParser >> parse [

	| result |
	result := self
				consumeWhitespace;
				parseValue.
	stream atEnd ifFalse: [self error: 'end of input expected'].
	^result
]

{ #category : #parsing }
APJsonParser >> parseArray [

	| result |
	self expect: '['.
	result := self createArray.
	(self match: ']') ifTrue: [^result].
	[stream atEnd] whileFalse: 
			[result := self addValue: self parseValue to: result.
			(self match: ']')
				ifTrue: [^shallUseDictionaries ifTrue: [result asArray] ifFalse: [result]].
			self expect: ','].
	self error: 'end of array expected'
]

{ #category : #'parsing-internal' }
APJsonParser >> parseCharacter [

	| char |
	(char := stream next) = $\ ifFalse: [^char].
	(char := stream next) = $" ifTrue: [^char].
	char = $\ ifTrue: [^char].
	char = $/ ifTrue: [^char].
	char = $b ifTrue: [^Character backspace].
	char = $f ifTrue: [^Character newPage].
	char = $n ifTrue: [^Character lf].
	char = $r ifTrue: [^Character cr].
	char = $t ifTrue: [^Character tab].
	char = $u ifTrue: [^self parseCharacterHex].
	self error: 'invalid escape character \' , (String with: char)
]

{ #category : #'parsing-internal' }
APJsonParser >> parseCharacterHex [

	| value |
	value := self parseCharacterHexDigit.
	3 timesRepeat: [value := (value << 4) + self parseCharacterHexDigit].
	^Character codePoint: value
]

{ #category : #'parsing-internal' }
APJsonParser >> parseCharacterHexDigit [

	| digit |
	stream atEnd
		ifFalse: 
			[digit := stream next asInteger.
			(digit between: 48 and: 57) ifTrue: [^digit - 48].	"$0 - $9"
			(digit between: 65 and: 70) ifTrue: [^digit - 55].	"$A - $F"
			(digit between: 97 and: 102) ifTrue: [^digit - 87]	"$a - $f"].
	self error: 'hex-digit expected'
]

{ #category : #'parsing-internal' }
APJsonParser >> parseNumber [

	| negated number |
	negated := stream peek = $-.
	negated ifTrue: [stream next].
	number := self parseNumberInteger.
	stream peek = $.
		ifTrue: 
			[stream next.
			number := number + self parseNumberFraction].
	(stream peek = $e or: [stream peek = $E])
		ifTrue: 
			[stream next.
			number := number * self parseNumberExponent].
	negated ifTrue: [number := number negated].
	^self
		consumeWhitespace;
		createNumber: number
]

{ #category : #'parsing-internal' }
APJsonParser >> parseNumberExponent [

	| number negated |
	number := 0.
	negated := stream peek = $-.
	(negated or: [stream peek = $+]) ifTrue: [stream next].
	[stream atEnd not and: [stream peek isDigit]]
		whileTrue: [number := 10 * number + (stream next asInteger - 48)].
	negated ifTrue: [number := number negated].
	^10 raisedTo: number
]

{ #category : #'parsing-internal' }
APJsonParser >> parseNumberFraction [

	| number power |
	number := 0.
	power := 1.0.
	[stream atEnd not and: [stream peek isDigit]] whileTrue: 
			[number := 10 * number + (stream next asInteger - 48).
			power := power * 10.0].
	^number / power
]

{ #category : #'parsing-internal' }
APJsonParser >> parseNumberInteger [

	| number |
	number := 0.
	[stream atEnd not and: [stream peek isDigit]]
		whileTrue: [number := 10 * number + (stream next asInteger - 48)].
	^number
]

{ #category : #parsing }
APJsonParser >> parseObject [

	| result |
	self expect: '{'.
	result := self createObject.
	(self match: '}') ifTrue: [^result].
	[stream atEnd] whileFalse: 
			[result := self addProperty: self parseProperty to: result.
			(self match: '}') ifTrue: [^result].
			self expect: ','].
	self error: 'end of object expected'
]

{ #category : #'parsing-internal' }
APJsonParser >> parseProperty [

	| name |
	name := self parseString.
	self expect: ':'.
	shallUseDictionaries
		ifFalse: [stream peek = ${ ifTrue: [^self parsePropertyObjectUseName: name]].
	^self createProperty: name with: self parseValue
]

{ #category : #'parsing-internal' }
APJsonParser >> parsePropertyObjectUseName: name [

	| result |
	self expect: '{'.
	result := shallUseDictionaries
				ifTrue: [Dictionary new]
				ifFalse: [APJsonObject create key: name].
	(self match: '}') ifTrue: [^result].
	[stream atEnd] whileFalse: 
			[result := self addProperty: self parseProperty to: result.
			(self match: '}') ifTrue: [^result].
			self expect: ','].
	self error: 'end of object expected'
]

{ #category : #'parsing-internal' }
APJsonParser >> parseString [

	| result |
	self expect: '"'.
	result := WriteStream on: String new.
	[stream atEnd or: [stream peek = $"]]
		whileFalse: [result nextPut: self parseCharacter].
	^self
		expect: '"';
		createString: result contents
]

{ #category : #parsing }
APJsonParser >> parseValue [

	| char |
	stream atEnd ifTrue: [self error: 'Unexpected end of stream'].
	char := stream peek.
	char = $" ifTrue: [^self parseString].
	char = $[ ifTrue: [^self parseArray].
	(char = $- or: [char between: $0 and: $9]) ifTrue: [^self parseNumber].
	char = ${ ifTrue: [^self parseObject].
	(self match: 'true') ifTrue: [^self createTrue].
	(self match: 'false') ifTrue: [^self createFalse].
	(self match: 'null') ifTrue: [^self createNull].
	self error: 'Unexpected token starting with ' , char printString
]

{ #category : #initialization }
APJsonParser >> useDictionaries [

	shallUseDictionaries := true
]
