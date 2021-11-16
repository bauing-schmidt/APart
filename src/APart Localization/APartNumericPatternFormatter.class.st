"
I subclass `NumericPatternFormatter` in order to let the number formatting task be dependent on the current APartLocale.
"
Class {
	#name : #APartNumericPatternFormatter,
	#superclass : #NumericPatternFormatter,
	#instVars : [
		'locale'
	],
	#category : #'APart Localization'
}

{ #category : #'instance creation' }
APartNumericPatternFormatter class >> locale: aLocale [
	^self new 
		locale: aLocale;
		yourself
]

{ #category : #formatting }
APartNumericPatternFormatter >> decimalSeparator [
	^ $c
]

{ #category : #accessing }
APartNumericPatternFormatter >> locale: aAPartLocale [
	locale := aAPartLocale
]

{ #category : #formatting }
APartNumericPatternFormatter >> primDecimalSymbol [
	^ locale primDecimalSymbol
]

{ #category : #formatting }
APartNumericPatternFormatter >> primDigitGrouping [
	^ locale primDigitGrouping
]

{ #category : #formatting }
APartNumericPatternFormatter >> thousandSeparator [
	^ $t
]
