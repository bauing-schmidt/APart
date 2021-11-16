"
APGenericFilterModule ist die Basisklasse für alle konkreten FilterModule-Klassen.


"
Class {
	#name : #APGenericFilterModule,
	#superclass : #Object,
	#instVars : [
		'model',
		'filterBlock',
		'notified'
	],
	#category : #'APart BasicParts'
}

{ #category : #'instance creation' }
APGenericFilterModule class >> filterBlock: aFilterBlock [

	^self on: nil filterBlock: aFilterBlock
]

{ #category : #'instance creation' }
APGenericFilterModule class >> on: aModel [

	^self new initOn: aModel
]

{ #category : #'instance creation' }
APGenericFilterModule class >> on: aModel filterBlock: aFilterBlock [

	^(self new initOn: aModel)
		filterBlock: aFilterBlock;
		yourself
]

{ #category : #API }
APGenericFilterModule >> applyFilterTo: aList [

	| v |
	v := self valueForFilterBlock.
	v size = 0 ifTrue: [^aList].
	^aList select: [:item | filterBlock value: item value: v]
]

{ #category : #'initialize-release' }
APGenericFilterModule >> close [

	model unsubscribeInterestsFor: notified.
	notified := nil.
	model := nil.
	filterBlock := nil
]

{ #category : #'initialize-release' }
APGenericFilterModule >> filterBlock: anObject [

	filterBlock := anObject
]

{ #category : #'initialize-release' }
APGenericFilterModule >> initOn: aModel [

	model := aModel.
]

{ #category : #API }
APGenericFilterModule >> notify: aFilterPart onChangeBy: aSelector [

	notified := aFilterPart.
	model onChangeSend: aSelector to: notified
]

{ #category : #private }
APGenericFilterModule >> valueForFilterBlock [

	^model value
]
