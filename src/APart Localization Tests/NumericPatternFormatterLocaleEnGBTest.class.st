Class {
	#name : #NumericPatternFormatterLocaleEnGBTest,
	#superclass : #NumericPatternFormatterLocaleTest,
	#category : #'APart Localization Tests'
}

{ #category : #private }
NumericPatternFormatterLocaleEnGBTest >> locale [
	^ APartLocaleEnGB new
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> testPrintStringOfFileSizes [
	| formatter |
	formatter := APartFileSizeNumericPatternFormatter new
		locale: self locale;
		pattern: '###t##0c### s';
		yourself.
	self
		assert: (formatter format: 0) equals: '0 B';
		assert: (formatter format: 1) equals: '1 B';
		assert: (formatter format: 567) equals: '567 B';
		assert: (formatter format: 999) equals: '999 B';
		assert: (formatter format: 1000) equals: '1 KB';
		assert: (formatter format: 5500) equals: '5.5 KB';
		assert: (formatter format: 5567) equals: '5.567 KB';
		assert: (formatter format: 15567) equals: '15.567 KB';
		assert: (formatter format: 125567) equals: '125.567 KB';
		assert: (formatter format: 1235467) equals: '1.235 MB';
		assert: (formatter format: 1230000) equals: '1.23 MB';
		assert: (formatter format: 1235567) equals: '1.236 MB';
		assert: (formatter format: 12000000) equals: '12 MB';
		assert: (formatter format: 12345678) equals: '12.346 MB';
		assert: (formatter format: 112345678) equals: '112.346 MB';
		assert: (formatter format: 1000000000) equals: '1 GB';
		assert: (formatter format: 1123456788) equals: '1.123 GB';
		assert: (formatter format: 1120000000) equals: '1.12 GB';
		assert: (formatter format: 11234567886) equals: '11.235 GB';
		assert: (formatter format: 112345678867) equals: '112.346 GB';
		assert: (formatter format: 1000000000000) equals: '1 TB';
		assert: (formatter format: 1123456788679) equals: '1.123 TB';
		assert: (formatter format: 1120000000000) equals: '1.12 TB';
		assert: (formatter format: 11234567886791) equals: '11.235 TB';
		assert: (formatter format: 112345678867912) equals: '112.346 TB';
		assert: (formatter format: 1123456788679123) equals: '1,123.457 TB';
		assert: (formatter format: 11234567886791234)
			equals: '11,234.568 TB';
		assert: (formatter format: 11234567886791234)
			equals: '11,234.568 TB';
		assert: (formatter format: 112345678867912345)
			equals: '112,345.679 TB';
		deny: (formatter format: 1000000000000000000) equals: '1 PB'	"too large for now"
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterLocaleEnGBTest >> test_SharpsOnly_LiteralsOnTheLeft [
	self
		multiAssert:
			(OrderedCollection new
				add: #('€ #' 123456) -> '€ 123456';
				add: #('€ ####' 123456) -> '€ 123456';
				add: #('€ ####' 1) -> '€ 1';
				add: #('€ #####' 123) -> '€ 123';
				add: #('€ #####c###' 123.4) -> '€ 123.4';
				add: #('€ #####c###' 123.45) -> '€ 123.45';
				add: #('€ #####c###' 123.456) -> '€ 123.456';
				add: #('€ #####c###' 123.4567) -> '€ 123.457';
				add: #('€ #####c###' 123.456789) -> '€ 123.457';
				add: #('€ #####c###' 1234.56789) -> '€ 1234.568';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> test_SharpsOnly_LiteralsOnTheRight [
	self
		multiAssert:
			(OrderedCollection new
				add: #('# €' 123456) -> '123456 €';
				add: #('#### €' 123456) -> '123456 €';
				add: #('#### €' 1) -> '1 €';
				add: #('####c# €' 1) -> '1 €';
				add: #('##### €' 123) -> '123 €';
				add: #('#####c### €' 123.4) -> '123.4 €';
				add: #('#####c### €' 123.45) -> '123.45 €';
				add: #('#####c### €' 123.456) -> '123.456 €';
				add: #('#####c### €' 123.4567) -> '123.457 €';
				add: #('#####c### €' 123.456789) -> '123.457 €';
				add: #('#####c### €' 1234.56789) -> '1234.568 €';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> test_ZerosAndSharps [
	self
		multiAssert:
			(OrderedCollection new
				add: #('##00' 123456) -> '123456';
				add: #('##0000' 123456) -> '123456';
				add: #('#####0000' 123456) -> '123456';
				add: #('##00000000' 123456) -> '00123456';
				add: #('###0c000##' 123.4) -> '123.400';
				add: #('###0c###' 123.4) -> '123.4';
				add: #('0c00#' 123.456) -> '123.456';
				add: #('0c00#' 123.4567) -> '123.457';
				add: #('0c###' 123) -> '123';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> test_ZerosOnly [
	self
		multiAssert:
			(OrderedCollection new
				add: #('0' 123456) -> '123456';
				add: #('0000' 123456) -> '123456';
				add: #('00000' 1) -> '00001';
				add: #('00000' 123) -> '00123';
				add: #('00000c000' 123.4) -> '00123.400';
				add: #('00000c000' 123.45) -> '00123.450';
				add: #('00000c000' 123.456) -> '00123.456';
				add: #('00000c000' 123.4567) -> '00123.457';
				add: #('00000c000' 123.456789) -> '00123.457';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> test_ZerosOnly_LiteralsOnBothSides [
	self
		multiAssert:
			(OrderedCollection new
				add: #('$ 0 €' 123456) -> '$ 123456 €';
				add: #('$ 0000 €' 123456) -> '$ 123456 €';
				add: #('$ 00000 €' 1) -> '$ 00001 €';
				add: #('$ 00000 €' 123) -> '$ 00123 €';
				add: #('$ 00000c000 €' 123.4) -> '$ 00123.400 €';
				add: #('$ 00000c000 €' 123.45) -> '$ 00123.450 €';
				add: #('$ 00000c000 €' 123.456) -> '$ 00123.456 €';
				add: #('$ 00000c000 €' 123.4567) -> '$ 00123.457 €';
				add: #('$ 00000c000 €' 123.456789) -> '$ 00123.457 €';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> test_ZerosOnly_LiteralsOnTheLeft [
	self
		multiAssert:
			(OrderedCollection new
				add: #('€ 0' 123456) -> '€ 123456';
				add: #('€ 0000' 123456) -> '€ 123456';
				add: #('€ 00000' 1) -> '€ 00001';
				add: #('€ 00000' 123) -> '€ 00123';
				add: #('€ 00000c000' 123.4) -> '€ 00123.400';
				add: #('€ 00000c000' 123.45) -> '€ 00123.450';
				add: #('€ 00000c000' 123.456) -> '€ 00123.456';
				add: #('€ 00000c000' 123.4567) -> '€ 00123.457';
				add: #('€ 00000c000' 123.456789) -> '€ 00123.457';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleEnGBTest >> test_ZerosOnly_LiteralsOnTheRight [
	self
		multiAssert:
			(OrderedCollection new
				add: #('0 €' 123456) -> '123456 €';
				add: #('0000 €' 123456) -> '123456 €';
				add: #('00000 €' 1) -> '00001 €';
				add: #('00000 €' 123) -> '00123 €';
				add: #('00000c000 €' 123.4) -> '00123.400 €';
				add: #('00000c000 €' 123.45) -> '00123.450 €';
				add: #('00000c000 €' 123.456) -> '00123.456 €';
				add: #('00000c000 €' 123.4567) -> '00123.457 €';
				add: #('00000c000 €' 123.456789) -> '00123.457 €';
				yourself)
]
