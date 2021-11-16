"
APInterfaceAspectBuilder is the delegate for building Aspect objects in the PartInterface.

-- 

DE:APInterfaceAspectBuilder ist der Delegate zum Aufbau von Aspect-Objekten im PartInterface.
"
Class {
	#name : #APInterfaceAspectBuilder,
	#superclass : #Object,
	#instVars : [
		'interface'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'instance creation' }
APInterfaceAspectBuilder class >> on: aPartInterface [

	^self new initOn: aPartInterface
]

{ #category : #API }
APInterfaceAspectBuilder >> addItemsForMenuButton: enumValuePart to: aMenu [

	enumValuePart updateEnumeration.
	(self createItemsForMenuButton: enumValuePart
		tagNode: enumValuePart enumeration tagsTreeRoot)
			do: [:item | aMenu addItem: item]
]

{ #category : #API }
APInterfaceAspectBuilder >> addItemsFromEnumPart: aMenuPart to: aMenu [

	| apEnum menuItems |
	menuItems := (aMenuPart isKindOf: APMenu)
				ifTrue: [aMenuPart menuItems]
				ifFalse: 
					[aMenuPart updateEnumeration.
					apEnum := aMenuPart enumeration.
					apEnum isRecursive
						ifTrue: [self createMenuItemsForEnumeration: apEnum under: aMenuPart]
						ifFalse: [self createMenuItemsForTagNode: apEnum tagsTreeRoot use: aMenuPart]].
	menuItems do: [:item | aMenu addItem: item]
]

{ #category : #API }
APInterfaceAspectBuilder >> aspectBuildRedirectionKey [

	^nil
]

{ #category : #API }
APInterfaceAspectBuilder >> createAdaptorWithSubjectFor: anAspectKey [

	| adaptor |
	adaptor := APAspectAdaptor forAspect: anAspectKey.
	self setSubjectInAdaptor: adaptor.
	^adaptor
]

{ #category : #API }
APInterfaceAspectBuilder >> createItemsForMenuButton: menuPart tagNode: enumTagNode [

	| items item submenu  |
	items := OrderedCollection new.
	enumTagNode childrenNodes do: 
			[:tagNode |
			item := APMenuItem labeled: (menuPart enumeration textFromKeyBlock
								ifNotNil: [:block | block value: tagNode tag]
								ifNil: [tagNode tag]).
			submenu := APMenu new.
			item submenu: submenu.
			(self createMenuItemsForTagNode: tagNode use: menuPart)
				do: [:resItem | submenu addItem: resItem].
			items add: item].
	enumTagNode childrenKeys do: 
			[:k |
			item := APMenuItem labeled: (self pdmTranslateDeferred: (menuPart enumerationTextForKey: k)).
			(menuPart enumerationActionForKey: k)
				ifNotNil: [:action | item value: (self valueBlockForActionObject: action)]
				ifNil: 
					[(menuPart enumerationValueForKey: k)
						ifNotNil: [:v | item value: k]
						ifNil: [self aPartError: #wrongEnumerationValue text: 'Menu from Enumeration needs either action or value']].
			item enabled: [menuPart enumerationIsActiveAtKey: k].
			item indication: [menuPart enumerationIsIndicatedOnAtKey: k].
			item labelImage: [menuPart enumerationIconForKey: k].
			items add: item].
	^items
]

{ #category : #API }
APInterfaceAspectBuilder >> createMenuBlockForMenuButton: menuPart [

	^
	[| m |
	m := APMenu new.
	self addItemsForMenuButton: menuPart to: m.
	m]
]

{ #category : #API }
APInterfaceAspectBuilder >> createMenuBlockForPart: menuPart [

	^ [	 
		| m |
		m := APMenu new.
		self addItemsFromEnumPart: menuPart to: m.
		m ]
]

{ #category : #API }
APInterfaceAspectBuilder >> createMenuFromLabels: labelsCollection values: valuesCollection [

	^[APMenu labelArray: labelsCollection values: valuesCollection]
]

{ #category : #API }
APInterfaceAspectBuilder >> createMenuItemsForEnumeration: apEnum under: menuPart [

	| items item submenu |
	items := OrderedCollection new.
	apEnum keysAndValuesDo: 
			[:k :enumEntry |
			item := APMenuItem labeled: (apEnum textForKey: k).
			item labelImage: [apEnum iconForKey: k].
			item enabled: [apEnum isActiveAt: k].
			enumEntry isEnumeration
				ifTrue: 
					[submenu := APMenu new.
					(self createMenuItemsForEnumeration: enumEntry subEnumeration
						under: menuPart) do: [:subitem | submenu addItem: subitem].
					item submenu: submenu]
				ifFalse: 
					[(apEnum actionForKey: k)
						ifNotNil: [:action | item value: (self valueBlockForActionObject: action)]
						ifNil: 
							[item
								value: [apEnum valueForKey: k];
								actionPerformer: [menuPart value: k from: apEnum]].
					item indication: [apEnum isIndicatedOnAt: k]].
			items add: item].
	^items
]

{ #category : #API }
APInterfaceAspectBuilder >> createMenuItemsForTagNode: enumTagNode use: menuPart [

	| items item submenu |
	items := OrderedCollection new.
	enumTagNode childrenNodes do: 
			[:tagNode |
			item := APMenuItem labeled: (menuPart enumeration textFromKeyBlock
								ifNotNil: [:block | block value: tagNode tag]
								ifNil: [tagNode tag]).
			submenu := APMenu new.
			item submenu: submenu.
			(self createMenuItemsForTagNode: tagNode use: menuPart)
				do: [:resItem | submenu addItem: resItem].
			items add: item].
	enumTagNode childrenKeys do: 
			[:k |
			item := APMenuItem labeled: (menuPart enumerationTextForKey: k).
			(menuPart enumerationActionForKey: k)
				ifNotNil: [:action | item value: (self valueBlockForActionObject: action)]
				ifNil: 
					[(menuPart enumerationValueForKey: k)
						ifNotNil: 
							[:v |
							item
								value: [k];
								actionPerformer: [menuPart value: k]]
						ifNil: [self aPartError: #wrongEnumerationValue text: 'Menu from Enumeration needs either action or value']].
			item enabled: [menuPart enumerationIsActiveAtKey: k].
			item indication: [menuPart enumerationIsIndicatedOnAtKey: k].
			item labelImage: [menuPart enumerationIconForKey: k].
			items add: item].
	^items
]

{ #category : #API }
APInterfaceAspectBuilder >> createModelForAspect: aKey subject: aPart [

	^APAspect named: aKey for: (APValueAdaptor on: aPart key: aKey)
]

{ #category : #API }
APInterfaceAspectBuilder >> createModelForAspect: aKey subject: aPart redirectTo: aPartPath [

	^APRedirectedAspect named: aKey on: aPart path: aPartPath
]

{ #category : #API }
APInterfaceAspectBuilder >> createModelForAutoAspect: aKey subject: aPart [

	^APAutoAspect named: aKey for: (APValueAdaptor on: aPart key: aKey)
]

{ #category : #'initialize-release' }
APInterfaceAspectBuilder >> initOn: aPartInterface [

	interface := aPartInterface
]

{ #category : #API }
APInterfaceAspectBuilder >> part [

	^interface part
]

{ #category : #API }
APInterfaceAspectBuilder >> partKey [

	^interface part key
]

{ #category : #API }
APInterfaceAspectBuilder >> postBuildComponentKey: aGuiCompKey in: aView [
	"Default: Keine Aktion"
]

{ #category : #API }
APInterfaceAspectBuilder >> registeredClients [

	^interface registeredClients.
]

{ #category : #private }
APInterfaceAspectBuilder >> setSubjectInAdaptor: anAspectAdaptor [

	interface subjectChannelForAspects
		ifNotNil: [:ch | anAspectAdaptor subjectChannel: ch]
		ifNil: [anAspectAdaptor subject: interface subjectForAspects].
	^anAspectAdaptor
]

{ #category : #private }
APInterfaceAspectBuilder >> valueBlockForActionObject: action [

	action isSymbol ifTrue: [^[interface execute: action ifDisabled: []]].
	action class = Association
		ifTrue: 
			[^
			[interface
				execute: action key
				with: action value
				ifDisabled: []]].
	^action
]
