Extension { #name : #DatePatternFormatterTest }

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
