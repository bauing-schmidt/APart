Class {
	#name : #APartDatePatternFormatterTest,
	#superclass : #TestCase,
	#category : #'APart Localization Tests'
}

{ #category : #accessing }
APartDatePatternFormatterTest >> dateAndTime [
	^ DateAndTime
		year: 2001
		month: 7
		day: 4
		hour: 12
		minute: 8
		second: 56
		nanoSecond: 235000000
		offset: -7 hour
]

{ #category : #tests }
APartDatePatternFormatterTest >> fieldsHandlerCsCZ [
	^ APartDatePatternFieldHandler new
		locale: APartLocaleCsCZ new;
		yourself
]

{ #category : #tests }
APartDatePatternFormatterTest >> fieldsHandlerDeDE [
	^ APartDatePatternFieldHandler new
		locale: APartLocaleDeDE new;
		yourself
]

{ #category : #tests }
APartDatePatternFormatterTest >> fieldsHandlerEnGB [
	^ APartDatePatternFieldHandler new
		locale: APartLocaleEnGB new;
		yourself
]

{ #category : #private }
APartDatePatternFormatterTest >> multiAssert: aCollection fieldsHandler: aHandler [
	aCollection
		do: [ :assoc | 
			self
				assert: (self dateAndTime format: assoc key fieldsHandler: aHandler)
				equals: assoc value ]
]

{ #category : #tests }
APartDatePatternFormatterTest >> testCsCZLocale [
	self
		multiAssert:
			(OrderedCollection new
				add:
					'yyyy.MM.dd G ''na'' HH:mm:ss z'
						-> '2001.07.04 po Kr. na 12:08:56 PDT';
				add: 'EEE, MMM d, ''''yy' -> 'St, čvc 4, ''01';
				add: 'h:mm a' -> '12:08 PM';
				add: 'hh ''hodin'' a, zzzz' -> '12 hodin PM, Tichomořský letní čas';
				add: 'K:mm a, z' -> '0:08 PM, PDT';
				add: 'yyyyy.MMMMM.dd GGG hh:mm aaa' -> '02001.červenec.04 po Kr. 12:08 PM';
				add: 'yyMMddHHmmssZ' -> '010704120856-0700';
				add: 'yyyy-MM-dd''T''HH:mm:ss.SSSZ' -> '2001-07-04T12:08:56.235-0700';
				add: 'yyyy-MM-dd''T''HH:mm:ss.SSSXXX' -> '2001-07-04T12:08:56.235-07:00';
				add: 'YYYY-''W''ww-u' -> '2001-W27-3';
				yourself)
		fieldsHandler: self fieldsHandlerCsCZ
]

{ #category : #tests }
APartDatePatternFormatterTest >> testDeDELocale [
	self
		multiAssert:
			(OrderedCollection new
				add:
					'yyyy.MM.dd G ''um'' HH:mm:ss z'
						-> '2001.07.04 n. Chr. um 12:08:56 PDT';
				add: 'EEE, MMM d, ''''yy' -> 'Mi, Jul 4, ''01';
				add: 'h:mm a' -> '12:08 PM';
				add: 'hh ''Uhr'' a, zzzz' -> '12 Uhr PM, Pazifische Tageslichtzeit';
				add: 'K:mm a, z' -> '0:08 PM, PDT';
				add: 'yyyyy.MMMMM.dd GGG hh:mm aaa' -> '02001.Juli.04 n. Chr. 12:08 PM';
				add: 'yyMMddHHmmssZ' -> '010704120856-0700';
				add: 'yyyy-MM-dd''T''HH:mm:ss.SSSZ' -> '2001-07-04T12:08:56.235-0700';
				add: 'yyyy-MM-dd''T''HH:mm:ss.SSSXXX' -> '2001-07-04T12:08:56.235-07:00';
				add: 'YYYY-''W''ww-u' -> '2001-W27-3';
				yourself)
		fieldsHandler: self fieldsHandlerDeDE
]

{ #category : #tests }
APartDatePatternFormatterTest >> testEnGBLocale [
	self
		multiAssert:
			(OrderedCollection new
				add: 'yyyy.MM.dd G ''at'' HH:mm:ss z' -> '2001.07.04 AD at 12:08:56 PDT';
				add: 'EEE, MMM d, ''''yy' -> 'Wed, Jul 4, ''01';
				add: 'h:mm a' -> '12:08 PM';
				add: 'hh ''o''''clock'' a, zzzz' -> '12 o''clock PM, Pacific Daylight Time';
				add: 'K:mm a, z' -> '0:08 PM, PDT';
				add: 'yyyyy.MMMMM.dd GGG hh:mm aaa' -> '02001.July.04 AD 12:08 PM';
				add: 'yyMMddHHmmssZ' -> '010704120856-0700';
				add: 'yyyy-MM-dd''T''HH:mm:ss.SSSZ' -> '2001-07-04T12:08:56.235-0700';
				add: 'yyyy-MM-dd''T''HH:mm:ss.SSSXXX' -> '2001-07-04T12:08:56.235-07:00';
				add: 'YYYY-''W''ww-u' -> '2001-W27-3';
				yourself)
		fieldsHandler: self fieldsHandlerEnGB
]
