"
APSwitchingPart erlaubt die Umschaltung zwischen mehreren SubPart-Varianten.
The following flags could be set during initialization:
	- lazyInitialize: to control if sub parts should be instantiated when calling add:initializer:, otherwise the initialization will happen only when the relevant part key is set as a current key.
	- releaseInactivePart: to control whether an inactive part should be released or kept.
"
Class {
	#name : #APSwitchingPart,
	#superclass : #APart,
	#instVars : [
		'initializers',
		'currentPartKey',
		'lazyInitialize',
		'releaseInactivePart'
	],
	#category : #'APart BasicParts'
}

{ #category : #private }
APSwitchingPart class >> interfaceClass [

	^APSwitchingInterface
]

{ #category : #'message handling' }
APSwitchingPart >> aPartPerform: anAccessor [

	^self currentPart ifNotNil: [:part | part aPartPerform: anAccessor]
]

{ #category : #API }
APSwitchingPart >> aPartPerform: aKey with: aValue [

	^self currentPart ifNotNil: [:part | part aPartPerform: aKey with: aValue]
]

{ #category : #'initialize-release' }
APSwitchingPart >> add: aKey class: aSubPartClass postInit: aPostInitBlock [

	^self add: aKey class: aSubPartClass preInit: nil postInit: aPostInitBlock
]

{ #category : #'initialize-release' }
APSwitchingPart >> add: aKey class: aSubPartClass preInit: aPreInitBlock postInit: aPostInitBlock [

	^self add: aKey
		initializer: ((APartInitializer on: aSubPartClass)
				partKey: aKey;
				preInitBlock: aPreInitBlock;
				postInitBlock: aPostInitBlock;
				yourself)
]

{ #category : #'initialize-release' }
APSwitchingPart >> add: aKey initializer: aPartInitializer [

	initializers at: aKey put: aPartInitializer.
	lazyInitialize ifFalse: [aPartInitializer createPartOn: self]
]

{ #category : #API }
APSwitchingPart >> add: aKey part: aPart [

	^self add: aKey
		initializer: (aPart)
]

{ #category : #API }
APSwitchingPart >> currentPart [

	^currentPartKey ifNotNil: [subParts at: currentPartKey]
]

{ #category : #API }
APSwitchingPart >> currentPartKey [

	^currentPartKey
]

{ #category : #API }
APSwitchingPart >> currentPartKey: aSymbol [

	currentPartKey = aSymbol ifTrue: [^self].
	(releaseInactivePart and: [currentPartKey notNil])
		ifTrue: [(self removeSubPartForKey: currentPartKey) release]
		ifFalse: [ self switchedAwayFrom: currentPartKey ].
	currentPartKey := aSymbol.
	(currentPartKey notNil
		and: [(self subPartAt: currentPartKey ifNone: []) isNil])
			ifTrue: [(initializers at: aSymbol) createPartOn: self].
	self announcer announcer announce: ((APartSwitchedAnnouncement interface: self partInterface)
				containerId: key;
				subId: currentPartKey;
				fromInterface: self partInterface;
				yourself).
	partInterface currentPartChanged.
	self scopeRootPart rootUpdateAll.
]

{ #category : #API }
APSwitchingPart >> forceSwitchToKey: aSymbol [

	| newPart |
	currentPartKey = aSymbol ifTrue: [^self].
	(releaseInactivePart and: [currentPartKey notNil])
		ifTrue: [(self removeSubPartForKey: currentPartKey) release].
	currentPartKey := aSymbol.
	(currentPartKey notNil
		and: [(self subPartAt: currentPartKey ifNone: []) isNil])
			ifTrue: [	newPart := (initializers at: aSymbol) createPartOn: self].
	
	newPart ifNotNil: [ 
		self forceSwitchToPart: newPart ].	

"	self announcer announcer announce: ((APartSwitchedAnnouncement interface: self partInterface)
				containerId: key;
				subId: currentPartKey;
				fromInterface: self partInterface;
				yourself).
	partInterface currentPartChanged.
	self scopeRootPart rootUpdateAll."
]

{ #category : #API }
APSwitchingPart >> forceSwitchToPart: aPart [

	(releaseInactivePart and: [currentPartKey notNil])
		ifTrue: [(self removeSubPartForKey: currentPartKey) release].

	self removeSubPartForKey: currentPartKey.
	self addSubPart: aPart key: currentPartKey.

	self privSubPartsAt: currentPartKey put: aPart.
	
	self announcer announcer announce: ((APartSwitchedAnnouncement interface: self partInterface)
				containerId: key;
				subId: currentPartKey;
				fromInterface: self partInterface;
				yourself).
	partInterface currentPartChanged.
	self scopeRootPart rootUpdateAll.
]

{ #category : #API }
APSwitchingPart >> includesKey: aSymbol [

	^ initializers includesKey: aSymbol
]

{ #category : #'initialize-release' }
APSwitchingPart >> initialize [

	initializers := Dictionary new.
	lazyInitialize := true.
	releaseInactivePart := true.
	super initialize
]

{ #category : #API }
APSwitchingPart >> lazyInitialize: aBoolean [

	lazyInitialize := aBoolean
]

{ #category : #'initialize-release' }
APSwitchingPart >> prepareForRemoval: aKey [ 

	subParts ifNil: [^self].
	^(subParts at: aKey ifAbsent: [])
		ifNotNil: [:toRemove | toRemove prepareForRemoval ]
]

{ #category : #API }
APSwitchingPart >> privCurrentPartKey: aSymbol [

	currentPartKey := aSymbol.
]

{ #category : #'initialize-release' }
APSwitchingPart >> registerForUpdatesKey: aKey adaptor: anAspectAdaptor [

	self partInterface registerForUpdatesKey: aKey adaptor: anAspectAdaptor
]

{ #category : #API }
APSwitchingPart >> releaseInactivePart: aBoolean [

	releaseInactivePart := aBoolean
]

{ #category : #'initialize-release' }
APSwitchingPart >> remove: aKey [ 

	initializers removeKey: aKey.
	currentPartKey = aKey ifTrue: [ currentPartKey := nil ].
	self removeSubPartForKey: aKey.
]
