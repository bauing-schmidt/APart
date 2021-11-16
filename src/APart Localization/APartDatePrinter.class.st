Class {
	#name : #APartDatePrinter,
	#superclass : #ExtendedDatePrinter,
	#instVars : [
		'locale'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
APartDatePrinter >> locale [
	^ locale
]

{ #category : #accessing }
APartDatePrinter >> locale: anObject [
	locale := anObject
]

{ #category : #printing }
APartDatePrinter >> nameOfMonth: monthIndex [

	^ self locale monthNames at: monthIndex
	
]

{ #category : #printing }
APartDatePrinter >> printDate: aDate format: formatArray on: aStream [

	"Print a description of aDate on aStream using the format 
	denoted the argument, formatArray: 
	
		#(item item item sep monthfmt yearfmt twoDigits) 
	
		items: 1=day 2=month 3=year will appear in the order given, 
	
		separated by sep which is eaither an ascii code or character. 
	
		monthFmt: 1=09 2=Sep 3=September 
	
		yearFmt: 1=1996 2=96 
	
		digits: (missing or)1=9 2=09. 
	
	See the examples in printOn: and mmddyy"
	| day month year twoDigits element monthFormat |
	aDate dayMonthYearDo: [ :d :m :y | day := d. month := m. year := y ].
	twoDigits := formatArray size > 6 and: [ (formatArray at: 7) > 1 ].
	1 to: 3 do:  [ :i | 
		element := formatArray at: i.
		element = 1
			ifTrue: [
				twoDigits
					ifTrue: [ day printOn: aStream base: 10 length: 2 padded: true ]
					ifFalse: [ day printOn: aStream ] ].
		element = 2
			ifTrue: [
				monthFormat := formatArray at: 5.
				monthFormat = 1
					ifTrue: [
						twoDigits
							ifTrue: [ month printOn: aStream base: 10 length: 2 padded: true ]
							ifFalse: [ month printOn: aStream]].
				monthFormat = 2
					ifTrue: [ (self shortNameOfMonth: month) do: [ :each | aStream nextPut: each ] ].
				monthFormat = 3
					ifTrue: [ aStream nextPutAll: (self nameOfMonth: month) ] ].
		element = 3
			ifTrue: [
				(formatArray at: 6) = 1
					ifTrue: [ year printOn: aStream base: 10 length: 4 padded: true ]
					ifFalse: [ (year \\ 100) printOn: aStream base: 10 length: 2 padded: true ] ].
		i < 3
			ifTrue: [
				(formatArray at: 4) ~= 0
					ifTrue: [ aStream nextPut: (formatArray at: 4) asCharacter ] ] ]
]

{ #category : #printing }
APartDatePrinter >> shortNameOfMonth: monthIndex [

	^ self locale shortMonthNames at: monthIndex

]
