Class {
	#name : #APartDeferredTranslationExtended,
	#superclass : #APartDeferredTranslation,
	#instVars : [
		'beforeBlock',
		'beforeArguments',
		'afterBlock',
		'afterArguments'
	],
	#category : #'APart Localization'
}

{ #category : #accessing }
APartDeferredTranslationExtended >> afterArguments [
	^ afterArguments ifNil: #()
]

{ #category : #accessing }
APartDeferredTranslationExtended >> afterArguments: anObject [
	afterArguments := anObject
]

{ #category : #accessing }
APartDeferredTranslationExtended >> afterBlock [
	^ afterBlock
]

{ #category : #accessing }
APartDeferredTranslationExtended >> afterBlock: anObject [
	afterBlock := anObject
]

{ #category : #accessing }
APartDeferredTranslationExtended >> beforeArguments [
	^ beforeArguments ifNil: #()
]

{ #category : #accessing }
APartDeferredTranslationExtended >> beforeArguments: anObject [
	beforeArguments := anObject
]

{ #category : #accessing }
APartDeferredTranslationExtended >> beforeBlock [
	^ beforeBlock
]

{ #category : #accessing }
APartDeferredTranslationExtended >> beforeBlock: anObject [
	beforeBlock := anObject
]

{ #category : #accessing }
APartDeferredTranslationExtended >> translateFor: aLocale [

	| aString  |
	
	aString := beforeBlock 
		ifNil: [ self string  ]
		ifNotNil: [ beforeBlock cull: self string cull: aLocale cull: self beforeArguments ].
	
	aString := (GetTextTranslator availableForLocaleID: aLocale localeID)
		translate: aString inDomain: self domain.

	aString := afterBlock 
		ifNil: [ aString ]
		ifNotNil: [ afterBlock cull: aString cull: aLocale cull: self afterArguments ].
		
	 ^ aString
	
]
