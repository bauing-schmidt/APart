"
SUTAPOperatorValueFromEnum setzt einen Enumeration-Value in einem angegebenen APConfirmationEnumValue. 

"
Class {
	#name : #SUTAPOperatorValueFromEnum,
	#superclass : #SUTAPOperator,
	#instVars : [
		'value'
	],
	#category : #'APart Tests'
}

{ #category : #'instance creation' }
SUTAPOperatorValueFromEnum class >> for: aSubPartKey value: aValue [

	^(self new)
		subPartKey: aSubPartKey;
		value: aValue;
		yourself
]

{ #category : #'instance creation' }
SUTAPOperatorValueFromEnum class >> onTrigger: triggerKey part: aPart [

	^triggerKey = #confirmChoice
		ifTrue: [self for: aPart key value: aPart value]
]

{ #category : #API }
SUTAPOperatorValueFromEnum >> operateOnPart: aPart testCase: aTestCase [

	| target |
	target := aPart subPartAt: subPartKey
				ifNone: [self error: 'Invalid subPartKey: ' , subPartKey printString].
	target value: value
]

{ #category : #API }
SUTAPOperatorValueFromEnum >> printConstructorOn: s [

	s
		nextPut: $(;
		nextPutAll: self class name;
		nextPutAll: ' for: ';
		nextPutAll: subPartKey printString;
		nextPutAll: ' value: ';
		nextPutAll: value printString;
		nextPut: $)
]

{ #category : #accessing }
SUTAPOperatorValueFromEnum >> value [

	^value
]

{ #category : #accessing }
SUTAPOperatorValueFromEnum >> value: anObject [

	value := anObject
]
