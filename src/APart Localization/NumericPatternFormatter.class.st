"
I am a base class for all number formats and I provide the interface for formatting numbers.

My foundations are based in the JDK `NumberFormat` class (https://docs.oracle.com/javase/8/docs/api/java/text/NumberFormat.html) and in the future I will evolve to mimic the `DecimalFormat` class (https://docs.oracle.com/javase/8/docs/api/java/text/DecimalFormat.html) as well to be able to provide a more sophisticated pattern language (https://docs.oracle.com/javase/tutorial/i18n/format/decimalFormat.html) that allows my clients to write formatting expressions as in the example shown in https://docs.oracle.com/javase/tutorial/i18n/format/examples/DecimalFormatDemo.java
"
Class {
	#name : #NumericPatternFormatter,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'lhsPattern',
		'thousandsGroupSize',
		'rhsPattern'
	],
	#category : #'APart Localization'
}

{ #category : #'instance creation' }
NumericPatternFormatter class >> on: aString [
	^ self new
		pattern: aString;
		yourself
]

{ #category : #hooks }
NumericPatternFormatter >> decimalSeparator [
	^ $.
]

{ #category : #formatting }
NumericPatternFormatter >> format: aNumber [
	^ ((pattern includes: $#) or: [ pattern includes: $0 ])
		ifTrue: [ | lhs rhs |
			lhs := self
				format: lhsPattern
				zeroSharpFormatString:
					(rhsPattern
						ifEmpty: [ (aNumber roundTo: 1) asFloat ]
						ifNotEmpty: [ aNumber integerPart ])
				isLHS: true.
			rhs := self
				format: rhsPattern
				zeroSharpFormatString: aNumber fractionPart
				isLHS: false.

			"Apply the pattern to fulfill my task."
			self leftHandSide: lhs rightHandSide: rhs ]
		ifFalse: [ pattern ]
]

{ #category : #formatting }
NumericPatternFormatter >> format: numString zeroSharpFormatString: aFloat isLHS: aBoolean [
	| i p prefix suffix body size chunks |
	size := numString size.

	"Compute the prefix."
	i := (numString indexOf: $# ifAbsent: [ size + 1 ])
		min: (numString indexOf: $0 ifAbsent: [ size + 1 ]).
	prefix := numString copyFrom: 1 to: i - 1.

	"Reuse `i` to compute the suffix."
	p := (numString lastIndexOf: $# ifAbsent: [ 0 ])
		max: (numString lastIndexOf: $0 ifAbsent: [ 0 ]).
	suffix := numString copyFrom: p + 1 to: size.

	"Compute the body."
	body := (numString copyFrom: i to: p)
		ifNotEmpty: [ :rest | 
			| r reversed |
			r := rest size.
			reversed := aBoolean
				ifTrue: [ aFloat asInteger asString reversed ]
				ifFalse: [ | rounded |
					rounded := (aFloat roundTo: 10 ** r negated) asFloat.
					rounded = 0
						ifTrue: [ String empty ]
						ifFalse:
							[ rounded fractionPart asString in: [ :s | s copyFrom: 3 to: s size ] ] ].
			r < reversed size
				ifTrue: [ aBoolean
						ifTrue: [ reversed ]
						ifFalse: [ reversed copyFrom: 1 to: r ] ]
				ifFalse: [ String
						streamContents: [ :s | 
							rest reversed
								withIndexCollect: [ :aCharacter :j | 
									aCharacter = $0
										ifTrue: [ s nextPut: (reversed at: j ifAbsent: [ aCharacter ]) ]
										ifFalse: [ aCharacter = $#
												ifTrue: [ s nextPut: (reversed at: j ifAbsent: [ Character space ]) ]
												ifFalse: [ s nextPut: aCharacter ] ] ] ] ] ].

	"Piecewise result."
	^ chunks := Array with: prefix with: body reversed trim with: suffix
]

{ #category : #formatting }
NumericPatternFormatter >> group: aCollection size: n ifAbsent: absentBlock collect: aBlock [
	^ Array
		streamContents: [ :aStream | 
			| index |
			index := 1.
			[ index <= aCollection size ]
				whileTrue: [ | args j |
					j := index + n - 1.
					args := (index to: j)
						collect: [ :i | aCollection at: i ifAbsent: absentBlock ].
					aStream nextPut: (aBlock value: args).
					index := j + 1 ] ]
]

{ #category : #formatting }
NumericPatternFormatter >> leftHandSide: lhs rightHandSide: rhs [
	| leftBody rightBody |
	leftBody := thousandsGroupSize > 0
		ifTrue: [ (self primDigitGrouping
				join:
					(self
						group: lhs second reversed
						size: thousandsGroupSize
						ifAbsent: [ Character space ]
						collect: [ :chunk | ('' join: chunk) trim ])) reversed ]
		ifFalse: [ lhs second ].
	rightBody := ('' join: rhs) reversed.
	^ String
		streamContents: [ :aStream | 
			aStream
				nextPutAll: lhs first;
				nextPutAll: leftBody;
				nextPutAll: lhs third.
			rightBody
				ifNotEmpty: [ aStream
						nextPutAll: (rhs second ifNotEmpty: [ self primDecimalSymbol ]) , rightBody ] ]
]

{ #category : #accessing }
NumericPatternFormatter >> pattern: aString [
	| pair |
	pattern := aString.
	pair := self decimalSeparator asString split: pattern.
	lhsPattern := pair first
		reject: [ :each | each = self thousandSeparator ].
	thousandsGroupSize := pair first = lhsPattern
		ifTrue: [ 0 ]
		ifFalse: [ (pair first reversed indexOf: self thousandSeparator) - 1 ].
	rhsPattern := (pair at: 2 ifAbsent: [ nil ])
		ifNil: [ '' ]
		ifNotNil: [ :decimalPattern | decimalPattern reversed ]
]

{ #category : #hooks }
NumericPatternFormatter >> primDecimalSymbol [
	^ self decimalSeparator asString
]

{ #category : #hooks }
NumericPatternFormatter >> primDigitGrouping [
	^ self thousandSeparator asString
]

{ #category : #hooks }
NumericPatternFormatter >> thousandSeparator [
	^ $,
]
