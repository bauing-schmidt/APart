Class {
	#name : #APAspectAdaptor,
	#superclass : #APProtocolAdaptor,
	#instVars : [
		'getSelector',
		'setSelector',
		'aspect'
	],
	#classInstVars : [
		'getSelector',
		'putSelector',
		'aspect',
		'subject',
		'dependents'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'as yet unclassified' }
APAspectAdaptor class >> forAspect: anAspectSymbol [

	^self new forAspect: anAspectSymbol
]

{ #category : #'as yet unclassified' }
APAspectAdaptor class >> forAspect: anAspectSymbol path: aSequencableCollection [

	^ (self path: aSequencableCollection) forAspect: anAspectSymbol
]

{ #category : #accessing }
APAspectAdaptor >> aspect [

	^aspect ifNil: [getSelector]
		ifNotNil: [aspect]
]

{ #category : #accessing }
APAspectAdaptor >> forAspect: anAspect [
	self getSelector: anAspect setSelector: (anAspect , ':') asSymbol
]

{ #category : #accessing }
APAspectAdaptor >> getSelector: getSymbol setSelector: putSymbol [

	self getSelector: getSymbol setSelector: putSymbol aspect: nil
]

{ #category : #accessing }
APAspectAdaptor >> getSelector: getSymbol setSelector: putSymbol aspect: aspectSymbol [

	getSelector := getSymbol asSymbol.
	setSelector := putSymbol asSymbol.
	aspect := aspectSymbol
]

{ #category : #accessing }
APAspectAdaptor >> initialize [
	super initialize.
	self getSelector: #value setSelector: #value: aspect: nil
]

{ #category : #accessing }
APAspectAdaptor >> privValueUsing: anObject [

	^ anObject ifNotNil: [ anObject aPartPerform: getSelector ]
]

{ #category : #accessing }
APAspectAdaptor >> setValueIn: anObject to: newValue [
	anObject == nil
		ifFalse: [ anObject aPartPerform: setSelector with: newValue ]
]

{ #category : #accessing }
APAspectAdaptor >> update: anAspect with: parameter from: sender [

	((anAspect = self aspect) and: [ sender == defaultSubject ])
		ifTrue: [ dependents update: #value with: parameter from: self ]
		ifFalse: [ super update: anAspect with: parameter from: sender ]
]
