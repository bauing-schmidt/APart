"
SUTAPOperatorSelectionChange führt einen Selektionswechsel in einem angegebenen SubPart durch. 
"
Class {
	#name : #SUTAPOperatorSelectionChange,
	#superclass : #SUTAPOperator,
	#instVars : [
		'selectionIndexes'
	],
	#category : #'APart Tests'
}

{ #category : #'instance creation' }
SUTAPOperatorSelectionChange class >> for: aSubPartKey index: aSelectionIndex [

	^self for: aSubPartKey indexes: (Array with: aSelectionIndex)
]

{ #category : #'instance creation' }
SUTAPOperatorSelectionChange class >> for: aSubPartKey indexes: selectionIndexColl [

	^(self new)
		subPartKey: aSubPartKey;
		selectionIndexes: selectionIndexColl;
		yourself
]

{ #category : #'instance creation' }
SUTAPOperatorSelectionChange class >> onTrigger: triggerKey part: aPart [

	^triggerKey = #selectionChanged
		ifTrue: [self for: aPart key indexes: aPart selectionIndexes]
]

{ #category : #API }
SUTAPOperatorSelectionChange >> operateOnPart: aPart testCase: aTestCase [

	| target s |
	target := aPart subPartAt: subPartKey
				ifNone: [self error: 'Invalid subPartKey: ' , subPartKey printString].
	target mayChangeSelection
		ifFalse: 
			[aTestCase logStep: 'Operator: selection change denied.'.
			^self].
	target selectionIndexes: selectionIndexes.
	s := WriteStream on: String new.
	self printSelectionIndexesOn: s.
	aTestCase logStep: 'Operator: selection change to ' , s contents
]

{ #category : #API }
SUTAPOperatorSelectionChange >> printConstructorOn: s [

	s
		nextPut: $(;
		nextPutAll: self class name;
		nextPutAll: ' for: ';
		nextPutAll: subPartKey printString.
	self printSelectionIndexesOn: s.
	s nextPut: $)
]

{ #category : #API }
SUTAPOperatorSelectionChange >> printSelectionIndexesOn: s [

	selectionIndexes size = 1
		ifTrue: 
			[s
				nextPutAll: ' index: ';
				nextPutAll: selectionIndexes any printString]
		ifFalse: 
			[s nextPutAll: ' indexes: #('.
			selectionIndexes do: [:si | s nextPutAll: si printString]
				separatedBy: [s space].
			s nextPut: $)]
]

{ #category : #accessing }
SUTAPOperatorSelectionChange >> selectionIndexes [

	^selectionIndexes
]

{ #category : #accessing }
SUTAPOperatorSelectionChange >> selectionIndexes: anObject [

	selectionIndexes := anObject
]
