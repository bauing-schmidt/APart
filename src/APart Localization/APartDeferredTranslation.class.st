Class {
	#name : #APartDeferredTranslation,
	#superclass : #Object,
	#instVars : [
		'string',
		'domain'
	],
	#category : #'APart Localization'
}

{ #category : #'instance creation' }
APartDeferredTranslation class >> for: aString in: domain [

	^ self new 
		string: aString;
		domain: domain;
		yourself
]

{ #category : #accessing }
APartDeferredTranslation >> domain [
	^ domain
]

{ #category : #accessing }
APartDeferredTranslation >> domain: anObject [
	domain := anObject
]

{ #category : #accessing }
APartDeferredTranslation >> isEmptyOrNil [

	^ string isEmptyOrNil
]

{ #category : #accessing }
APartDeferredTranslation >> localizedForPresenter: aPresenter [

	^ self translateFor: aPresenter locale
]

{ #category : #printing }
APartDeferredTranslation >> printOn: s [

	string ifNil: [^ super printOn: s].
	s << 'ADT{''';
		<< string;
		<< '''}'
]

{ #category : #accessing }
APartDeferredTranslation >> specLocaleChanged [

	('changed: ', self string asString) traceCr.
]

{ #category : #accessing }
APartDeferredTranslation >> string [
	^ string
]

{ #category : #accessing }
APartDeferredTranslation >> string: anObject [

	(anObject isKindOf: self class) ifTrue: [ 
		string := anObject string.
		^ self ].
	string := anObject
]

{ #category : #accessing }
APartDeferredTranslation >> translateFor: aLocale [

	aLocale ifNil: [^self string].
	^ (GetTextTranslator availableForLocaleID: aLocale localeID)
		translate: self string inDomain: self domain.
]

{ #category : #accessing }
APartDeferredTranslation >> value [ 
	^ string
]

{ #category : #accessing }
APartDeferredTranslation >> withAccentuatedCharacter: aCharacter [

	"do nothing"
]
