"
A DatePatternTextFormatterTest is a test class for testing the behavior of DatePatternTextFormatter
"
Class {
	#name : #TextStyleFormatterTest,
	#superclass : #TestCase,
	#category : #'APart Localization Tests'
}

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsFalse [

	| matched |
	matched := TextStyleFormatter new
		           predicate: 'boolean(false)';
		           value: DateAndTime now
		           ifMatch: [ true ]
		           ifMismatch: [ false ].

	self deny: matched
]

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsLessThan [

	| matched anObject |
	anObject := Object new.

	matched := TextStyleFormatter new
		           predicate: 'lessThan(argument(), number(3))';
		           value: 2 ifMatch: [ true ] ifMismatch: [ false ].

	self assert: matched
]

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsObjectIdentity [

	| matched anObject |
	anObject := Object new.

	matched := TextStyleFormatter new
		           predicate: 'equal(argument(), argument(useless))';
		           value: anObject ifMatch: [ true ] ifMismatch: [ false ].

	self assert: matched
]

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsString [

	| matched anObject |
	anObject := Object new.

	matched := TextStyleFormatter new
		           predicate: 'equal(argument(), string(  hello ))';
		           value: '  hello ' ifMatch: [ true ] ifMismatch: [ false ].

	self assert: matched
]

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsToday [

	| matched |
	matched := TextStyleFormatter new
		           predicate:
			           'equal(apply(argument(), string(asDate)), apply(offsetFromNow(unit(days), number(0)), string(asDate))';
		           value: DateAndTime now
		           ifMatch: [ true ]
		           ifMismatch: [ false ].

	self assert: matched
]

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsTrue [

	| matched |
	matched := TextStyleFormatter new
		           predicate: 'boolean(true)';
		           value: DateAndTime now
		           ifMatch: [ true ]
		           ifMismatch: [ false ].

	self assert: matched
]

{ #category : #'tests - conditionals' }
TextStyleFormatterTest >> testConditionsYesterday [

	| matched |
	matched := TextStyleFormatter new
		           predicate:
			           'equal(apply(argument(), string(asDate)), apply(offsetFromNow(unit(days), number(-1)), string(asDate))';
		           value: DateAndTime now - 1 days
		           ifMatch: [ true ]
		           ifMismatch: [ false ].

	self assert: matched
]

{ #category : #'tests - formatting' }
TextStyleFormatterTest >> testKeywords [

	(TextStyleFormatter new
		 pattern:
			 '[font-color=blue][font-size=14][selector=#asText][string=heute ]$[font-size=6][selector=#asText][selector=#asString][format-date=EEE hh:mm]$';
		 value: DateAndTime now) inspect
]

{ #category : #'tests - formatting' }
TextStyleFormatterTest >> testSelectors [

	(TextStyleFormatter new
		 pattern:
			 '[font-color=blue][font-size=10][selector=#asText][string=size: ]$[font-size=14][selector=#asText][selector=#asString][selector=#size]$';
		 value: (String loremIpsum: 50)) inspect
]
