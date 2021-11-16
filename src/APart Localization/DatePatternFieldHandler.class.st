"
I perform the formatting of individual pattern fields and collaborate with DatePatternFormatter objects to support the formatting feature.

The following pattern letters are defined (all other characters from 'A' to 'Z' and from 'a' to 'z' are reserved):

Letter	Date or Time 	Component															Presentation				Examples
G							Era designator													Text						AD
y							Year																Year						1996; 96
Y							Week year															Year						2009; 09
M							Month in year (context sensitive)								Month						July; Jul; 07
L							Month in year (standalone form)								Month						July; Jul; 07
w							Week in year														Number						27
W							Week in month														Number						2
D							Day in year														Number						189
d							Day in month														Number						10
F							Day of week in month												Number						2
E							Day name in week													Text						Tuesday; Tue
u							Day number of week (1 = Monday, ..., 7 = Sunday)			Number						1
a							Am/pm marker														Text						PM
H							Hour in day (0-23)												Number						0
k							Hour in day (1-24)												Number						24
K							Hour in am/pm (0-11)												Number						0
h							Hour in am/pm (1-12)												Number						12
m							Minute in hour													Number						30
s							Second in minute													Number						55
S							Millisecond														Number						978
z							Time zone															General time zone		Pacific Standard Time; PST; GMT-08:00
Z							Time zone															RFC 822 time zone		-0800
X							Time zone															ISO 8601 time zone		-08; -0800; -08:00
"
Class {
	#name : #DatePatternFieldHandler,
	#superclass : #Object,
	#instVars : [
		'count',
		'current',
		'buffer'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
DatePatternFieldHandler >> buffer: anObject [
	buffer := anObject
]

{ #category : #accessing }
DatePatternFieldHandler >> count: anObject [
	count := anObject
]

{ #category : #accessing }
DatePatternFieldHandler >> current: anObject [
	current := anObject
]

{ #category : #utilities }
DatePatternFieldHandler >> eras [
	^ #(BC AD)
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handle: value [
	current isEmpty
		ifTrue: [ self
				zeroPaddingNumber: value
				minDigits: (self styleIfLong: [ 1 ] ifShort: [ count ])
				maxDigits: count ]
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleAmPm: value [
	(#(AM PM) at: value ifAbsent: [ nil ])
		ifNotNil: [ :ampm | current nextPutAll: ampm ]
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleDayOfMonth: value [
	self handle: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleDayOfWeek: value [
	| day |
	day := self
		styleIfLong: [ self longDayOfWeek: value ]
		ifShort: [ self shortDayOfWeek: value ].
	current nextPutAll: day
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleDayOfWeekInMonth: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleDayOfYear: value [
	self handle: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleEra: value [
	(self eras at: value ifAbsent: [ nil ])
		ifNotNil: [ :era | current nextPutAll: era ]
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleHour0: value [
	self handle: value \\ 12
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleHour1: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleHourOfDay0: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleHourOfDay1: value [
	self
		handle:
			(value = 0
				ifTrue: [ 24 ]
				ifFalse: [ value ])
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleIsoDayOfWeek: value [
	self handle: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleIsoZone: value [
	value = 0
		ifTrue: [ buffer nextPut: $Z ]
		ifFalse: [ | v |
			v := value // 60000.
			value >= 0
				ifTrue: [ buffer nextPut: $+ ]
				ifFalse: [ buffer nextPut: $-.
					v := v negated ].
			v // 60 printOn: buffer base: 10 nDigits: 2.
			count = 1
				ifFalse: [ count = 3
						ifTrue: [ buffer nextPut: $: ].
					v \\ 60 printOn: buffer base: 10 nDigits: 2 ] ]
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleMillisecond: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleMinute: value [
	self handle: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleMonth: value [
	self
		styleIfLong: [ current nextPutAll: (self longMonthName: value) ]
		ifShort: [ count = 3
				ifTrue: [ current nextPutAll: (self shortMonthName: value) ]
				ifFalse: [ self handle: value ] ]
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleMonthStandalone: value [
	self handleMonth: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleSecond: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleWeekOfMonth: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleWeekOfYear: value [
	self handle: value
]

{ #category : #'forwarding handling' }
DatePatternFieldHandler >> handleYear: value [
	self handle: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleZoneName: value [
	| zoneName |
	zoneName := self
		styleIfLong: [ self longTimeZoneName: value ]
		ifShort: [ self shortTimeZoneName: value ].
	buffer nextPutAll: zoneName
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> handleZoneValue: value [
	| v width |
	v := value // 60000.
	width := 4.
	value >= 0
		ifTrue: [ buffer nextPut: $+ ]
		ifFalse: [ width := width + 1 ].
	v := v // 60 * 100 + (v \\ 60).
	self zeroPaddingNumber: v length: width
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> longDayOfWeek: value [
	^ Week nameOfDay: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> longMonthName: value [
	^ Month nameOfMonth: value
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> longTimeZoneName: value [
	^ (self timezone: value) name
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> shortDayOfWeek: value [
	^ (Week nameOfDay: value) copyFrom: 1 to: 3
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> shortMonthName: value [
	^ (self longMonthName: value) copyFrom: 1 to: 3
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> shortTimeZoneName: value [
	^ (self timezone: value) abbreviation
]

{ #category : #utilities }
DatePatternFieldHandler >> styleIfLong: longBlock ifShort: shortBlock [
	^ count >= 4
		ifTrue: longBlock
		ifFalse: shortBlock
]

{ #category : #'primitive handling' }
DatePatternFieldHandler >> timezone: value [
	^ TimeZone offset: (Duration milliSeconds: value)
]

{ #category : #'numerical handling' }
DatePatternFieldHandler >> zeroDigit [
	^ self zeroDigitCharacter asInteger
]

{ #category : #'numerical handling' }
DatePatternFieldHandler >> zeroDigitCharacter [
	^ $0
]

{ #category : #'numerical handling' }
DatePatternFieldHandler >> zeroPaddingNumber: value length: length [
	"(value bitAnd: (1 << (length + 1)) - 1)"

	value
		printOn: buffer
		base: 10
		length: length
		padded: true
]

{ #category : #'numerical handling' }
DatePatternFieldHandler >> zeroPaddingNumber: value minDigits: minDigits maxDigits: maxDigits [
	value >= 0
		ifFalse: [ ^ self ].

	"Only positive values are taken into account, so start."
	(value < 100 and: [ minDigits between: 1 and: 2 ])
		ifTrue: [ value < 10
				ifTrue: [ minDigits = 2
						ifTrue: [ buffer nextPut: self zeroDigitCharacter ].
					buffer nextPut: (self zeroDigit + value) asCharacter ]
				ifFalse: [ buffer
						nextPut: (value // 10 + self zeroDigit) asCharacter;
						nextPut: (value \\ 10 + self zeroDigit) asCharacter ] ]
		ifFalse: [ (value between: 1000 and: 10000 - 1)
				ifTrue: [ minDigits = 4
						ifTrue: [ | v |
							v := value.
							buffer nextPut: (v // 1000 + self zeroDigit) asCharacter.
							v := v \\ 1000.
							buffer nextPut: (v // 100 + self zeroDigit) asCharacter.
							v := v \\ 100.
							buffer
								nextPut: (v // 10 + self zeroDigit) asCharacter;
								nextPut: (v \\ 10 + self zeroDigit) asCharacter ]
						ifFalse: [ (minDigits = 2 and: [ maxDigits = 2 ])
								ifTrue: [ self
										zeroPaddingNumber: value \\ 100
										minDigits: minDigits
										maxDigits: maxDigits ]
								ifFalse: [ self zeroPaddingNumber: value length: maxDigits ] ] ]
				ifFalse: [ self zeroPaddingNumber: value length: maxDigits ] ]
]
