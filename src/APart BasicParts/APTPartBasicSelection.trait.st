"
Use me for basic selection behaviour, as checking for selection change permitted
"
Trait {
	#name : #APTPartBasicSelection,
	#instVars : [
		'holdSelectionChangedTrigger'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APTPartBasicSelection >> holdSelectionChangedTrigger [
 
	^ holdSelectionChangedTrigger ifNil: [ false ]
]

{ #category : #accessing }
APTPartBasicSelection >> holdSelectionChangedTriggerWhile: aBlock [

	holdSelectionChangedTrigger := true.
	aBlock ensure: [holdSelectionChangedTrigger := false]
]

{ #category : #accessing }
APTPartBasicSelection >> mayChangeSelection [

	^self partInterface executeTrigger: #requestSelectionChange ifAbsent: [true]
]
