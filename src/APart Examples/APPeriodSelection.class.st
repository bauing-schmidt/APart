Class {
	#name : #APPeriodSelection,
	#superclass : #APartPresenter,
	#instVars : [
		'periodTypeAllEnabled'
	],
	#category : #'APart Examples-PeriodSelection'
}

{ #category : #API }
APPeriodSelection class >> matchingPartClass [

	^APPeriodSelectionPart
]

{ #category : #'as yet unclassified' }
APPeriodSelection >> computeWeekForDate: aDate [

	| weekDict keys weekDay lastDay |
	weekDict := self getWeekNumberDictForYear: aDate year.
	keys := (weekDict keys collect: [:k | k asNumber]) asSortedCollection.
	keys do: 
			[:k |
			weekDay := weekDict at: k printString.
			weekDay > aDate ifFalse: [lastDay := weekDay]].
	^weekDict keyAtValue: lastDay
]
