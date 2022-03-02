Class {
	#name : #ApedVisitor,
	#superclass : #Object,
	#category : #'APart Form Editor-Visitor'
}

{ #category : #visiting }
ApedVisitor >> visit: anObject [

	anObject accept: self
]

{ #category : #'visiting - layouts' }
ApedVisitor >> visitBoxLayout: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitButton: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitCheckBox: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitColorInput: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitDropList: aPart [
]

{ #category : #'visiting - layouts' }
ApedVisitor >> visitForm: aPart [
]

{ #category : #'visiting - layouts' }
ApedVisitor >> visitFrameLayout: aPart [
]

{ #category : #'visiting - layouts' }
ApedVisitor >> visitGridLayout: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitLabel: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitList: aPart [
]

{ #category : #'visiting - layouts' }
ApedVisitor >> visitNodeLayout: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitNullPart: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitNumberInput: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitProgressBar: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitRadioButton: aPart [
]

{ #category : #'visiting - layouts' }
ApedVisitor >> visitScrollLayout: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitStatusBar: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitText: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitTextInput: aPart [
]

{ #category : #'visiting - parts' }
ApedVisitor >> visitTreeTable: aPart [
]
