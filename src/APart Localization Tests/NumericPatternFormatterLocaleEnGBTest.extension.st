Extension { #name : #NumericPatternFormatterLocaleEnGBTest }

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
