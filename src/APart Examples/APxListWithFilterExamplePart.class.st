"
APxListWithFilterExamplePart demonstriert:
- Aufbau einer Liste als APartList
- Hinzufügen eines Filters auf die Liste
- Definition von Filtermodulen (Reduktion, Sortieren)
- Dynamische Änderung der String-Repräsenttion der Listenelemente

"
Class {
	#name : #APxListWithFilterExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'personList',
		'isFilterEnabled',
		'isSortByFirstName',
		'filterName',
		'filterFirstName'
	],
	#category : #'APart Examples-ListWithFilter'
}

{ #category : #private }
APxListWithFilterExamplePart class >> personList [
	"self personList"

	^('Alaeddin, Mazen
Arndt, Rebecca
Bäcker, Sascha
Beckmann, Marc
Bibusch, Anke
Blübaum, Bettina
Buhmann, Katharina
Dereka, Eugen
Eberts, Christiane
Extertal, 
Freudenberg, Jenny
Frisse, Florian
Fröhlich, Ingo
Gokus, Anja
Gröne, Christian
Hallauer, Willi
Heßmann, Daniela
Himmelreich, Daniel
Hindriks, Andreas
Hochstein, Julia
Klagges, Oliver
Knoche, Wilfried
König, Anne
König, Jannis
Korel, Andrej
Kuboth, Michael
Ledig, Michael
Li, Hanfei
Linn, Phillip
Löneke-Schmidt, Antoinette
Lu, Qiang
Ludewig, Thomas
Luke, Tatjana
Meier, Karsten
Monzel, Gabi
Nillmeier, Waldemar
Oberdörffer, Jochen
Okatan, Timur
Özdemir, Coskun
Plett, Alexander
Richter, Patrick
Robeck, Markus
Sasse, Burkhard
Schemme, Rolf
Schmidt, Christian
Schmidt, Ferdinand
Schmidt, Hathumar
Schmidt, Johannes
Schmidt, Simon-Philipp
Schmidt, Yvonne
Schneider, Jörg
Schulte, Björn
Schulte, Christa
Schulz, Christian
Schwebs, Andreas
Skorek, Ralf
Stingl, Susanne
Tong, Xiangli
Vollmer, Karl-Josef
Walkosz-Zmarzly, Ewelina
Walter, Stefan
Zurawski, Patricia'
		tokensBasedOn: Character cr) asOrderedCollectionWithDependants
		collect: 
			[:eachName |
			| arr |
			arr := eachName substrings.
			(APxListExampleOurPerson basicNew)
				name: (arr first copyWithout: $,);
				firstName: arr last;
				yourself]
]

{ #category : #private }
APxListWithFilterExamplePart >> defaultPersonStringRepresentationBlock [

	^[:person | person name , ', ' , person firstName]
]

{ #category : #'initialize-release' }
APxListWithFilterExamplePart >> defineAspects [

	partInterface description 
		createAspectNamed: #isFilterEnabled;
		createAspectNamed: #personList
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> filterFirstName [

	^filterFirstName
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> filterFirstName: anObject [

	filterFirstName := anObject.
	self changedAspectValue: #filterFirstName
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> filterName [

	^filterName
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> filterName: anObject [

	filterName := anObject.
	self changedAspectValue: #filterName
]

{ #category : #'initialize-release' }
APxListWithFilterExamplePart >> initializeActions [

	partInterface description 
		createAction: #selectNext
		do: 
			[
			| currentIndex |
			(personList mayChangeSelection)
				ifTrue: 
					[currentIndex := personList selectionIndex.
					currentIndex >= personList itemCount
						ifTrue: [personList selectionIndex: 1]
						ifFalse: [personList selectionIndex: currentIndex + 1]]]
		.
	partInterface description 
		createAction: #selectPrevious
		do: 
			[
			| currentIndex |
			(personList mayChangeSelection)
				ifTrue: 
					[currentIndex := personList selectionIndex.
					currentIndex <= 1
						ifTrue: [personList selectionIndex: personList itemCount]
						ifFalse: [personList selectionIndex: currentIndex - 1]]]
]

{ #category : #'initialize-release' }
APxListWithFilterExamplePart >> initializeValues [

	super initializeValues.
	personList := APartList onPart: self key: #personList.
	personList
		list: self class personList;
		itemStringRepresentationBlock: self defaultPersonStringRepresentationBlock.
	isFilterEnabled := false.
	isSortByFirstName := false.
	#(#isSortByFirstName #filterName #filterFirstName) do: 
			[:e |
			self at: e
				putCondition: (APCondition on: [isFilterEnabled] ifNot: #FilterIsDisabled)]
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> isFilterEnabled [

	^isFilterEnabled
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> isFilterEnabled: aBoolean [

	isFilterEnabled := aBoolean.
	isFilterEnabled ifTrue: [self setupFilter] ifFalse: [self removeFilter].
	self changedAspectValue: #isFilterEnabled
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> isSortByFirstName [

	^isSortByFirstName
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> isSortByFirstName: anObject [

	isSortByFirstName := anObject.
	self updateItemRepresentationBlock.
	self changedAspectValue: #isSortByFirstName
]

{ #category : #'Exposed values' }
APxListWithFilterExamplePart >> personList [

	^personList
]

{ #category : #private }
APxListWithFilterExamplePart >> removeFilter [

	personList := personList revert.
	self updateItemRepresentationBlock
]

{ #category : #private }
APxListWithFilterExamplePart >> setupFilter [

	personList := APartFilteredList onPart: personList
				key: (personList key , #Filter) asSymbol.
	personList
		addModule: (APFilterModuleStringPattern
					on: (self modelForAspect: #filterName)
					filterBlock: [:item :p | p match: item name]);
		addModule: (APFilterModuleStringPattern
					on: (self modelForAspect: #filterFirstName)
					filterBlock: [:item :p | p match: item firstName]);
		addModule: (APFilterModuleSort
					on: (self modelForAspect: #isSortByFirstName)
					filterBlock: 
						[:a :b |
						a firstName = b firstName
							ifTrue: [a name < b name]
							ifFalse: [a firstName < b firstName]])
			notifyWith: #forceFilterChanged.
	personList adjustSelectionOn: personList parentPart.
	self updateItemRepresentationBlock
]

{ #category : #private }
APxListWithFilterExamplePart >> updateItemRepresentationBlock [

	personList
		itemStringRepresentationBlock: ((isSortByFirstName and: [isFilterEnabled])
				ifTrue: [[:person | person firstName , ' ' , person name]]
				ifFalse: [self defaultPersonStringRepresentationBlock])
]
