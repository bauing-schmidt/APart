Class {
	#name : #APartLocaleEnGB,
	#superclass : #APartLocale,
	#category : #'APart Localization'
}

{ #category : #accessing }
APartLocaleEnGB class >> isoCountry [

	^ 'GB'
]

{ #category : #accessing }
APartLocaleEnGB class >> isoLanguage [ 

	^ 'en'
]

{ #category : #accessing }
APartLocaleEnGB class >> languageName [

	^ 'English'
]

{ #category : #utilities }
APartLocaleEnGB >> eras [
	^ Array with: 'BC' with: 'AD'
]

{ #category : #utilities }
APartLocaleEnGB >> longDayOfWeek: value [
	^ #(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)
		at: value
]

{ #category : #utilities }
APartLocaleEnGB >> longTimeZoneName: value decoded: aString [
	^ aString
]

{ #category : #'system primitives' }
APartLocaleEnGB >> monthNames [

	^ #('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December')
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primCountry [

	^ 'CZ'
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primCurrencyNotation [

	^ false
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primCurrencySymbol [

	^ 'GBP'
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primDST [

	^ true
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primDecimalSymbol [

	^ '.'
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primDigitGrouping [

	^ ','
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primLanguage [
	
	^ 'en'
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primLongDateFormat [

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
APartLocaleEnGB >> primMeasurement [

	^ false
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primShortDateFormat [

	^ #(1 2 3 $/ 1 1 1 )
	
"		#(item item item sep monthfmt yearfmt twoDigits) 
		items: 1=day 2=month 3=year will appear in the order given, 
		separated by sep which is eaither an ascii code or character. 
		monthFmt: 1=09 2=Sep 3=September 
		yearFmt: 1=1996 2=96 
		digits: (missing or)1=9 2=09. 
"
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primTimeFormat [

	^ 'h:mmx'
]

{ #category : #'system primitives' }
APartLocaleEnGB >> primTimezone [

	^ 0*60
]

{ #category : #'system primitives' }
APartLocaleEnGB >> shortMonthNames [

	^ #('Jan' 'Feb' 'Mar' 'Apr' 'May' 'Jun' 'Jul' 'Aug' 'Sep' 'Oct' 'Nov' 'Dec')
]

{ #category : #'system primitives' }
APartLocaleEnGB >> weekStart [

	^ 7
]
