Trait {
	#name : #APTPartWithLocale,
	#instVars : [
		'locale'
	],
	#category : #'APart Basic-Errors'
}

{ #category : #accessing }
APTPartWithLocale >> inheritsLocale [

	^ false
]

{ #category : #accessing }
APTPartWithLocale >> locale [ 

	^ locale ifNil: [ locale := APartLocale localeID: self localeIDToUse ].
]

{ #category : #accessing }
APTPartWithLocale >> locale: aLocale [

	^ locale := aLocale
]

{ #category : #accessing }
APTPartWithLocale >> localeIDToUse [
	^ LocaleID isoString: 'en-GB'
]
