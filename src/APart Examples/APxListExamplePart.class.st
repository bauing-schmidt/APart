"
APxListExamplePart demonstriert:
- Verwendung eines APartList für Listendaten
- Ändern der Selektion in der Liste
- Adressieren von Elementen der Liste
- Enablement der Liste
- Ändern des Listenumfangs
- Ändern von Elementen in der Liste
"
Class {
	#name : #APxListExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'numbersList',
		'numbersListEnabled',
		'numberToAdd',
		'isDirty'
	],
	#category : #'APart Examples-ListExample'
}

{ #category : #'initialize-release' }
APxListExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #numbersListEnabled;
		createAspectNamed: #numbersList;
		createAspectNamed: #numbersDisplayList
			redirectTo: #(#numbersList #displayList);
		createAspectNamed: #numbersSelectionDisplay
			redirectTo: #(#numbersList #selectionDisplay)
]

{ #category : #'initialize-release' }
APxListExamplePart >> initializeActions [

	| checkBoxEnabledCondition |
	checkBoxEnabledCondition := APCondition on: [numbersListEnabled]
				ifNot: #CheckBoxDisabled.
	partInterface description
		createAction: #replaceList
		do: 
			[| last |
			last := numbersList list last.
			last isNumber ifFalse: [last := last asNumber].
			numbersList list: ((OrderedCollectionWithDependants new)
						add: last + 1;
						add: last + 2;
						add: last + 3;
						yourself).
			numbersList selectionIndex: 1]
		if: checkBoxEnabledCondition.
	partInterface description
		createAction: #selectNext
		do: 
			[| currentIndex |
			numbersList mayChangeSelection
				ifTrue: 
					[currentIndex := numbersList selectionIndex.
					currentIndex >= numbersList list size
						ifTrue: [numbersList selectionIndex: 1]
						ifFalse: [numbersList selectionIndex: currentIndex + 1]]]
		if: checkBoxEnabledCondition.
	partInterface description
		createAction: #selectPrevious
		do: 
			[| currentIndex |
			numbersList mayChangeSelection
				ifTrue: 
					[currentIndex := numbersList selectionIndex.
					currentIndex <= 1
						ifTrue: [numbersList selectionIndex: numbersList list size]
						ifFalse: [numbersList selectionIndex: currentIndex - 1]]]
		if: checkBoxEnabledCondition.
	partInterface description
		createAction: #addNumberToList
		do: 
			[numbersList list add: numberToAdd.
			numbersList selection: numberToAdd]
		if: checkBoxEnabledCondition value
				& (APCondition on: [(numbersList list includes: numberToAdd) not]
						ifNot: #numberAlreadyInList).
	partInterface description
		createAction: #removeSelection
		do: [self removeSelection]
		if: checkBoxEnabledCondition value
				& (APCondition on: [numbersList selection notNil] ifNot: #nothingSelected).
	partInterface description
		createAction: #renameSelection
		do: 
			[(APTextPrompt onPart: self)
				title: #Umbenennen;
				message: #EnterNewName;
				value: numbersList selection;
				trigger: #continueOk
					withPartDo: 
						[:promptPart |
						numbersList list at: numbersList selectionIndex put: promptPart value.
						isDirty := true];
				openClientPrompt]
		if: checkBoxEnabledCondition value
				& (APCondition on: [numbersList selection notNil] ifNot: #nothingSelected)
]

{ #category : #'initialize-release' }
APxListExamplePart >> initializeValues [

	numbersListEnabled := true.
	numberToAdd := -1.
	isDirty := false.
	self at: #numberToAdd
		putCondition: (APCondition on: [numbersListEnabled]
				ifNot: #numbersListDisabled).
	numbersList := APartList onPart: self key: #numbersList.
	numbersList
		setStatefulConditionOn: (APCondition on: [numbersListEnabled]
					ifNot: #numbersListDisabled);
		itemIconRepresentationBlock: [:item | self iconNamed: #add];
		trigger: #selectionChanged
			do: 
				[Transcript
					cr;
					show: numbersList selection printString;
					show: ' is selected.';
					cr.
				self rootUpdate];
		trigger: #requestSelectionChange do: [self requestSelectionChange].
	#(1 2 3) do: [:e | numbersList list add: e]
]

{ #category : #accessing }
APxListExamplePart >> numberToAdd [

	^numberToAdd
]

{ #category : #accessing }
APxListExamplePart >> numberToAdd: anObject [

	numberToAdd := anObject
]

{ #category : #accessing }
APxListExamplePart >> numbersList [

	^numbersList
]

{ #category : #accessing }
APxListExamplePart >> numbersListEnabled [

	^numbersListEnabled
]

{ #category : #accessing }
APxListExamplePart >> numbersListEnabled: anObject [

	numbersListEnabled := anObject.
	self changedAspectValue: #numbersListEnabled
]

{ #category : #'initialize-release' }
APxListExamplePart >> removeSelection [

	numbersList list remove: numbersList selection
]

{ #category : #'initialize-release' }
APxListExamplePart >> requestSelectionChange [

	| answer |
	^isDirty
		ifTrue: 
			[(APConfirmationYesNo onPart: self)
				title: #DatenVerwerfen;
				message: #FrageDatenVerwerfen;
				trigger: #confirmYes
					do: 
						[isDirty := false.
						answer := true];
				trigger: #confirmNo do: [answer := false];
				openClientPrompt.
			answer]
		ifFalse: [true]
]
