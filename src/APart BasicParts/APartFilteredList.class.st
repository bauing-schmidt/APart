"
APartListFilter wird einem APartList logisch vorgeschaltet, um gegenüber dessen PartInterface die Liste abweichend vom (unveränderten) Original zu filtern bzw. zu sortieren.
Technisch gesehen wird der Filter als SubPart des APartList aufgebaut, jedoch ohne eigenes PartInterface. Stattdessen ersetzt er das Subject der AspectAdaptor-Objekte im vorhandenen PartInterface durch sich selbst. 
Filterobjekte können dynamisch zu- und abgeschaltet werden. Beim Abschalten wird das ursprüngliche Subject im PartInterface wieder restauriert.

"
Class {
	#name : #APartFilteredList,
	#superclass : #APartList,
	#instVars : [
		'filterModules',
		'shallIgnoreChanges'
	],
	#category : #'APart BasicParts'
}

{ #category : #private }
APartFilteredList class >> interfaceClass [

	^APartListFilterInterface
]

{ #category : #'initialize-release' }
APartFilteredList >> addModule: aFilterModule [

	self addModule: aFilterModule notifyWith: #filterChanged
]

{ #category : #'initialize-release' }
APartFilteredList >> addModule: aFilterModule notifyWith: aSelector [

	filterModules add: aFilterModule.
	aFilterModule notify: self onChangeBy: aSelector.
	self perform: aSelector
]

{ #category : #'initialize-release' }
APartFilteredList >> addModules: someFilterModules [

	filterModules addAll: someFilterModules.
	self filterChanged
]

{ #category : #changing }
APartFilteredList >> filterChanged [

	self filterChangedForceUpdate: false
]

{ #category : #changing }
APartFilteredList >> filterChangedForceUpdate: isForcedChange [

	| oldSelections newList |
	shallIgnoreChanges ifTrue: [^self].
	oldSelections := self selections.
	newList := self originalList copy.
	filterModules
		do: [:filterModule | newList := filterModule applyFilterTo: newList].
	isForcedChange
		ifFalse: [(self hasNoDifferencesIn: newList) ifTrue: [^self]].
	list := newList.
	self
		ignoreChangesWhile: [partInterface changedAspectValue: #listHolder].
	(oldSelections isEmpty and: [self selectionIndexes isEmpty])
		ifTrue: 
			["Just a simple optimization to avoid unnecessary calls and to support behavioral analysis.
A redundant changed: #value would not be triggered even without the optimization.
			DE:Nur eine einfache Optimierung zur Vermeidung unnötiger Aufrufe sowie zur Unterstützung der Analyse des Verhaltens.
			Eine redundantes changed: #value würde auch ohne die Optimierung nicht angestoßen."
			^self].
	self selections: oldSelections
]

{ #category : #changing }
APartFilteredList >> forceFilterChanged [

	self filterChangedForceUpdate: true
]

{ #category : #private }
APartFilteredList >> hasNoDifferencesIn: newList [

	list size = newList size ifFalse: [^false].
	newList with: list do: [:new :old | new == old ifFalse: [^false]].
	^true
]

{ #category : #private }
APartFilteredList >> ignoreChangesWhile: aBlock [

	shallIgnoreChanges := true.
	aBlock ensure: [shallIgnoreChanges := false]
]

{ #category : #'initialize-release' }
APartFilteredList >> initialize [

	shallIgnoreChanges := false.
	itemStringRepresentationBlock := parentPart
				itemStringRepresentationBlock.
	super initialize.
	filterModules := OrderedCollection new
]

{ #category : #API }
APartFilteredList >> listKey [

	^parentPart key
]

{ #category : #private }
APartFilteredList >> originalList [

	^parentPart list
]

{ #category : #'initialize-release' }
APartFilteredList >> removeModule: aFilterModule [

	filterModules remove: aFilterModule close.
	self filterChanged
]

{ #category : #'initialize-release' }
APartFilteredList >> revert [

	filterModules do: [:filterModule | filterModule close].
	parentPart
		removeSubPartForKey: key;
		adjustSelectionOn: self.
	^parentPart
]

{ #category : #accessing }
APartFilteredList >> selectionIndex: newIndex [

	(newIndex = 0 and: [shallIgnoreChanges]) ifTrue: [^self].
	super selectionIndex: newIndex
]
