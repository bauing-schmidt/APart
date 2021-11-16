"
APartAbstractSequence ist die gemeinsame Basisklasse für generische Kontexte auf List bzw. Tree.
"
Class {
	#name : #APartAbstractSequence,
	#superclass : #APart,
	#traits : 'APTPartWithIndexedSelection',
	#classTraits : 'APTPartWithIndexedSelection classTrait',
	#instVars : [
		'itemStringRepresentationBlock',
		'itemIconRepresentationBlock'
	],
	#category : #'APart BasicParts'
}

{ #category : #'initialize-release' }
APartAbstractSequence >> initializeValues [

	self initializeSelection.
]

{ #category : #API }
APartAbstractSequence >> itemCount [

	self subclassResponsibility
]

{ #category : #accessing }
APartAbstractSequence >> itemIconRepresentationBlock [

	^itemIconRepresentationBlock
]

{ #category : #accessing }
APartAbstractSequence >> itemIconRepresentationBlock: anObject [

	itemIconRepresentationBlock := anObject
]

{ #category : #accessing }
APartAbstractSequence >> itemStringRepresentationBlock [

	^itemStringRepresentationBlock
]

{ #category : #accessing }
APartAbstractSequence >> itemStringRepresentationBlock: anObject [

	itemStringRepresentationBlock := anObject
]

{ #category : #'initialize-release' }
APartAbstractSequence >> release [

	super release.
	itemStringRepresentationBlock := itemIconRepresentationBlock := nil.
]
