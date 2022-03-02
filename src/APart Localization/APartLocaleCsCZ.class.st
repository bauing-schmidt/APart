Class {
	#name : #APartLocaleCsCZ,
	#superclass : #APartLocale,
	#category : #'APart Localization'
}

{ #category : #accessing }
APartLocaleCsCZ class >> isoCountry [

	^ 'CZ'
]

{ #category : #accessing }
APartLocaleCsCZ class >> isoLanguage [ 

	^ 'cs'
]

{ #category : #accessing }
APartLocaleCsCZ class >> languageName [

	^ 'Czech'
]

{ #category : #utilities }
APartLocaleCsCZ >> eras [
	^ Array with: 'př. Kr.' with: 'po Kr.'
]

{ #category : #utilities }
APartLocaleCsCZ >> longDayOfWeek: value [
	^ #( Neděle Pondělí Úterý Středa Čtvrtek Pátek Sobota )
		at: value
]

{ #category : #utilities }
APartLocaleCsCZ >> longTimeZoneName: value decoded: aString [
	^ Dictionary new
		at: 'Universal Time' put: 'Univerzální čas';
		at: 'Greenwich Mean Time' put: 'Greenwichský čas';
		at: 'British Summer Time' put: 'Britský letní čas';
		at: 'South African Standard Time' put: 'Jihoafrický standardní čas';
		at: 'Pacific Standard Time' put: 'Tichomořský standardní čas';
		at: 'Pacific Daylight Time' put: 'Tichomořský letní čas';
		at: 'Mountain Standard Time' put: 'Horský standardní čas';
		at: 'Mountain Daylight Time' put: 'Horský letní čas';
		at: 'Central Standard Time' put: 'Centrální standardní čas';
		at: 'Central Daylight Time' put: 'Centrální letní čas';
		at: 'Eastern Standard Time' put: 'východní standardní čas';
		at: 'Eastern Daylight Time' put: 'Východní letní čas';
		at: aString
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> monthNames [

	^ #('leden' 'únor' 'březen' 'duben' 'květen' 'černven' 'červenec' 'srpen' 'září' 'říjen' 'listopad' 'prosinec')
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primCountry [

	^ 'CZ'
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primCurrencyNotation [

	^ false
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primCurrencySymbol [

	^ 'CZK'
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primDST [

	^ true
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primDecimalSymbol [

	^ ','
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primDigitGrouping [

	^ '.'
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primLanguage [
	
	^ 'cs'
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primLongDateFormat [

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
APartLocaleCsCZ >> primMeasurement [

	^ true
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primShortDateFormat [

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
APartLocaleCsCZ >> primTimeFormat [

	^ 'H:mm'
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> primTimezone [

	^ 01*60
]

{ #category : #utilities }
APartLocaleCsCZ >> shortDayOfWeek: value [
	^ (self longDayOfWeek: value) copyFrom: 1 to: 2
]

{ #category : #'system primitives' }
APartLocaleCsCZ >> shortMonthNames [

	^ #('led' 'ún' 'bře' 'dub' 'kvě' 'čvn' 'čvc' 'srp' 'zář' 'říj' 'lis' 'pro')
	
]
