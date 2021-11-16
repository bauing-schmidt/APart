Class {
	#name : #APartLocale,
	#superclass : #Object,
	#instVars : [
		'localeID',
		'properties'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
APartLocale class >> fromIsoString: isoString [

	^APartLocale localeID: (LocaleID isoString: isoString)

]

{ #category : #accessing }
APartLocale class >> isoCountry [

	^ self subclassResponsibility 
]

{ #category : #accessing }
APartLocale class >> isoLanguage [

	^ self subclassResponsibility 
]

{ #category : #accessing }
APartLocale class >> localeID [ 

	^ LocaleID isoLanguage: self isoLanguage isoCountry: self isoCountry 
]

{ #category : #accessing }
APartLocale class >> localeID: localeID [

	| localeClass |
	
	localeClass := self subclasses detect: [ :each |
		localeID isoLanguage = each isoLanguage and: [ localeID isoCountry = each isoCountry ] ] ifNone: [ self aPartError: #unknownLocale attribute: localeID ].
	
	^ localeClass new
]

{ #category : #printing }
APartLocale >> = anotherObject [

	self class == anotherObject class
		ifFalse: [^false].
	^self localeID = anotherObject localeID
]

{ #category : #utilities }
APartLocale >> eras [
	self subclassResponsibility
]

{ #category : #printing }
APartLocale >> fileSizes [
	^ OrderedCollection new
		add: 12 -> #TB;
		add: 9 -> #GB;
		add: 6 -> #MB;
		add: 3 -> #KB;
		add: 0 -> #B;
		yourself
]

{ #category : #printing }
APartLocale >> hash [
	^self localeID hash
]

{ #category : #initialization }
APartLocale >> initialize [

	properties := Dictionary new
]

{ #category : #initialization }
APartLocale >> initializePropertiesFrom: otherLocale [
	"As the locale-specific properties play a special role, they have to be prepared before the announcement is sent."

	properties := otherLocale properties.
	properties valuesDo: [ :p | p localeSwitchedTo: self ]
]

{ #category : #accessing }
APartLocale >> isoLanguage [
	^self class isoLanguage
]

{ #category : #printing }
APartLocale >> localeID [ 

	localeID ifNil: [ localeID := self class localeID ].
	^ localeID
]

{ #category : #printing }
APartLocale >> localeName [ 

	^ self localeID isoString
]

{ #category : #utilities }
APartLocale >> longDayOfWeek: value [
	self subclassResponsibility
]

{ #category : #utilities }
APartLocale >> longMonthName: value [
	^ self monthNames at: value
]

{ #category : #utilities }
APartLocale >> longTimeZoneName: value decoded: aString [
	self subclassResponsibility
]

{ #category : #utilities }
APartLocale >> monthNames [
	self subclassResponsibility
]

{ #category : #printing }
APartLocale >> printDate: aDate format: formatArray [

	^ String new: 16 streamContents: [ :aStream |
		(APartDatePrinter new locale: self)
			printDate: aDate format: formatArray on: aStream ]
]

{ #category : #printing }
APartLocale >> printStringDate: aDate format: formatArray [

	^ String new: 16 streamContents: [ :aStream |
		(APartDatePrinter new locale: self)
			printDate: aDate format: formatArray on: aStream ]
]

{ #category : #printing }
APartLocale >> printStringDateAndTime: aDateAndTime [

	^ (self printStringDateShort: aDateAndTime), ' ', (self printStringTimeHMS: aDateAndTime)
]

{ #category : #printing }
APartLocale >> printStringDateLong: aDate [ 

	^ self printStringDate: aDate format: self primLongDateFormat
]

{ #category : #printing }
APartLocale >> printStringDateShort: aDate [ 

	^ self printStringDate: aDate format: self primShortDateFormat
]

{ #category : #printing }
APartLocale >> printStringTimeHM: time [ 

 	^ String new: 4 streamContents: [ :aStream | 
		time hour printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPutAll: ':'.
		time minute printOn: aStream base: 10 length: 2 padded: true ]
]

{ #category : #printing }
APartLocale >> printStringTimeHMS: time [ 

 	^ String new: 4 streamContents: [ :aStream | 
		time hour printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPutAll: ':'.
		time minute printOn: aStream base: 10 length: 2 padded: true.
		aStream nextPutAll: ':'.
		time seconds printOn: aStream base: 10 length: 2 padded: true  ]
]

{ #category : #accessing }
APartLocale >> properties [
	^ properties
]

{ #category : #properties }
APartLocale >> propertyAt: aPropKey [

	^properties at: aPropKey ifAbsent: [  ]
]

{ #category : #properties }
APartLocale >> propertyAt: aPropKey ifAbsent: absentBlock [

	^properties at: aPropKey ifAbsent: absentBlock
]

{ #category : #properties }
APartLocale >> propertyAt: aPropKey put: aValue [

	^properties at: aPropKey put: aValue
]

{ #category : #utilities }
APartLocale >> shortDayOfWeek: value [
	^ (self longDayOfWeek: value) copyFrom: 1 to: 3
]

{ #category : #utilities }
APartLocale >> shortMonthName: value [
	^ self shortMonthNames at: value
]

{ #category : #utilities }
APartLocale >> shortMonthNames [
	self subclassResponsibility
]
