"
APxAllExamplesPart ist ein Utility zum Starten aller Beispiele. Es sammelt alle Subklassen von APartViewExample und leitet daraus die passenden Root-Part-Klassen ab. Diese Klassen werden in einer Liste angeboten und können als eigenständige Beispiele geöffnet werden. Zu jedem Beispiel ist der Klassenkommentar zu sehen.

Diese Klasse demonstriert außerdem:
- Wiederverwendung von APCondition-Ausdrücken (siehe #initializeActions)
"
Class {
	#name : #APxAllExamplesPart,
	#superclass : #APartExample,
	#instVars : [
		'openedParts',
		'exampleClasses',
		'viewsByPart'
	],
	#category : #'APart Examples-All'
}

{ #category : #'Exposed values' }
APxAllExamplesPart >> exampleClasses [

	^exampleClasses
]

{ #category : #'initialize-release' }
APxAllExamplesPart >> initializeActions [
	| hasSelection isExampleOpen browserClass canBrowse |
	hasSelection := APCondition
		on: [ exampleClasses selection notNil ]
		ifNot: #NoExampleSelected.
	isExampleOpen := APCondition
		on: [ self openedPartForSelection notNil ]
		ifNot: #ExampleAlreadyOpen.
	browserClass := nil.
	canBrowse := (APCondition on: [ browserClass notNil ] ifNot: #MissingBrowserClass).
	partInterface description
		createAction: #openExample
			do: [ self openExample ]
			if: hasSelection & (isExampleOpen invertedIfNot: #ExampleAlreadyOpen);
		createAction: #closeExample
			do: [ self openedPartForSelection partInterface requestForPartClose ]
			if: hasSelection & isExampleOpen;
		createAction: #focusExample
			do: [ self openedPartForSelection announcer announceFocusRequest ]
			if: hasSelection & isExampleOpen;
		createAction: #inspectPart
			do: [ self openedPartForSelection inspectPart ]
			if: hasSelection & isExampleOpen;
		createAction: #inspectView
			do: [ self openedPartForSelection clientRegistry
				clientsForInterface: self openedPartForSelection partInterface
				ifPresent: [ :clients | clients any ownerDo: [ :o | o inspect ] ]
				ifAbsent: [  ] ]
			if: hasSelection & isExampleOpen;
		createAction: #browsePartClass
			do: [ browserClass newOnClass: exampleClasses selection ]
			if: hasSelection & canBrowse;
		createAction: #browseViewClass
			do:
				[ browserClass newOnClass: (viewsByPart at: exampleClasses selection) ]
			if: hasSelection & canBrowse.
	self
		trigger: #requestForClose
		do: [ openedParts values
				do: [ :openedPart | openedPart partInterface requestForPartClose ].
			openedParts isEmpty ]
]

{ #category : #'initialize-release' }
APxAllExamplesPart >> initializeValues [

	| allPartClasses |
	openedParts := IdentityDictionary new.
	allPartClasses := SortedCollection sortBlock: [:a :b | a name <= b name].
	viewsByPart := IdentityDictionary new.
	APartExampleGUI allSubclasses do: 
			[:viewClass |
			viewClass matchingPartClass
				ifNotNil: 
					[:partClass |
					(partClass ~~ self class 
							and: [partClass category = 'APart Examples' 
								and: [partClass canStartStandalone]])
						ifTrue: 
							[allPartClasses add: partClass.
							viewsByPart at: partClass put: viewClass]]].
	exampleClasses := APartList onPart: self key: #exampleClasses.
	exampleClasses
		exposeListAspect;
		list: allPartClasses asOrderedCollectionWithDependants;
		itemStringRepresentationBlock: 
				[:partClass |
				| tabString |
				tabString := String with: Character tab.
				(openedParts includesKey: partClass)
					ifTrue: [' *' , tabString , partClass name]
					ifFalse: [tabString , partClass name]];
		trigger: #selectionChanged do: [];
		trigger: #doubleClick
			do: 
				[self openedPartForSelection
					ifNotNil: [:part | part announcer announceFocusRequest]
					ifNil: [self openExample]]
]

{ #category : #announcements }
APxAllExamplesPart >> interfaceClosing: anAnnouncement [

	openedParts removeKey: anAnnouncement interface part class ifAbsent: [].
	self rootUpdate
]

{ #category : #actions }
APxAllExamplesPart >> openExample [

	| examplePart |
	examplePart := exampleClasses selection createWithClientRegistry.
	openedParts at: examplePart class put: examplePart.
	examplePart partInterface announcer when: APInterfaceClosingAnnouncement send: #interfaceClosing: to: self.
	examplePart openClient
]

{ #category : #private }
APxAllExamplesPart >> openedPartForSelection [

	^exampleClasses selection
		ifNotNil: [:partClass | openedParts at: partClass ifAbsent: []]
]
