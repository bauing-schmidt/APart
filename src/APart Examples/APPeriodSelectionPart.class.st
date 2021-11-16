Class {
	#name : #APPeriodSelectionPart,
	#superclass : #APart,
	#instVars : [
		'periodTypeEnum',
		'year',
		'month',
		'week',
		'day',
		'monthEnum',
		'fromDate',
		'toDate',
		'result',
		'enabledPeriodTypes'
	],
	#category : #'APart Examples-PeriodSelection'
}

{ #category : #'as yet unclassified' }
APPeriodSelectionPart class >> monthNameEnumeration [

	| enum |
	enum := APEnumeration named: #monthNameEnumeration.
	enum
		textFromKeyBlock: [:k | "Locale current timePolicy longMonthNames"
			 #('January' 'February' 'March' 'April' 'May' 'June' 'July' 'August' 'September' 'October' 'November' 'December') at: k].
	enum actionFromKeyBlock: [:k | k].
	1 to: 12
		do: 
			[:monthIdx |
			enum addEntry: ((APEnumEntry on: enum key: monthIdx)
						value: monthIdx;
						yourself)].
	^enum
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart class >> periodTypeEnumeration [

	| enum |
	enum := APEnumeration named: #periodTypeEnumeration.
	enum textFromKeyBlock: [:k | k].
	enum actionFromKeyBlock: [:k | k].
	self periodTypeKeys do: 
			[:v |
			enum addEntry: ((APEnumEntry on: enum key: v)
						value: v;
						yourself)].
	^enum
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart class >> periodTypeKeys [

	^#(#all #year #month #week #day #fromTo)
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> computeWeekForDate: aDate [

	| weekDict keys weekDay lastDay |
	weekDict := self getWeekNumberDictForYear: aDate year.
	keys := (weekDict keys collect: [:k | k asNumber]) asSortedCollection.
	keys do: 
			[:k |
			weekDay := weekDict at: k printString.
			weekDay > aDate ifFalse: [lastDay := weekDay]].
	^weekDict keyAtValue: lastDay
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> day [
	<aPartAspectEnabled: #dayInputCondition>

	^day
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> day: anObject [

	day := anObject.
	day ifNotNil: [self year: day year printString].
	self changedAspectValue: #day
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> dayInputCondition [

	<aPartAspectCondition>
	^APCondition on: [#day = periodTypeEnum value]
		ifNot: #notEnabled
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> defineAspects [

	self at: #yearL putCondition: self yearInputCondition.
	self at: #year
		validate: 
			[:yearValue |
			(yearValue allSatisfy: #isDigit)
				and: [yearValue asNumber between: 1900 and: Date today year]].
	self at: #yearRB
		putCondition: (APCondition on: [enabledPeriodTypes includes: #year]
				ifNot: #disabled).
	self at: #monthL putCondition: self monthInputCondition.
	self at: #monthRB
		putCondition: (APCondition on: [enabledPeriodTypes includes: #month]
				ifNot: #disabled).
	self at: #weekL putCondition: self weekInputCondition.
	self at: #week
		validate: 
			[:weekValue |
			((self getWeekNumberDictForYear: year asNumber) at: weekValue
				ifAbsent: [nil]) notNil].
	self at: #weekRB
		putCondition: (APCondition on: [enabledPeriodTypes includes: #week]
				ifNot: #disabled).
	self at: #dayL putCondition: self dayInputCondition.
	self at: #dayRB
		putCondition: (APCondition on: [enabledPeriodTypes includes: #day]
				ifNot: #disabled).
	self at: #toDateL putCondition: self fromToInputCondition.
	self at: #fromDateL putCondition: self fromToInputCondition.
	self at: #fromToRB
		putCondition: (APCondition on: [enabledPeriodTypes includes: #fromTo]
				ifNot: #disabled).
	self at: #periodTypeAllEnabled
		putCondition: (APCondition on: [enabledPeriodTypes includes: #all]
				ifNot: #disabled)
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> fromDate [
	<aPartAspectEnabled: #fromToInputCondition>

	^fromDate
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> fromDate: anObject [

	fromDate := anObject.
	self changedAspectValue: #fromDate.
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> fromToInputCondition [

	<aPartAspectCondition>
	^APCondition on: [#fromTo = periodTypeEnum value]
		ifNot: #notEnabled
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> getPeriod [

	| f y firstDay days w monday d d1 |
	f := periodTypeEnum value.
	f = #all ifTrue: [^Array with: nil with: nil].
	f = #year
		ifTrue: 
			[y := year asNumber.
			firstDay := Date newDay: 1 year: y.
			days := firstDay daysInYear - 1.
			^Array with: firstDay with: (firstDay addDays: days)].
	f = #month
		ifTrue: 
			[firstDay := Date
						newDay: 1
						month: month
						year: year asNumber.
			days := firstDay daysInMonth - 1.
			^Array with: firstDay with: (firstDay addDays: days)].
	f = #week
		ifTrue: 
			[w := week.
			y := year asNumber.
			monday := (self getWeekNumberDictForYear: y) at: w.
			^Array with: monday with: (monday addDays: 6)].
	f = #day
		ifTrue: 
			[d := self readDate: day.
			^Array with: d with: d].
	f = #fromTo
		ifTrue: 
			[d := self readDate: fromDate.
			d1 := self readDate: toDate.
			^Array with: d with: d1].
	^nil
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> getPeriodSelection [

	| period |
	period := self getPeriod.
	^PeriodSelection
		type: periodTypeEnum value
		fromDate: period first
		toDate: period second
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> getWeekNumberDictForYear: aYear [

	| dayName start weekDict firstDay |
	dayName := (Date newDay: 1 year: aYear) weekday.
	dayName = #Friday | (dayName = #Saturday) | (dayName = #Sunday)
		ifTrue: [start := 0]
		ifFalse: [start := 1].
	weekDict := Dictionary new.
	dayName = #Monday
		ifTrue: [firstDay := Date newDay: 1 year: aYear]
		ifFalse: [firstDay := (Date newDay: 1 year: aYear) previous: #Monday].
	start to: 52
		do: 
			[:i |
			weekDict at: i printString put: firstDay.
			firstDay := firstDay addDays: 7].
	^weekDict
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> initializeValues [

	super initializeValues.
	year := ''.
	week := ''.
	month := nil.
	day := nil.
	fromDate := nil.
	toDate := nil.
	enabledPeriodTypes := #(#year #month #week #day #fromTo).
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> isPromptable [

	^true
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> loginEnvironment [

	^parentPart ifNil: ["Globals"] ifNotNil: [:p | p loginEnvironment]
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> month [

	<aPartAspectEnabled: #monthInputCondition>
	^month
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> month: anObject [

	month := anObject.
	self changedAspectValue: #month
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> monthEnum [
	<aPartAspect>

	monthEnum ifNotNil: [^monthEnum].
	monthEnum := APEnumerationValuePart onPart: self key: #monthEnum.
	monthEnum enumeration: self class monthNameEnumeration.
	monthEnum trigger: #valueChanged
		do: 
			[self month: monthEnum value.
			self changedAspectValue: #'monthEnum valueText'].
	^monthEnum
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> monthInputCondition [

	<aPartAspectCondition>
	^APCondition on: [#month = periodTypeEnum value]
		ifNot: #notEnabled
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> okActionCondition [

	<aPartActionCondition>
	^APCondition on: [self periodTypeEnum value notNil]
		ifNot: #notPeriodTypeSelected
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> periodTypeEnum [
	<aPartAspect>

	periodTypeEnum ifNotNil: [^periodTypeEnum].
	periodTypeEnum := APEnumerationValuePart onPart: self key: #periodTypeEnum.
	periodTypeEnum
		enumeration: self class periodTypeEnumeration;
		trigger: #valueChanged do: [self periodTypeSelectionChanged].
	^periodTypeEnum
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> periodTypeSelectionChanged [

	| filter |
	filter := self periodTypeEnum value.
	filter = #all
		ifTrue: 
			[self year: ''.
			self monthEnum value: nil.
			self week: ''.
			self day: nil.
			self fromDate: nil.
			self toDate: nil].
	filter = #year
		ifTrue: 
			[self year: Date today year printString.
			self monthEnum value: nil.
			self week: ''.
			self day: nil.
			self fromDate: nil.
			self toDate: nil].
	filter = #month
		ifTrue: 
			[self year isEmpty ifTrue: [self year: Date today year printString].
			self week: ''.
			self day: nil.
			self fromDate: nil.
			self toDate: nil.
			self monthEnum value isNil
				ifTrue: [self monthEnum value: Date today monthIndex]].
	filter = #week
		ifTrue: 
			[self year isEmpty ifTrue: [self year: Date today year printString].
			self monthEnum value: nil.
			self day: nil.
			self fromDate: nil.
			self toDate: nil.
			self week isEmpty
				ifTrue: [self week: (self computeWeekForDate: Date today)]].
	filter = #day
		ifTrue: 
			[self year isEmpty ifTrue: [self year: Date today year printString].
			self monthEnum value: nil.
			self week: ''.
			self fromDate: nil.
			self toDate: nil.
			self day isNil ifTrue: [self day: Date today]].
	filter = #fromTo
		ifTrue: 
			[self year: ''.
			self monthEnum value: nil.
			self week: ''.
			self day: nil.
			self fromDate isNil
				ifTrue: 
					[self fromDate: Date today.
					self toDate: Date today]].
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> readDate: aDateOrNil [
	"eigentlich sollte das mittlerweile hier immer ein Date sein, da aber die Umstellung erst kürzlich geschah und vorher ein String hier übergeben wurde, behandeln wir den Fall vorsichtshalber hier auch noch"

	aDateOrNil isNil ifTrue: [^nil].
	aDateOrNil isString
		ifTrue: 
			[^[Locale current readDateFrom: aDateOrNil readStream] on: Error
				do: [:ex | nil]].
	^aDateOrNil
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> result [

	^result
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> setEnabledPeriodTypes: aPeriodTypeCol [

	aPeriodTypeCol do: 
			[:periodType |
			(self periodTypeEnum enumerationKeys includes: periodType)
				ifFalse: 
					[self error: 'Using unsupported period type: ' , periodType printString]].
	enabledPeriodTypes := aPeriodTypeCol
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> setPeriodSelection: aPeriodSelection [

	aPeriodSelection ifNil: [^nil].
	self periodTypeEnum value: aPeriodSelection type.
	self periodTypeEnum value = #year
		ifTrue: [self year: aPeriodSelection fromDate year printString].
	self periodTypeEnum value = #month
		ifTrue: 
			[self year: aPeriodSelection fromDate year printString.
			self month: aPeriodSelection fromDate monthIndex.
			self monthEnum value: self month].
	self periodTypeEnum value = #week
		ifTrue: 
			[self year: aPeriodSelection fromDate year printString.
			self week: aPeriodSelection fromDate weekIndex printString].
	self periodTypeEnum value = #day
		ifTrue: 
			[self year: aPeriodSelection fromDate year printString.
			self day: aPeriodSelection fromDate].
	self periodTypeEnum value = #fromTo
		ifTrue: 
			[self fromDate: aPeriodSelection fromDate.
			self toDate: aPeriodSelection toDate]
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> standardCancel [
	<aPartAction>

	result := nil.
	partInterface requestForPartClose
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> standardOK [
	<aPartActionIf: #okActionCondition>

	result := self getPeriodSelection.
	partInterface requestForPartClose.
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> toDate [

	<aPartAspectEnabled: #fromToInputCondition>
	^toDate
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> toDate: anObject [

	toDate := anObject.
	self changedAspectValue: #toDate
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> week [
	<aPartAspectEnabled: #weekInputCondition>

	^week
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> week: anObject [

	week := anObject.
	self changedAspectValue: #week
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> weekInputCondition [

	<aPartAspectCondition>
	^APCondition on: [#week = periodTypeEnum value]
		ifNot: #notEnabled
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> year [
	<aPartAspectEnabled: #yearInputCondition>

	^year
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> year: anObject [

	year := anObject.
	self changedAspectValue: #year.
]

{ #category : #'as yet unclassified' }
APPeriodSelectionPart >> yearInputCondition [

	<aPartAspectCondition>
	^APCondition on: [#(#year #month #week) includes: periodTypeEnum value]
		ifNot: #notEnabled
]
