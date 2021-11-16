"
I compute the compiled form of the given pattern, that will be used lately by DatePatternFormatter objects.

I allow you to start by choosing any user-defined patterns for date-time formatting.

# Instance variables
	- pattern, length
		the pattern to be compiled and its length, respectively.
	- i, inQuote, count, tagcount, lastTag, prevTag, tmpBuffer
		working variables shared among messages to implement the entire feature.
	- forceStandaloneForm 
		a Boolean that tracks the form of months representation.
	- compiledCode
		stores the compiled representation of the given pattern.
		
# Pattern compilation

I strictly mimic the implementation coded in `java.text.SimpleDateFormat` by 

	1. keeping the same variable names for the sake of easier debugging;
	2. taking it apart into small messages to provide a better object-oriented style because the original code is just *one* private method.

For the sake of completeness, we report in the rest of this section the original Javadoc that explain the meaning of the compiled pattern.<br>
We report it as a whole because it is well described and its doc cannot be read outside a debugging session because it is a private method
called from the public one `applyLocalizedPattern`.

## Javadoc

Returns the compiled form of the given pattern. The syntax of the compiled pattern is:
```
CompiledPattern:
    EntryList
EntryList:
    Entry
    EntryList Entry
Entry:
    TagField
    TagField data
TagField:
    Tag Length
    TaggedData
Tag:
    pattern_char_index
    TAG_QUOTE_CHARS
Length:
    short_length
    long_length
TaggedData:
    TAG_QUOTE_ASCII_CHAR ascii_char
```
where `short_length` is an 8-bit unsigned integer between 0 and
254.  `long_length` is a sequence of an 8-bit integer 255 and a
32-bit signed integer value which is split into upper and lower
16-bit fields in two char's. <br>
`pattern_char_index` is an 8-bit
integer between 0 and 18. `ascii_char` is an 7-bit ASCII
character value. <br>
`data` depends on its Tag value.

If Length is short_length, Tag and short_length are packed in a
single char, as illustrated below.
```
    char[0] = (Tag << 8) | short_length;
```

If Length is long_length, Tag and 255 are packed in the first
char and a 32-bit integer, as illustrated below.
```
    char[0] = (Tag << 8) | 255;
    char[1] = (char) (long_length >>> 16);
    char[2] = (char) (long_length & 0xffff);
```

If Tag is a pattern_char_index, its Length is the number of
pattern characters. For example, if the given pattern is
""yyyy"", Tag is 1 and Length is 4, followed by no data.

If Tag is TAG_QUOTE_CHARS, its Length is the number of char's
following the TagField. For example, if the given pattern is
""'o''clock'"", Length is 7 followed by a char sequence of
```
o ' c l o c k
```

TAG_QUOTE_ASCII_CHAR is a special tag and has an ASCII
character in place of Length. For example, if the given pattern
is ""'o'"", the TaggedData entry is
```
((TAG_QUOTE_ASCII_CHAR << 8) | 'o')
"
Class {
	#name : #DatePatternCompiler,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'length',
		'inQuote',
		'count',
		'tagcount',
		'lastTag',
		'prevTag',
		'tmpBuffer',
		'forceStandaloneForm',
		'compiledCode',
		'i'
	],
	#category : #'APart Localization'
}

{ #category : #constants }
DatePatternCompiler class >> datetimePatternTags [
	^ Dictionary new
		at: 'TAG_QUOTE_ASCII_CHAR' put: 100;
		at: 'TAG_QUOTE_CHARS' put: 101;
		yourself
]

{ #category : #constants }
DatePatternCompiler class >> datetimePatterns [
	^ Dictionary new
		at: 'PATTERN_ERA' put: 0;
		"G"
			at: 'PATTERN_YEAR' put: 1;
		"y"
			at: 'PATTERN_MONTH' put: 2;
		"M"
			at: 'PATTERN_DAY_OF_MONTH' put: 3;
		"d"
			at: 'PATTERN_HOUR_OF_DAY1' put: 4;
		"k"
			at: 'PATTERN_HOUR_OF_DAY0' put: 5;
		"H"
			at: 'PATTERN_MINUTE' put: 6;
		"m"
			at: 'PATTERN_SECOND' put: 7;
		"s"
			at: 'PATTERN_MILLISECOND' put: 8;
		"S"
			at: 'PATTERN_DAY_OF_WEEK' put: 9;
		"E"
			at: 'PATTERN_DAY_OF_YEAR' put: 10;
		"D"
			at: 'PATTERN_DAY_OF_WEEK_IN_MONTH' put: 11;
		"F"
			at: 'PATTERN_WEEK_OF_YEAR' put: 12;
		"w"
			at: 'PATTERN_WEEK_OF_MONTH' put: 13;
		"W"
			at: 'PATTERN_AM_PM' put: 14;
		"a"
			at: 'PATTERN_HOUR1' put: 15;
		"h"
			at: 'PATTERN_HOUR0' put: 16;
		"K"
			at: 'PATTERN_ZONE_NAME' put: 17;
		"z"
			at: 'PATTERN_ZONE_VALUE' put: 18;
		"Z"
			at: 'PATTERN_WEEK_YEAR' put: 19;
		"Y"
			at: 'PATTERN_ISO_DAY_OF_WEEK' put: 20;
		"u"
			at: 'PATTERN_ISO_ZONE' put: 21;
		"X"
			at: 'PATTERN_MONTH_STANDALONE' put: 22;
		"L"
			yourself
]

{ #category : #'instance creation' }
DatePatternCompiler class >> on: aString [
	^ self new
		pattern: aString;
		compile;
		yourself
]

{ #category : #constants }
DatePatternCompiler class >> patternChars [
	^ 'GyMdkHmsSEDFwWahKzZYuXL'
]

{ #category : #API }
DatePatternCompiler >> compile [
	"I do the compilation and return myself."

	"Setting up of basic values."

	length := pattern size.
	inQuote := false.
	count := tagcount := 0.
	lastTag := prevTag := -1.

	"Start working."
	String
		streamContents: [ :aStream | 
			"Setting up buffers."
			compiledCode := aStream.
			tmpBuffer := nil.

			"Start of the main loop."
			self
				doWithContinue: [ :continue | self each: (pattern at: i) continue: continue ].

			"Check if a quotation is left open."
			inQuote
				ifTrue: [ Error signal: 'Unterminated quote' ].

			"Check something else."
			count = 0
				ifFalse: [ self encode: lastTag count: count stream: compiledCode.
					tagcount := tagcount + 1.
					prevTag := lastTag ] ].

	"Set a control flag"
	forceStandaloneForm := tagcount = 1
		and: [ prevTag = (self class datetimePatterns at: 'PATTERN_MONTH') ]
]

{ #category : #enumerating }
DatePatternCompiler >> doUntil: aBlock [

	i + 1 to: length do: [ :j | 
	aBlock value: (self at: j) value: [ ^ j ] ].
	^ length + 1
]

{ #category : #enumerating }
DatePatternCompiler >> doWithContinue: aBlock [

	i := 1.
	[ i <= length ] whileTrue: [ 
		[ :continue | aBlock value: continue ] valueWithExit.
		i := i + 1 ]
]

{ #category : #enumerating }
DatePatternCompiler >> each: c continue: continue [
	c = $'
		ifTrue: [ self quoteCharacterHasBeenRead.
			continue value ].
	inQuote
		ifTrue: [ tmpBuffer nextPut: c.
			continue value ].
	c isBetweenazOrAZ
		ifFalse: [ count = 0
				ifFalse: [ self encodeLastTag: -1 count: 0 ].	"Reset `count`"
			c asInteger < 128
				ifTrue: [ compiledCode
						nextPut: (self tagQuoteAsciiChar << 8 bitOr: c asInteger) asCharacter ]
				ifFalse: [ | j |
					j := self
						doUntil: [ :d :break | 
							(d = $' or: [ d isBetweenazOrAZ ])
								ifTrue: [ break value ] ].
					compiledCode
						nextPut: (self tagQuoteChars << 8 bitOr: j - i) asCharacter.
					i to: j - 1 do: [ :k | 
						i := k.
						compiledCode nextPut: (self at: i) ] ].
			continue value ].
	self mapPatternCharFor: c continue: continue
]

{ #category : #evaluating }
DatePatternCompiler >> encode: tag count: len stream: buffer [
	(tag = (self class datetimePatterns at: 'PATTERN_ISO_ZONE')
		and: [ len >= 4 ])
		ifTrue: [ Error signal: 'invalid ISO 8601 format' ].
	len < 255
		ifTrue: [ buffer nextPut: (tag << 8 bitOr: len) asCharacter ]
		ifFalse: [ buffer
				nextPut: (tag << 8 bitOr: 16rFF) asCharacter;
				nextPut:
					(len < 0
						ifTrue: [ (len bitInvert32 >> 16) bitInvert ]
						ifFalse: [ len >> 16 ]) asCharacter;
				nextPut: (len bitAnd: 16rFFFF) asCharacter ]
]

{ #category : #evaluating }
DatePatternCompiler >> encodeLastTag: lt count: c [
	self encode: lastTag count: count stream: compiledCode.
	tagcount := tagcount + 1.
	prevTag := lastTag.
	lastTag := lt.
	count := c
]

{ #category : #accessing }
DatePatternCompiler >> forceStandaloneForm [
	^ forceStandaloneForm
]

{ #category : #evaluating }
DatePatternCompiler >> mapPatternCharFor: c continue: continue [
	| tag |
	tag := (self class patternChars
		indexOf: c
		ifAbsent: [ Error signal: 'Illegal pattern character' ]) - 1.
	(lastTag = -1 or: [ lastTag = tag ])
		ifTrue: [ lastTag := tag.
			count := count + 1.
			continue value ].
	self encodeLastTag: tag count: 1
]

{ #category : #accessing }
DatePatternCompiler >> pattern [
	^ pattern
]

{ #category : #accessing }
DatePatternCompiler >> pattern: anObject [
	pattern := anObject
]

{ #category : #evaluating }
DatePatternCompiler >> quoteCharacterHasBeenRead [
	| j |
	j := i + 1.
	j <= length
		ifTrue: [ (pattern at: j) = $'
				ifTrue: [ self twoQuoteCharactersInARowHaveBeenScanned.
					i := j.	"Equivalent to `i++`."
					^ self	"Stop the execution as a `continue` would have been done" ] ].
	inQuote
		ifTrue: [ | len |
			len := tmpBuffer size.
			len = 1
				ifTrue: [ | ch |
					ch := tmpBuffer contents first.
					ch asInteger < 128
						ifTrue: [ compiledCode
								nextPut: (self tagQuoteAsciiChar << 8 bitOr: ch asInteger) asCharacter ]
						ifFalse: [ compiledCode
								nextPut: (self tagQuoteChars << 8 bitOr: 1) asCharacter;
								nextPut: ch ] ]
				ifFalse: [ self encode: self tagQuoteChars count: len stream: compiledCode.
					compiledCode nextPutAll: tmpBuffer contents ].
			inQuote := false ]
		ifFalse: [ count = 0
				ifFalse: [ self encodeLastTag: -1 count: 0 ].
			tmpBuffer
				ifNil: [ tmpBuffer := (String new: length) writeStream ]
				ifNotNil: [ tmpBuffer reset ].
			inQuote := true ]
]

{ #category : #utilities }
DatePatternCompiler >> tagQuoteAsciiChar [
	^ self class datetimePatternTags at: 'TAG_QUOTE_ASCII_CHAR'
]

{ #category : #utilities }
DatePatternCompiler >> tagQuoteChars [
	^ self class datetimePatternTags at: 'TAG_QUOTE_CHARS'
]

{ #category : #API }
DatePatternCompiler >> tagsAsciiCharDo: asciiBlock charsDo: charsBlock otherwiseDo: oBlock [
	| cp j |
	cp := self value.

	"Prepare for looping."
	j := 1.
	[ j <= cp size ]
		whileTrue: [ | c tag cnt |
			c := (cp at: j) asInteger.
			tag := c >> 8.
			cnt := c bitAnd: 16rFF.
			j := j + 1.
			cnt = 255
				ifTrue: [ cnt := (cp at: j) asInteger << 16.
					j := j + 1.
					cnt := cnt bitOr: (cp at: j) asInteger.
					j := j + 1 ].
			tag = self tagQuoteAsciiChar
				ifTrue: [ asciiBlock value: cnt asCharacter ]
				ifFalse: [ tag = self tagQuoteChars
						ifTrue: [ | chars jj |
							jj := j + cnt.
							chars := cp copyFrom: j to: jj - 1.
							charsBlock value: chars.
							j := jj ]
						ifFalse: [ oBlock cull: tag cull: cnt ] ] ]
]

{ #category : #evaluating }
DatePatternCompiler >> twoQuoteCharactersInARowHaveBeenScanned [
	| c |
	c := $'.
	count = 0
		ifFalse: [ self encodeLastTag: -1 count: 0 ].
	inQuote
		ifTrue: [ tmpBuffer nextPut: c ]
		ifFalse: [ | cc |
			cc := (self tagQuoteAsciiChar << 8 bitOr: c asInteger) asCharacter.
			compiledCode nextPut: cc ]
]

{ #category : #API }
DatePatternCompiler >> value [
	^ compiledCode contents
]
