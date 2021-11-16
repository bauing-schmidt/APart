Class {
	#name : #APxSimpleListExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'numberList'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #'initialize-release' }
APxSimpleListExamplePart >> defineAspects [

	partInterface description
		createAspectNamed: #numberList
]

{ #category : #'initialize-release' }
APxSimpleListExamplePart >> initializeActions [

	partInterface description
		createAction: #actionButton
		do: [ numberList list add: numberList list last + 1 ]
		if: (APCondition true).
		
	partInterface description
		createAction: #modifyButton
		do: [ numberList list removeLast ]
		if: (APCondition true).
		
	partInterface
		createAction: #action
		do: [
			numberList list remove: numberList selection
			"
			| last |
			last := numberList list last.
			last isNumber ifFalse: [last := last asNumber].
			numberList list: ((List new)
						add: last + 1;
						add: last + 2;
						add: last + 3;
						yourself).
			numberList selectionIndex: 1"
			"| currentIndex |
			numberList mayChangeSelection
				ifTrue: [
					currentIndex := numberList selectionIndex.
					currentIndex >= numberList list size
						ifTrue: [numberList selectionIndex: 1]
						ifFalse: [numberList selectionIndex: currentIndex + 1]]"]
		if: (APCondition true).
]

{ #category : #'initialize-release' }
APxSimpleListExamplePart >> initializeValues [

	super initializeValues.
	numberList := APartList onPart: self key: #numberList.
	numberList addAll: #(1 2 3).
]
