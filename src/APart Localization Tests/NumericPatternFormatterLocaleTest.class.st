Class {
	#name : #NumericPatternFormatterLocaleTest,
	#superclass : #NumericPatternFormatterTest,
	#category : #'APart Localization Tests'
}

{ #category : #testing }
NumericPatternFormatterLocaleTest class >> isAbstract [

	^ super isAbstract or: [ self name = #NumericPatternFormatterLocaleTest ]
			
]

{ #category : #accessing }
NumericPatternFormatterLocaleTest >> formatter [
	^ APartNumericPatternFormatter new
		locale: self locale;
		yourself
]

{ #category : #accessing }
NumericPatternFormatterLocaleTest >> locale [
	self subclassResponsibility
]
