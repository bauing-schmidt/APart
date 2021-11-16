Class {
	#name : #APartLocaleDeDE,
	#superclass : #APartLocale,
	#category : #'APart Localization'
}

{ #category : #accessing }
APartLocaleDeDE class >> isoCountry [

	^ 'DE'
]

{ #category : #accessing }
APartLocaleDeDE class >> isoLanguage [ 

	^ 'de'
]

{ #category : #accessing }
APartLocaleDeDE class >> languageName [

	^ 'German'
]

{ #category : #utilities }
APartLocaleDeDE >> eras [
	^ Array with: 'v. Chr.' with: 'n. Chr.'
]

{ #category : #utilities }
APartLocaleDeDE >> longDayOfWeek: value [
	^ #(Dienstag Mittwoch Donnerstag Freitag Samstag Sonntag Montag)
		at: value - self weekStart
]

{ #category : #'as yet unclassified' }
APartLocaleDeDE >> longTimeZoneName: value decoded: aString [
	^ Dictionary new
		at: 'Universal Time' put: 'Weltzeit';
		at: 'Greenwich Mean Time' put: 'Greenwich Mittlere Zeit';
		at: 'British Summer Time' put: 'Britische Sommerzeit';
		at: 'South African Standard Time'
			put: 'Südafrikanische Standardzeit';
		at: 'Pacific Standard Time' put: 'Pazifische Standardzeit';
		at: 'Pacific Daylight Time' put: 'Pazifische Tageslichtzeit';
		at: 'Mountain Standard Time' put: 'Berg Standardzeit';
		at: 'Mountain Daylight Time' put: 'Sommerzeit in den Bergen';
		at: 'Central Standard Time' put: 'Zentrale Standardzeit';
		at: 'Central Daylight Time' put: 'Zentrale Sommerzeit';
		at: 'Eastern Standard Time' put: 'Östliche Standardzeit';
		at: 'Eastern Daylight Time' put: 'östliche Sommerzeit';
		at: aString
]

{ #category : #'system primitives' }
APartLocaleDeDE >> monthNames [

	^ #('Januar' 'Februar' 'März' 'April' 'Mai' 'Juni' 'Juli' 'August' 'September' 'Oktober' 'November' 'Dezember')
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primCountry [

	^ 'DE'
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primCurrencyNotation [

	^ false
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primCurrencySymbol [

	^ 'EUR'
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primDST [

	^ true
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primDecimalSymbol [

	^ ','
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primDigitGrouping [

	^ '.'
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primLanguage [
	
	^ 'de'
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primLongDateFormat [

	^ #(1 2 3 $  3 1 1 )
	
"		#(item item item sep monthfmt yearfmt twoDigits) 
		items: 1=day 2=month 3=year will appear in the order given, 
		separated by sep which is eaither an ascii code or character. 
		monthFmt: 1=09 2=Sep 3=September 
		yearFmt: 1=1996 2=96 
		digits: (missing or)1=9 2=09. 
"
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primMeasurement [

	^ true
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primShortDateFormat [

	^ #(1 2 3 $. 1 1 1 )
	
"		#(item item item sep monthfmt yearfmt twoDigits) 
		items: 1=day 2=month 3=year will appear in the order given, 
		separated by sep which is eaither an ascii code or character. 
		monthFmt: 1=09 2=Sep 3=September 
		yearFmt: 1=1996 2=96 
		digits: (missing or)1=9 2=09. 
"
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primTimeFormat [

	^ 'H:mm'
]

{ #category : #'system primitives' }
APartLocaleDeDE >> primTimezone [

	^ 01*60
]

{ #category : #'system primitives' }
APartLocaleDeDE >> shortMonthNames [

	^ #('Jan' 'Feb' 'Mär' 'Apr' 'Mai' 'Jun' 'Jul' 'Aug' 'Sep' 'Okt' 'Nov' 'Dez')
]

{ #category : #'system primitives' }
APartLocaleDeDE >> weekStart [

	^ 2
]
