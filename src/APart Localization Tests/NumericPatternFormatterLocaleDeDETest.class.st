Class {
	#name : #NumericPatternFormatterLocaleDeDETest,
	#superclass : #NumericPatternFormatterLocaleTest,
	#category : #'APart Localization Tests'
}

{ #category : #hooks }
NumericPatternFormatterLocaleDeDETest >> locale [
	^ APartLocaleDeDE new
]

{ #category : #'*APart Localization Tests' }
NumericPatternFormatterLocaleDeDETest >> test_SharpsOnly_LiteralsOnTheLeft [
	self
		multiAssert:
			(OrderedCollection new
				add: #('€ #' 123456) -> '€ 123456';
				add: #('€ ####' 123456) -> '€ 123456';
				add: #('€ #t###' 123456) -> '€ 123.456';
				add: #('€ ####' 1) -> '€ 1';
				add: #('€ #####' 123) -> '€ 123';
				add: #('€ #####c###' 123.4) -> '€ 123,4';
				add: #('€ #####c###' 123.45) -> '€ 123,45';
				add: #('€ #####c###' 123.456) -> '€ 123,456';
				add: #('€ #####c###' 123.4567) -> '€ 123,457';
				add: #('€ #####c###' 123.456789) -> '€ 123,457';
				add: #('€ #####c###' 1234.56789) -> '€ 1234,568';
				add: #('€ ##t###c###' 1234.56789) -> '€ 1.234,568';
				add: #('€ #t###t###c###' 12341234.56789) -> '€ 12.341.234,568';
				add: #('€ ####t###c###' 12341234.56789) -> '€ 12.341.234,568';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleDeDETest >> test_SharpsOnly_LiteralsOnTheRight [
	self
		multiAssert:
			(OrderedCollection new
				add: #('# €' 123456) -> '123456 €';
				add: #('#### €' 123456) -> '123456 €';
				add: #('#### €' 1) -> '1 €';
				add: #('##### €' 123) -> '123 €';
				add: #('#####c### €' 123.4) -> '123,4 €';
				add: #('#####c### €' 123.45) -> '123,45 €';
				add: #('#####c### €' 123.456) -> '123,456 €';
				add: #('#####c### €' 123.4567) -> '123,457 €';
				add: #('#####c### €' 123.456789) -> '123,457 €';
				add: #('#####c### €' 1234.56789) -> '1234,568 €';
				add: #('######t###c### €' 12341234.56789) -> '12.341.234,568 €';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleDeDETest >> test_ZerosAndSharps [
	self
		multiAssert:
			(OrderedCollection new
				add: #('##00' 123456) -> '123456';
				add: #('##0000' 123456) -> '123456';
				add: #('#####0000' 123456) -> '123456';
				add: #('##00000000' 123456) -> '00123456';
				add: #('###0c000##' 123.4) -> '123,400';
				add: #('###0c###' 123.4) -> '123,4';
				add: #('0c00#' 123.456) -> '123,456';
				add: #('0c00#' 123.4567) -> '123,457';
				add: #('0c###' 123) -> '123';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleDeDETest >> test_ZerosOnly [
	self
		multiAssert:
			(OrderedCollection new
				add: #('0' 123456) -> '123456';
				add: #('0000' 123456) -> '123456';
				add: #('00000' 1) -> '00001';
				add: #('00000' 123) -> '00123';
				add: #('00000c000' 123.4) -> '00123,400';
				add: #('00000c000' 123.45) -> '00123,450';
				add: #('00000c000' 123.456) -> '00123,456';
				add: #('00000c000' 123.4567) -> '00123,457';
				add: #('00000c000' 123.456789) -> '00123,457';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleDeDETest >> test_ZerosOnly_LiteralsOnBothSides [
	self
		multiAssert:
			(OrderedCollection new
				add: #('$ 0 €' 123456) -> '$ 123456 €';
				add: #('$ 0000 €' 123456) -> '$ 123456 €';
				add: #('$ 00000 €' 1) -> '$ 00001 €';
				add: #('$ 00000 €' 123) -> '$ 00123 €';
				add: #('$ 00000c000 €' 123.4) -> '$ 00123,400 €';
				add: #('$ 00000c000 €' 123.45) -> '$ 00123,450 €';
				add: #('$ 00000c000 €' 123.456) -> '$ 00123,456 €';
				add: #('$ 00000c000 €' 123.4567) -> '$ 00123,457 €';
				add: #('$ 00000c000 €' 123.456789) -> '$ 00123,457 €';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleDeDETest >> test_ZerosOnly_LiteralsOnTheLeft [
	self
		multiAssert:
			(OrderedCollection new
				add: #('€ 0' 123456) -> '€ 123456';
				add: #('€ 0000' 123456) -> '€ 123456';
				add: #('€ 00000' 1) -> '€ 00001';
				add: #('€ 00000' 123) -> '€ 00123';
				add: #('€ 00000c000' 123.4) -> '€ 00123,400';
				add: #('€ 00000c000' 123.45) -> '€ 00123,450';
				add: #('€ 00000c000' 123.456) -> '€ 00123,456';
				add: #('€ 00000c000' 123.4567) -> '€ 00123,457';
				add: #('€ 00000c000' 123.456789) -> '€ 00123,457';
				yourself)
]

{ #category : #tests }
NumericPatternFormatterLocaleDeDETest >> test_ZerosOnly_LiteralsOnTheRight [
	self
		multiAssert:
			(OrderedCollection new
				add: #('0 €' 123456) -> '123456 €';
				add: #('0000 €' 123456) -> '123456 €';
				add: #('00000 €' 1) -> '00001 €';
				add: #('00000 €' 123) -> '00123 €';
				add: #('00000c000 €' 123.4) -> '00123,400 €';
				add: #('00000c000 €' 123.45) -> '00123,450 €';
				add: #('00000c000 €' 123.456) -> '00123,456 €';
				add: #('00000c000 €' 123.4567) -> '00123,457 €';
				add: #('00000c000 €' 123.456789) -> '00123,457 €';
				yourself)
]
