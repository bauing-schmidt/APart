Extension { #name : #DateAndTime }

{ #category : #'*APart Localization' }
DateAndTime >> dayOfWeekISO [
	| d |
	d := self dayOfWeek.
	^ d = 1
		ifTrue: [ 7 ]
		ifFalse: [ d - 1 ]
]

{ #category : #'*APart Localization' }
DateAndTime >> dayOfWeekInMonth [
	^ (self dayOfMonth + 6) // 7
]

{ #category : #'*APart Localization' }
DateAndTime >> eraIndex [
	^ self year < 0
		ifTrue: [ 1 ]
		ifFalse: [ 2 ]
]

{ #category : #'*APart Localization' }
DateAndTime >> format: aPattern [
	^ self format: aPattern fieldsHandler: DatePatternFieldHandler new
]

{ #category : #'*APart Localization' }
DateAndTime >> format: aPattern fieldsHandler: aHandler [
	| compiler |
	compiler := DatePatternCompiler on: aPattern.
	^ (DatePatternFormatter on: compiler) format: self handler: aHandler
]

{ #category : #'*APart Localization' }
DateAndTime >> meridianIndex [
	"According to the chronological ordering."

	^ self meridianAbbreviation = 'AM'
		ifTrue: [ 1 ]
		ifFalse: [ 2 ]
]

{ #category : #'*APart Localization' }
DateAndTime >> translateFor: localeId [

	^ self asString translateFor: localeId
]

{ #category : #'*APart Localization' }
DateAndTime >> weekOfMonth [
	^ self asWeek index
]

{ #category : #'*APart Localization' }
DateAndTime >> weekOfYear [
	| c w |
	c := 0.
	w := self asWeek.
	[ w years includes: self asYear ]
		whileTrue: [ c := c + 1.
			w := w previous ].
	^ c
]
