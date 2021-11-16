"
I subclass DatePatternFieldHandler to explicitly depend on APartLocale to take into account customizations according to the current locale.
"
Class {
	#name : #APartDatePatternFieldHandler,
	#superclass : #DatePatternFieldHandler,
	#instVars : [
		'locale'
	],
	#category : #'APart Localization'
}

{ #category : #utilities }
APartDatePatternFieldHandler >> eras [
	^ locale eras
]

{ #category : #accessing }
APartDatePatternFieldHandler >> locale [
	^ locale
]

{ #category : #accessing }
APartDatePatternFieldHandler >> locale: anObject [
	locale := anObject
]

{ #category : #'primitive handling' }
APartDatePatternFieldHandler >> longDayOfWeek: value [
	^ locale longDayOfWeek: value
]

{ #category : #'primitive handling' }
APartDatePatternFieldHandler >> longMonthName: value [
	^ locale longMonthName: value
]

{ #category : #'primitive handling' }
APartDatePatternFieldHandler >> longTimeZoneName: value [
	^ locale
		longTimeZoneName: value
		decoded: (super longTimeZoneName: value)
]

{ #category : #'primitive handling' }
APartDatePatternFieldHandler >> shortDayOfWeek: value [
	^ locale shortDayOfWeek: value
]

{ #category : #'primitive handling' }
APartDatePatternFieldHandler >> shortMonthName: value [
	^ locale shortMonthName: value
]
