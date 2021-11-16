"
APxMultiSelectionListExamplePart demonstriert:
- Definition einer Liste mit Mehrfachselektion
- Reaktion auf Änderungen an der Mehrfachselektion
"
Class {
	#name : #APxMultiSelectionListExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'allNamesList',
		'selectedNamesList'
	],
	#category : #'APart Examples-MultiSelectionList'
}

{ #category : #accessing }
APxMultiSelectionListExamplePart >> allNamesList [

	^allNamesList
]

{ #category : #'initialize-release' }
APxMultiSelectionListExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #allNamesList;
		createAspectNamed: #selectedNamesList
]

{ #category : #'initialize-release' }
APxMultiSelectionListExamplePart >> initializeActions [

	partInterface description
		createAction: #deselectAll
		do: [allNamesList selectionIndexes: OrderedCollection new]
		if: (APCondition on: [allNamesList selection notNil] ifNot: #nothingSelected)
]

{ #category : #'initialize-release' }
APxMultiSelectionListExamplePart >> initializeValues [

	allNamesList := APartList
				onPart: self
				key: #allNamesList
				preInit: [:ctx | ctx isMultiSelection: true].
	allNamesList trigger: #selectionChanged
		do: [selectedNamesList list: allNamesList selections].
	#('Finn' 'Jan' 'Jannik' 'Jonas' 'Leon' 'Luca' 'Lukas' 'Niklas' 'Tim' 'Tom')
		do: [:e | allNamesList list add: e].
	selectedNamesList := APartList onPart: self key: #selectedNamesList.
	selectedNamesList
		setStatefulConditionOn: (APCondition on: [false] ifNot: #alwaysDisabled)
]

{ #category : #accessing }
APxMultiSelectionListExamplePart >> selectedNamesList [

	^selectedNamesList
]
