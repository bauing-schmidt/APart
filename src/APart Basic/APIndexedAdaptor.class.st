Class {
	#name : #APIndexedAdaptor,
	#superclass : #APProtocolAdaptor,
	#instVars : [
		'index'
	],
	#category : #'APart Basic-Support'
}

{ #category : #'as yet unclassified' }
APIndexedAdaptor class >> forIndex: anIndex path: aSequencableCollection [

	^ (self path: aSequencableCollection) index: anIndex
]

{ #category : #'as yet unclassified' }
APIndexedAdaptor >> index: anInteger [

	index := anInteger
]

{ #category : #'as yet unclassified' }
APIndexedAdaptor >> privValueUsing: anObject [
	^ anObject ifNotNil: [ anObject at: index ] ifNil: [ nil ]
]

{ #category : #'as yet unclassified' }
APIndexedAdaptor >> setValueIn: anObject to: newValue [

	anObject ifNotNil: [ anObject at: index put: newValue ]
]

{ #category : #'as yet unclassified' }
APIndexedAdaptor >> update: anAspect with: aParameter from: anObject [
	anObject = defaultSubject
		ifTrue: [ super update: anAspect with: aParameter from: anObject.
			^ self ].
	(anAspect = #at: and: [ aParameter = index ])
		ifTrue: [ dependents update: #value with: nil from: self ]
]
