"
I formats the given calendar as DataAndTime object into a date/time string.

In order to do this I collaborate with DatePatternCompiler objects that provides me the compiled
form of the pattern that I have to use to format the given calendar. 

Moreover I delegate the formatting of individual fields to DatePatternFormatter objects.

Date and time formats are specified by date and time pattern strings. Within date and time pattern strings, unquoted letters from 'A' to 'Z' and from 'a' to 'z' are interpreted as pattern letters representing the components of a date or time string. Text can be quoted using single quotes (') to avoid interpretation. ""''"" represents a single quote. All other characters are not interpreted; they're simply copied into the output string during formatting or matched against the input string during parsing.

The following table will be used both as usege examples and test suite for my implementation:

yyyy.MM.dd G 'at' HH:mm:ss z       |2001.07.04 AD at 12:08:56 PDT
EEE, MMM d, ''yy                   |Wed, Jul 4, '01
h:mm a                             |12:08 PM
hh 'o''clock' a, zzzz              |12 o'clock PM, Pacific Daylight Time
K:mm a, z                          |0:08 PM, PDT
yyyyy.MMMMM.dd GGG hh:mm aaa       |02001.July.04 AD 12:08 PM
EEE, d MMM yyyy HH:mm:ss Z         |Wed, 4 Jul 2001 12:08:56 -0700
yyMMddHHmmssZ                      |010704120856-0700
yyyy-MM-dd'T'HH:mm:ss.SSSZ         |2001-07-04T12:08:56.235-0700
yyyy-MM-dd'T'HH:mm:ss.SSSXXX       |2001-07-04T12:08:56.235-07:00
YYYY-'W'ww-u                       |2001-W27-3
"
Class {
	#name : #DatePatternFormatter,
	#superclass : #Object,
	#instVars : [
		'datePatternCompiler',
		'patternIndexToCalendarField',
		'patternIndexToHandler'
	],
	#category : #'APart Localization'
}

{ #category : #'instance creation' }
DatePatternFormatter class >> on: aDatePatternCompiler [
	^ self basicNew
		datePatternCompiler: aDatePatternCompiler;
		initialize
]

{ #category : #accessing }
DatePatternFormatter >> datePatternCompiler: anObject [
	datePatternCompiler := anObject
]

{ #category : #utilities }
DatePatternFormatter >> fieldForTag: tag calendar: aDateAndTime [
	| anAssociation fieldBlock |
	anAssociation := patternIndexToCalendarField at: tag.
	anAssociation key = #WEEK_YEAR
		ifTrue: [ | ttag |
			ttag := DatePatternCompiler datetimePatterns at: 'PATTERN_YEAR'.
			anAssociation := patternIndexToCalendarField at: ttag ].
	fieldBlock := anAssociation value.
	^ fieldBlock value: aDateAndTime
]

{ #category : #API }
DatePatternFormatter >> format: aDateAndTime handler: aHandler [
	^ String
		streamContents: [ :buffer | 
			datePatternCompiler
				tagsAsciiCharDo: [ :aCharacter | buffer nextPut: aCharacter ]
				charsDo: [ :aString | buffer nextPutAll: aString ]
				otherwiseDo: [ :tag :count | 
					String
						streamContents: [ :current | 
							| field handleBlock |
							"Get the handler block."
							handleBlock := patternIndexToHandler
								at: tag
								ifAbsent: [ [ :handler :value | handler handle: value ] ].

							"Get the field value for the given date."
							field := self fieldForTag: tag calendar: aDateAndTime.

							"Prepare the arguments to be forwarded to the handler."
							aHandler
								count: count;
								current: current;
								buffer: buffer.

							"Handle the current tag."
							handleBlock value: aHandler value: field value.

							"Finally append everything on the `current` buffer, even if it is empty."
							buffer nextPutAll: current contents ] ] ]
]

{ #category : #initialization }
DatePatternFormatter >> initialize [
	super initialize.
	self
		initializeHandlers;
		initializeCalendarFields
]

{ #category : #initialization }
DatePatternFormatter >> initializeCalendarFields [
	patternIndexToCalendarField := Dictionary new
		at: 0 put: #ERA -> [ :aDateAndTime | aDateAndTime eraIndex ];
		at: 1 put: #YEAR -> [ :aDateAndTime | aDateAndTime year];
		at: 2 put: #MONTH -> [ :aDateAndTime | aDateAndTime month];
		at: 3 put: #DATE -> [ :aDateAndTime | aDateAndTime dayOfMonth];
		at: 4 put: #HOUR_OF_DAY -> [ :aDateAndTime | aDateAndTime hour24];
		at: 5 put: #HOUR_OF_DAY -> [ :aDateAndTime | aDateAndTime hour24];
		at: 6 put: #MINUTE -> [ :aDateAndTime | aDateAndTime minute];
		at: 7 put: #SECOND -> [ :aDateAndTime | aDateAndTime second];
		at: 8 put: #MILLISECOND -> [ :aDateAndTime | aDateAndTime milliseconds];
		at: 9 put: #DAY_OF_WEEK -> [ :aDateAndTime | aDateAndTime dayOfWeek];
		at: 10 put: #DAY_OF_YEAR -> [ :aDateAndTime | aDateAndTime dayOfYear];
		at: 11 put: #DAY_OF_WEEK_IN_MONTH -> [ :aDateAndTime | aDateAndTime dayOfWeekInMonth];
		at: 12 put: #WEEK_OF_YEAR -> [ :aDateAndTime | aDateAndTime weekOfYear];
		at: 13 put: #WEEK_OF_MONTH -> [ :aDateAndTime | aDateAndTime weekOfMonth];
		at: 14 put: #AM_PM -> [ :aDateAndTime | aDateAndTime meridianIndex];
		at: 15 put: #HOUR -> [ :aDateAndTime | aDateAndTime hour12];
		at: 16 put: #HOUR -> [ :aDateAndTime | aDateAndTime hour12];
		at: 17 put: #ZONE_OFFSET -> [ :aDateAndTime | aDateAndTime offset asMilliSeconds];
		at: 18 put: #ZONE_OFFSET -> [ :aDateAndTime | aDateAndTime offset asMilliSeconds];
		at: 19 put: #WEEK_YEAR -> [ :aDateAndTime |  nil]; 	"this is not used, even in the JDK."
		at: 20 put: #ISO_DAY_OF_WEEK -> [ :aDateAndTime | aDateAndTime dayOfWeekISO];
		at: 21 put: #ZONE_OFFSET -> [ :aDateAndTime | aDateAndTime offset asMilliSeconds];
		at: 22 put: #MONTH -> [ :aDateAndTime | aDateAndTime month];
		yourself
]

{ #category : #initialization }
DatePatternFormatter >> initializeHandlers [
	patternIndexToHandler := Dictionary new
		at: 0 put: [ :handler :value | handler handleEra: value ];
		at: 1 put: [ :handler :value | handler handleYear: value ];
		at: 2 put: [ :handler :value | handler handleMonth: value ];
		at: 3 put: [ :handler :value | handler handleDayOfMonth: value ];
		at: 4 put: [ :handler :value | handler handleHourOfDay1: value ];
		at: 5 put: [ :handler :value | handler handleHourOfDay0: value ];
		at: 6 put: [ :handler :value | handler handleMinute: value ];
		at: 7 put: [ :handler :value | handler handleSecond: value ];
		at: 8 put: [ :handler :value | handler handleMillisecond: value ];
		at: 9 put: [ :handler :value | handler handleDayOfWeek: value ];
		at: 10 put: [ :handler :value | handler handleDayOfYear: value ];
		at: 11 put: [ :handler :value | handler handleDayOfWeekInMonth: value ];
		at: 12 put: [ :handler :value | handler handleWeekOfYear: value ];
		at: 13 put: [ :handler :value | handler handleWeekOfMonth: value ];
		at: 14 put: [ :handler :value | handler handleAmPm: value ];
		at: 15 put: [ :handler :value | handler handleHour1: value ];
		at: 16 put: [ :handler :value | handler handleHour0: value ];
		at: 17 put: [ :handler :value | handler handleZoneName: value ];
		at: 18 put: [ :handler :value | handler handleZoneValue: value ];
		at: 19 put: [ :handler :value | handler handleYear: value ];
		at: 20 put: [ :handler :value | handler handleIsoDayOfWeek: value ];
		at: 21 put: [ :handler :value | handler handleIsoZone: value ];
		at: 22 put: [ :handler :value | handler handleMonthStandalone: value ];
		yourself
]
