Class {
	#name : #APxSimpleComboExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'numbersList',
		'numbersListEnabled',
		'numberToAdd',
		'isDirty'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> defineAspects [

	partInterface description
		createAspectNamed: #numbersListEnabled;
		createAspectNamed: #numbersList;
		createAspectNamed: #numbersDisplayList
			redirectTo: #(#numbersList #displayList);
		createAspectNamed: #numbersSelectionDisplay
			redirectTo: #(#numbersList #selectionDisplay)
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> initializeActions [

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
	partInterface
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
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> initializeValues [

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
		itemIconRepresentationBlock: [:item | "DM16x16Icons brick_add"];
		trigger: #selectionChanged
			do: 
				[Transcript
					cr;
					show: numbersList selection printString;
					show: ' is selected.';
					cr.
				self rootUpdate].
			
	#(1 2 3) do: [:e | numbersList list add: e]
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> numberToAdd [

	^numberToAdd
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> numberToAdd: anObject [

	numberToAdd := anObject
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> numbersList [

	^numbersList
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> numbersListEnabled [

	^numbersListEnabled
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> numbersListEnabled: anObject [

	numbersListEnabled := anObject.
	self changedAspectValue: #numbersListEnabled
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> removeSelection [

	numbersList list remove: numbersList selection.
		numbersList selectionIndex: 0.
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> requestSelectionChange [

	| answer |
	(APConfirmationYesNo onPart: self)
		title: #RequestSelectionChange;
		message: #ShallChangeSelection, '?';
		trigger: #confirmYes do: [answer := true];
		trigger: #confirmNo do: [answer := false];
		openClientPrompt.
	^answer
]

{ #category : #'initialize-release' }
APxSimpleComboExamplePart >> resolverModeEnumeration [

	| enum |
	enum := APEnumeration named: #resolverMode.
	enum textFromKeyBlock: [:k | self aPartTranslateDynamic: (k prefixCamelCased: #lb)].
	enum actionFromKeyBlock: [:k | k].
	enum
		addEntry: (APEnumEntry on: enum key: #key1);
		addEntry: (APEnumEntry on: enum key: #key2);
		addEntry: (APEnumEntry on: enum key: #key3);
		addEntry: (APEnumEntry on: enum key: #key4);
		addEntry: (APEnumEntry on: enum key: #key5);
		addEntry: (APEnumEntry on: enum key: #key6);
		yourself.
	^enum
]
