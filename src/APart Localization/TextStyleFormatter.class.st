Class {
	#name : #TextStyleFormatter,
	#superclass : #Object,
	#instVars : [
		'pattern',
		'handlers',
		'predicate'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
TextStyleFormatter >> append: anObject to: aText [

	^ aText append: anObject
]

{ #category : #accessing }
TextStyleFormatter >> functionAt: aKey [

	^ Dictionary new
		  at: 'equal' put: TextStyleConditionEqualFunction new;
		  at: 'lessThan' put: TextStyleConditionLessThanFunction new;
		  at: 'argument' put: TextStyleConditionArgIdentityFunction new;
		  at: 'offsetFromNow'
		  put: TextStyleConditionOffsetFromNowFunction new;
		  at: 'number' put: TextStyleConditionArgNumberFunction new;
		  at: 'unit' put: TextStyleConditionArgSelectorFunction new;
		  at: 'apply' put: TextStyleConditionApplyFunction new;
		  at: 'boolean' put: TextStyleConditionArgBooleanFunction new;
		  at: 'string' put: TextStyleConditionArgFunction new;
		  at: aKey
]

{ #category : #accessing }
TextStyleFormatter >> handlerForDate: aHandler [

	handlers at: 'format-date' put: aHandler
]

{ #category : #accessing }
TextStyleFormatter >> handlerForFontColor: aHandler [

	handlers at: 'font-color' put: aHandler
]

{ #category : #accessing }
TextStyleFormatter >> handlerForFontSize: aHandler [

	handlers at: 'font-size' put: aHandler
]

{ #category : #accessing }
TextStyleFormatter >> handlerForNumber: aHandler [

	handlers at: 'number' put: aHandler
]

{ #category : #accessing }
TextStyleFormatter >> handlerForSelector: aHandler [

	handlers at: 'selector' put: aHandler
]

{ #category : #accessing }
TextStyleFormatter >> handlerForString: aHandler [

	handlers at: 'string' put: aHandler
]

{ #category : #initialization }
TextStyleFormatter >> initialize [

	super initialize.

	handlers := Dictionary new.

	self
		handlerForString: TextStyleFormatHandlerString new;
		handlerForNumber: TextStyleFormatHandlerNumber new;
		handlerForDate: TextStyleFormatHandlerDate new;
		handlerForFontColor: TextStyleFormatHandlerFontColor new;
		handlerForFontSize: TextStyleFormatHandlerFontSize new;
		handlerForSelector: TextStyleFormatHandlerSelector new
]

{ #category : #accessing }
TextStyleFormatter >> pattern: anObject [

	pattern := anObject
]

{ #category : #accessing }
TextStyleFormatter >> predicate [

	^ predicate
]

{ #category : #accessing }
TextStyleFormatter >> predicate: aString [

	self predicate: aString from: 1 to: aString size
]

{ #category : #accessing }
TextStyleFormatter >> predicate: aString from: from to: to [

	| openIndex function closeIndex commaIndex innerCloseIndex |
	openIndex := aString indexOf: $( startingAt: from.

	closeIndex := aString findCloseParenthesisFor: openIndex.

	function := self functionAt:
		            (aString copyFrom: from to: openIndex - 1) trim asSymbol.

	innerCloseIndex := aString indexOf: $( startingAt: openIndex + 1.

	(innerCloseIndex = 0 or: [ innerCloseIndex > to ])
		ifTrue: [ 
			function argument:
				(aString copyFrom: openIndex + 1 to: closeIndex - 1) ]
		ifFalse: [ 
			innerCloseIndex := aString findCloseParenthesisFor: innerCloseIndex.

			self predicate: aString from: openIndex + 1 to: innerCloseIndex.

			function left: predicate.

			commaIndex := aString indexOf: $, startingAt: innerCloseIndex + 1.

			self predicate: aString from: commaIndex + 1 to: to.

			function right: predicate ].

	predicate := function
]

{ #category : #accessing }
TextStyleFormatter >> value: anObject [

	^ self value: anObject init: '' asText
]

{ #category : #conditionals }
TextStyleFormatter >> value: anObject ifMatch: mBlock ifMismatch: nmBlock [

	^ (predicate value: anObject)
		  ifTrue: mBlock
		  ifFalse: nmBlock
]

{ #category : #accessing }
TextStyleFormatter >> value: anObject init: init [

	| components |
	components := (pattern splitOn: $$) allButLast.

	^ components inject: init into: [ :aText :aPatternComponent | 
		  | tokens repr |
		  tokens := aPatternComponent findTokens: #( $[ $] ).

		  repr := tokens
			          foldr: [ :token :accumulated | 
				          (token splitOn: $=) bind: [ :property :value | 
					          handlers
						          at: property
						          ifPresent: [ :aHandler | 
						          aHandler interpretString: value on: accumulated ]
						          ifAbsent: [ accumulated ] ] ]
			          init: anObject.

		  self append: repr to: aText ]
]
