"
APFilterModuleSort sortiert die übergebene Liste auf Basis des filterBlocks (üblicher sortBlock mit 2 Parametern). Im model wird ein boolscher Wert erwartet (Filter an/aus).

"
Class {
	#name : #APFilterModuleSort,
	#superclass : #APGenericFilterModule,
	#category : #'APart BasicParts'
}

{ #category : #API }
APFilterModuleSort >> applyFilterTo: aList [

	| result |
	model value ifFalse: [^aList].
	result := SortedCollection withAll: aList sortBlock: filterBlock.
	^result asOrderedCollection
]
