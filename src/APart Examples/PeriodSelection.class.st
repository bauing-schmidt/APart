Class {
	#name : #PeriodSelection,
	#superclass : #Object,
	#instVars : [
		'type',
		'fromDate',
		'toDate'
	],
	#category : #'APart Examples-PeriodSelection'
}

{ #category : #'as yet unclassified' }
PeriodSelection class >> type: aPeriodType fromDate: aFromDate toDate: aToDate [

	^(self new)
		type: aPeriodType;
		fromDate: aFromDate;
		toDate: aToDate;
		yourself
]

{ #category : #accessing }
PeriodSelection >> fromDate [

	^fromDate
]

{ #category : #accessing }
PeriodSelection >> fromDate: anObject [

	fromDate := anObject
]

{ #category : #accessing }
PeriodSelection >> printModel [

	type = #all
		ifTrue: 
			[^(self aPartTranslateDeferred: 'Entire project period')
				expandMacros].
	type = #year
		ifTrue: 
			[^(self aPartTranslateDeferred: 'year:  <1s>')
				expandMacrosWith: fromDate year asString].
	type = #month
		ifTrue: 
			[^(self aPartTranslateDeferred: 'month <1s> in Year <2s>')
				expandMacrosWith: (Locale current timePolicy longMonthNames
						at: fromDate monthIndex)
				with: fromDate year].
	type = #week
		ifTrue: 
			[^(self aPartTranslateDeferred: 'week <1s> in year <2s>')
				expandMacrosWith: fromDate weekIndex
				with: fromDate year].
	type = #day
		ifTrue: 
			[^(self aPartTranslateDeferred: #'day:  <1s>') expandMacrosWith: fromDate].
	type = #fromTo
		ifTrue: 
			[^(self aPartTranslateDeferred: 'From <1s> to <2s>')
				expandMacrosWith: fromDate
				with: toDate].
	^''
]

{ #category : #accessing }
PeriodSelection >> printString [

	^self printModel
]

{ #category : #accessing }
PeriodSelection >> toDate [

	^toDate
]

{ #category : #accessing }
PeriodSelection >> toDate: anObject [

	toDate := anObject
]

{ #category : #accessing }
PeriodSelection >> type [

	^type
]

{ #category : #accessing }
PeriodSelection >> type: anObject [

	type := anObject
]
