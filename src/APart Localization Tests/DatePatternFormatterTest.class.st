"
A DatePatternFormatterTest is a test class for testing the behavior of DatePatternFormatter
"
Class {
	#name : #DatePatternFormatterTest,
	#superclass : #TestCase,
	#category : #'APart Localization Tests'
}

{ #category : #'*APart Localization Tests' }
DatePatternFormatterTest >> assertPattern: aPattern isCompiledAs: integerArray formats: aCalendar as: formattedString [
	| compiler formatter output |
	"First check the pattern compilation."
	compiler := DatePatternCompiler on: aPattern.
	self
		assert: (compiler value as: Array)
		equals: (integerArray collect: #asCharacter).

	"Then the formatting."
	formatter := DatePatternFormatter on: compiler.
	output := formatter
		format: aCalendar
		handler: DatePatternFieldHandler new.
	self assert: output equals: formattedString
]

{ #category : #'*APart Localization Tests' }
DatePatternFormatterTest >> calendar [
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

{ #category : #running }
DatePatternFormatterTest >> testDateAndTimeFormat [
	self
		assert: (self calendar format: 'yyyy.MM.dd G ''at'' HH:mm:ss z')
		equals: '2001.07.04 AD at 12:08:56 PDT'.
	self assert: (self calendar format: 'yyyy.MM.dd HH:mm')
		equals: '2001.07.04 12:08'.

]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern1 [
	self
		assertPattern: 'yyyy.MM.dd G ''at'' HH:mm:ss z'
		isCompiledAs:
			#(260 25646 514 25646 770 25632 1 25632 25858 97 116 25632 1282 25658 1538 25658 1794 25632 4353)
		formats: self calendar
		as: '2001.07.04 AD at 12:08:56 PDT'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern10 [
	self
		assertPattern: 'YYYY-''W''ww-u'
		isCompiledAs: #(4868 25645 25687 3074 25645 5121)
		formats: self calendar
		as: '2001-W27-3'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern11 [

	self
		assertPattern: 'yyyy_MM_dd G ''_'' HH:mm:ss z'
		isCompiledAs:
			#( 260 25760 514 25760 770 25632 1 25632 25695 25632 1282 25658
			   1538 25658 1794 25632 4353 )
		formats: self calendar
		as: (String streamContents: [ :aStream | 
				 aStream
					 nextPutAll: '2001';
					 nextPut: Character nbsp;
					 nextPutAll: '07';
					 nextPut: Character nbsp;
					 nextPutAll: '04 AD _ 12:08:56 PDT' ])
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern2 [
	self
		assertPattern: 'EEE, MMM d, ''''yy'
		isCompiledAs: #(2307 25644 25632 515 25632 769 25644 25632 25639 258)
		formats: self calendar
		as: 'Wed, Jul 4, ''01'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern3 [
	self
		assertPattern: 'h:mm a'
		isCompiledAs: #(3841 25658 1538 25632 3585)
		formats: self calendar
		as: '12:08 PM'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern4 [
	self
		assertPattern: 'hh ''o''''clock'' a, zzzz'
		isCompiledAs:
			#(3842 25632 25863 111 39 99 108 111 99 107 25632 3585 25644 25632 4356)
		formats: self calendar
		as: '12 o''clock PM, Pacific Daylight Time'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern5 [
	self
		assertPattern: 'K:mm a, z'
		isCompiledAs: #(4097 25658 1538 25632 3585 25644 25632 4353)
		formats: self calendar
		as: '0:08 PM, PDT'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern6 [
	self
		assertPattern: 'yyyyy.MMMMM.dd GGG hh:mm aaa'
		isCompiledAs: #(261 25646 517 25646 770 25632 3 25632 3842 25658 1538 25632 3587)
		formats: self calendar
		as: '02001.July.04 AD 12:08 PM'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern7 [
	self
		assertPattern: 'yyMMddHHmmssZ'
		isCompiledAs: #(258 514 770 1282 1538 1794 4609)
		formats: self calendar
		as: '010704120856-0700'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern8 [
	self
		assertPattern: 'yyyy-MM-dd''T''HH:mm:ss.SSSZ'
		isCompiledAs:
			#(260 25645 514 25645 770 25684 1282 25658 1538 25658 1794 25646 2051 4609)
		formats: self calendar
		as: '2001-07-04T12:08:56.235-0700'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern9 [
	self
		assertPattern: 'yyyy-MM-dd''T''HH:mm:ss.SSSXXX'
		isCompiledAs:
			#(260 25645 514 25645 770 25684 1282 25658 1538 25658 1794 25646 2051 5379)
		formats: self calendar
		as: '2001-07-04T12:08:56.235-07:00'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_D [
	self
		assertPattern: 'D'
		isCompiledAs: #(2561)
		formats: self calendar
		as: '185'.
	self
		assertPattern: 'DD'
		isCompiledAs: #(2562)
		formats: self calendar
		as: '185'.
	self
		assertPattern: 'DDD'
		isCompiledAs: #(2563)
		formats: self calendar
		as: '185'.
	self
		assertPattern: 'DDDD'
		isCompiledAs: #(2564)
		formats: self calendar
		as: '0185'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_E [
	self
		assertPattern: 'E'
		isCompiledAs: #(2305)
		formats: self calendar
		as: 'Wed'.
	self
		assertPattern: 'EE'
		isCompiledAs: #(2306)
		formats: self calendar
		as: 'Wed'.
	self
		assertPattern: 'EEE'
		isCompiledAs: #(2307)
		formats: self calendar
		as: 'Wed'.
	self
		assertPattern: 'EEEE'
		isCompiledAs: #(2308)
		formats: self calendar
		as: 'Wednesday'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_F [
	self
		assertPattern: 'F'
		isCompiledAs: #(2817)
		formats: self calendar
		as: '1'.
	self
		assertPattern: 'FF'
		isCompiledAs: #(2818)
		formats: self calendar
		as: '01'.
	self
		assertPattern: 'FFF'
		isCompiledAs: #(2819)
		formats: self calendar
		as: '001'.
	self
		assertPattern: 'FFFF'
		isCompiledAs: #(2820)
		formats: self calendar
		as: '1'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_G [
	self
		assertPattern: 'G'
		isCompiledAs: #(1)
		formats: self calendar
		as: 'AD'.
	self
		assertPattern: 'GG'
		isCompiledAs: #(2)
		formats: self calendar
		as: 'AD'.
	self
		assertPattern: 'GGG'
		isCompiledAs: #(3)
		formats: self calendar
		as: 'AD'.
	self
		assertPattern: 'GGGG'
		isCompiledAs: #(4)
		formats: self calendar
		as: 'AD'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_H [

	self
		assertPattern: 'H'
		isCompiledAs: #( 1281 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'HH'
		isCompiledAs: #( 1282 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'HHH'
		isCompiledAs: #( 1283 )
		formats: self calendar
		as: '012'.
	self
		assertPattern: 'HHHH'
		isCompiledAs: #( 1284 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'H'
		isCompiledAs: #( 1281 )
		formats: self calendar + (3600 * 12) negated seconds
		as: '0'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_K [

	self
		assertPattern: 'K'
		isCompiledAs: #( 4097 )
		formats: self calendar
		as: '0'.
	self
		assertPattern: 'KK'
		isCompiledAs: #( 4098 )
		formats: self calendar
		as: '00'.
	self
		assertPattern: 'KKK'
		isCompiledAs: #( 4099 )
		formats: self calendar
		as: '000'.
	self
		assertPattern: 'KKKK'
		isCompiledAs: #( 4100 )
		formats: self calendar
		as: '0'.
	self
		assertPattern: 'K'
		isCompiledAs: #( 4097 )
		formats: self calendar + (3600 * 12) negated asSeconds
		as: '0'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_L [
	self
		assertPattern: 'L'
		isCompiledAs: #(5633)
		formats: self calendar
		as: '7'.
	self
		assertPattern: 'LL'
		isCompiledAs: #(5634)
		formats: self calendar
		as: '07'.
	self
		assertPattern: 'LLL'
		isCompiledAs: #(5635)
		formats: self calendar
		as: 'Jul'.
	self
		assertPattern: 'LLLL'
		isCompiledAs: #(5636)
		formats: self calendar
		as: 'July'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_M [
	self
		assertPattern: 'M'
		isCompiledAs: #(513)
		formats: self calendar
		as: '7'.
	self
		assertPattern: 'MM'
		isCompiledAs: #(514)
		formats: self calendar
		as: '07'.
	self
		assertPattern: 'MMM'
		isCompiledAs: #(515)
		formats: self calendar
		as: 'Jul'.
	self
		assertPattern: 'MMMM'
		isCompiledAs: #(516)
		formats: self calendar
		as: 'July'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_S [
	self
		assertPattern: 'S'
		isCompiledAs: #(2049)
		formats: self calendar
		as: '235'.
	self
		assertPattern: 'SS'
		isCompiledAs: #(2050)
		formats: self calendar
		as: '235'.
	self
		assertPattern: 'SSS'
		isCompiledAs: #(2051)
		formats: self calendar
		as: '235'.
	self
		assertPattern: 'SSSS'
		isCompiledAs: #(2052)
		formats: self calendar
		as: '0235'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_W [
	self
		assertPattern: 'W'
		isCompiledAs: #(3329)
		formats: self calendar
		as: '1'.
	self
		assertPattern: 'WW'
		isCompiledAs: #(3330)
		formats: self calendar
		as: '01'.
	self
		assertPattern: 'WWW'
		isCompiledAs: #(3331)
		formats: self calendar
		as: '001'.
	self
		assertPattern: 'WWWW'
		isCompiledAs: #(3332)
		formats: self calendar
		as: '1'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_X [
	self
		assertPattern: 'X'
		isCompiledAs: #(5377)
		formats: self calendar
		as: '-07'.
	self
		assertPattern: 'XX'
		isCompiledAs: #(5378)
		formats: self calendar
		as: '-0700'.
	self
		assertPattern: 'XXX'
		isCompiledAs: #(5379)
		formats: self calendar
		as: '-07:00'.
	self
		should: [ self
				assertPattern: 'XXXX'
				isCompiledAs: #(5380)
				formats: self calendar
				as: '-0700' ]
		raise: Error
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_Y [
	self
		assertPattern: 'Y'
		isCompiledAs: #(4865)
		formats: self calendar
		as: '2001'.
	self
		assertPattern: 'YY'
		isCompiledAs: #(4866)
		formats: self calendar
		as: '01'.
	self
		assertPattern: 'YYY'
		isCompiledAs: #(4867)
		formats: self calendar
		as: '2001'.
	self
		assertPattern: 'YYYY'
		isCompiledAs: #(4868)
		formats: self calendar
		as: '2001'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_Z [
	self
		assertPattern: 'Z'
		isCompiledAs: #(4609)
		formats: self calendar
		as: '-0700'.
	self
		assertPattern: 'ZZ'
		isCompiledAs: #(4610)
		formats: self calendar
		as: '-0700'.
	self
		assertPattern: 'ZZZ'
		isCompiledAs: #(4611)
		formats: self calendar
		as: '-0700'.
	self
		assertPattern: 'ZZZZ'
		isCompiledAs: #(4612)
		formats: self calendar
		as: '-0700'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_a [
	self
		assertPattern: 'a'
		isCompiledAs: #(3585)
		formats: self calendar
		as: 'PM'.
	self
		assertPattern: 'aa'
		isCompiledAs: #(3586)
		formats: self calendar
		as: 'PM'.
	self
		assertPattern: 'aaa'
		isCompiledAs: #(3587)
		formats: self calendar
		as: 'PM'.
	self
		assertPattern: 'aaaa'
		isCompiledAs: #(3588)
		formats: self calendar
		as: 'PM'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_d [
	self
		assertPattern: 'd'
		isCompiledAs: #(769)
		formats: self calendar
		as: '4'.
	self
		assertPattern: 'dd'
		isCompiledAs: #(770)
		formats: self calendar
		as: '04'.
	self
		assertPattern: 'ddd'
		isCompiledAs: #(771)
		formats: self calendar
		as: '004'.
	self
		assertPattern: 'dddd'
		isCompiledAs: #(772)
		formats: self calendar
		as: '4'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_h [

	self
		assertPattern: 'h'
		isCompiledAs: #( 3841 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'hh'
		isCompiledAs: #( 3842 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'hhh'
		isCompiledAs: #( 3843 )
		formats: self calendar
		as: '012'.
	self
		assertPattern: 'hhhh'
		isCompiledAs: #( 3844 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'h'
		isCompiledAs: #( 3841 )
		formats: self calendar + (3600 * 12) negated seconds
		as: '12'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_k [

	self
		assertPattern: 'k'
		isCompiledAs: #( 1025 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'kk'
		isCompiledAs: #( 1026 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'kkk'
		isCompiledAs: #( 1027 )
		formats: self calendar
		as: '012'.
	self
		assertPattern: 'kkkk'
		isCompiledAs: #( 1028 )
		formats: self calendar
		as: '12'.
	self
		assertPattern: 'k'
		isCompiledAs: #( 1025 )
		formats: self calendar + (3600 * 12) negated seconds
		as: '24'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_m [
	self
		assertPattern: 'm'
		isCompiledAs: #(1537)
		formats: self calendar
		as: '8'.
	self
		assertPattern: 'mm'
		isCompiledAs: #(1538)
		formats: self calendar
		as: '08'.
	self
		assertPattern: 'mmm'
		isCompiledAs: #(1539)
		formats: self calendar
		as: '008'.
	self
		assertPattern: 'mmmm'
		isCompiledAs: #(1540)
		formats: self calendar
		as: '8'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_s [
	self
		assertPattern: 's'
		isCompiledAs: #(1793)
		formats: self calendar
		as: '56'.
	self
		assertPattern: 'ss'
		isCompiledAs: #(1794)
		formats: self calendar
		as: '56'.
	self
		assertPattern: 'sss'
		isCompiledAs: #(1795)
		formats: self calendar
		as: '056'.
	self
		assertPattern: 'ssss'
		isCompiledAs: #(1796)
		formats: self calendar
		as: '56'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_u [
	self
		assertPattern: 'u'
		isCompiledAs: #(5121)
		formats: self calendar
		as: '3'.
	self
		assertPattern: 'uu'
		isCompiledAs: #(5122)
		formats: self calendar
		as: '03'.
	self
		assertPattern: 'uuu'
		isCompiledAs: #(5123)
		formats: self calendar
		as: '003'.
	self
		assertPattern: 'uuuu'
		isCompiledAs: #(5124)
		formats: self calendar
		as: '3'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_w [
	self
		assertPattern: 'w'
		isCompiledAs: #(3073)
		formats: self calendar
		as: '27'.
	self
		assertPattern: 'ww'
		isCompiledAs: #(3074)
		formats: self calendar
		as: '27'.
	self
		assertPattern: 'www'
		isCompiledAs: #(3075)
		formats: self calendar
		as: '027'.
	self
		assertPattern: 'wwww'
		isCompiledAs: #(3076)
		formats: self calendar
		as: '27'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_y [
	self
		assertPattern: 'y'
		isCompiledAs: #(257)
		formats: self calendar
		as: '2001'.
	self
		assertPattern: 'yy'
		isCompiledAs: #(258)
		formats: self calendar
		as: '01'.
	self
		assertPattern: 'yyy'
		isCompiledAs: #(259)
		formats: self calendar
		as: '2001'.
	self
		assertPattern: 'yyyy'
		isCompiledAs: #(260)
		formats: self calendar
		as: '2001'
]

{ #category : #running }
DatePatternFormatterTest >> testDatePattern_z [
	self
		assertPattern: 'z'
		isCompiledAs: #(4353)
		formats: self calendar
		as: 'PDT'.
	self
		assertPattern: 'zz'
		isCompiledAs: #(4354)
		formats: self calendar
		as: 'PDT'.
	self
		assertPattern: 'zzz'
		isCompiledAs: #(4355)
		formats: self calendar
		as: 'PDT'.
	self
		assertPattern: 'zzzz'
		isCompiledAs: #(4356)
		formats: self calendar
		as: 'Pacific Daylight Time'
]
