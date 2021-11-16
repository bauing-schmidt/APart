Extension { #name : #String }

{ #category : #'*APart Localization' }
String >> translateFor: localeId [

	^ self
]

{ #category : #'*APart Localization' }
String >> zeroSharpFormat: aNumber forLocale: aLocale [
	^ (NumericPatternFormatter on: self) format: aNumber
]
