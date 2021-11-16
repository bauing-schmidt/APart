Class {
	#name : #NumericPatternFormatterTest,
	#superclass : #TestCase,
	#category : #'APart Localization Tests'
}

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> formatter [
	^ NumericPatternFormatter new
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> multiAssert: aCollection [
	aCollection
		do: [ :anAssociation | 
			| pattern number expected |
			pattern := anAssociation key first.
			number := anAssociation key second.
			expected := anAssociation value.
			self
				assert:
					(self formatter
						pattern: pattern;
						format: number)
				equals: expected ]
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> testZeroSharpFormattingWithoutPatterns [
	self
		assert: ('$ €' zeroSharpFormat: 123456 forLocale: nil)
		equals: '$ €'.
	self
		assert: ('hello world!' zeroSharpFormat: 12345.6789 forLocale: nil)
		equals: 'hello world!'
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_SharpsOnly_LiteralsOnTheLeft [
	self
		multiAssert:
			(OrderedCollection new
				add: #('€ #' 123456) -> '€ 123456';
				add: #('€ ####' 123456) -> '€ 123456';
				add: #('€ ####' 1) -> '€ 1';
				add: #('€ #####' 123) -> '€ 123';
				add: #('€ #####.###' 123.4) -> '€ 123.4';
				add: #('€ #####.###' 123.45) -> '€ 123.45';
				add: #('€ #####.###' 123.456) -> '€ 123.456';
				add: #('€ #####.###' 123.4567) -> '€ 123.457';
				add: #('€ #####.###' 123.456789) -> '€ 123.457';
				yourself)
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_SharpsOnly_LiteralsOnTheRight [
	self
		multiAssert:
			(OrderedCollection new
				add: #('# €' 123456) -> '123456 €';
				add: #('#### €' 123456) -> '123456 €';
				add: #('#### €' 1) -> '1 €';
				add: #('##### €' 123) -> '123 €';
				add: #('#####.### €' 123.4) -> '123.4 €';
				add: #('#####.### €' 123.45) -> '123.45 €';
				add: #('#####.### €' 123.456) -> '123.456 €';
				add: #('#####.### €' 123.4567) -> '123.457 €';
				add: #('#####.### €' 123.4565) -> '123.457 €';
				add: #('#####.### €' 123.4563) -> '123.456 €';
				add: #('#####.### €' 123.456789) -> '123.457 €';
				yourself)
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_ZerosAndSharps [
	self
		multiAssert:
			(OrderedCollection new
				add: #('##00' 123456) -> '123456';
				add: #('##0000' 123456) -> '123456';
				add: #('#####0000' 123456) -> '123456';
				add: #('##00000000' 123456) -> '00123456';
				add: #('###0.000##' 123.4) -> '123.400';
				add: #('###0.###' 123.4) -> '123.4';
				add: #('0.00#' 123.456) -> '123.456';
				add: #('0.00#' 123.4567) -> '123.457';
				add: #('0.###' 123) -> '123';
				yourself)
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_ZerosOnly [
	self
		multiAssert:
			(OrderedCollection new
				add: #('0' 1.2) -> '1';
				add: #('0' 1.5) -> '2';
				add: #('0' 1.7) -> '2';
				add: #('0' 123456) -> '123456';
				add: #('0000' 123456) -> '123456';
				add: #('00000' 1) -> '00001';
				add: #('00000' 123) -> '00123';
				add: #('00000.000' 123.4) -> '00123.400';
				add: #('00000.000' 123.45) -> '00123.450';
				add: #('00000.000' 123.456) -> '00123.456';
				add: #('00000.000' 123.4567) -> '00123.457';
				add: #('00000.000' 123.456789) -> '00123.457';
				yourself)
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_ZerosOnly_LiteralsOnBothSides [
	self
		multiAssert:
			(OrderedCollection new
				add: #('$ 0 €' 123456) -> '$ 123456 €';
				add: #('$ 0000 €' 123456) -> '$ 123456 €';
				add: #('$ 00000 €' 1) -> '$ 00001 €';
				add: #('$ 00000 €' 123) -> '$ 00123 €';
				add: #('$ 00000.000 €' 123.4) -> '$ 00123.400 €';
				add: #('$ 00000.000 €' 123.45) -> '$ 00123.450 €';
				add: #('$ 00000.000 €' 123.456) -> '$ 00123.456 €';
				add: #('$ 00000.000 €' 123.4567) -> '$ 00123.457 €';
				add: #('$ 00000.000 €' 123.456789) -> '$ 00123.457 €';
				yourself)
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_ZerosOnly_LiteralsOnTheLeft [
	self
		multiAssert:
			(OrderedCollection new
				add: #('€ 0' 123456) -> '€ 123456';
				add: #('€ 0000' 123456) -> '€ 123456';
				add: #('€ 00000' 1) -> '€ 00001';
				add: #('€ 00000' 123) -> '€ 00123';
				add: #('€ 00000.000' 123.4) -> '€ 00123.400';
				add: #('€ 00000.000' 123.45) -> '€ 00123.450';
				add: #('€ 00000.000' 123.456) -> '€ 00123.456';
				add: #('€ 00000.000' 123.4567) -> '€ 00123.457';
				add: #('€ 00000.000' 123.456789) -> '€ 00123.457';
				yourself)
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterTest >> test_ZerosOnly_LiteralsOnTheRight [
	self
		multiAssert:
			(OrderedCollection new
				add: #('0 €' 123456) -> '123456 €';
				add: #('0000 €' 123456) -> '123456 €';
				add: #('00000 €' 1) -> '00001 €';
				add: #('00000 €' 123) -> '00123 €';
				add: #('00000.000 €' 123.4) -> '00123.400 €';
				add: #('00000.000 €' 123.45) -> '00123.450 €';
				add: #('00000.000 €' 123.456) -> '00123.456 €';
				add: #('00000.000 €' 123.4567) -> '00123.457 €';
				add: #('00000.000 €' 123.456789) -> '00123.457 €';
				yourself)
]
