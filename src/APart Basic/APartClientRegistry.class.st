"
APartClientRegistry hält folgende Informationen:
- alle ihm zugeordneten Part-Objekte, damit logische Modalität implementiert werden kann;
- alle zu den jeweiligen PartInterfaces geöffneten Clients;
- alle möglichen Matches von Client-Klassen zu Part-Objekten
- verfügbare PartRibbonConfigurations

Unter Client werden hier auch alle GUI-Klassen subsumiert, sofern sie sich als passend zu einer bestimmten Part-Klasse definieren (#matchingPartClass / #matchingPartClasses).
Die Implementationen von #guiBaseClasses in APartClientRegistry zeigen im Detail, auf welchem Wege GUI-Klassen gefunden werden können. Folgende Wege sind möglich:
- Per expliziter Zuordnung auf Klassenseite mittels #addGUIBaseClass:. Diese Zuordnung gilt ab dann für alle Instanzen von APartClientRegistry.
- Per expliziter Zuordnung auf Instanzseite mittels #addGUIBaseClass:. Diese Zuordnung gilt nur für die konkrete Instanz von APartClientRegistry.
- Per Pragmadefinition (siehe #registerGUIClassesByPragma). Diese Definition wird einmalig evaluiert und auf Klassenseite von APartClientRegistry zugeordnet.

Die Definition per Pragma wird als der Normalfall betrachtet und im Fall fehlender sonstiger Definitionen automatisch ausgeführt.

Falls eine Instanz von APartClientRegistry keine klassenseitigen Definitionen verwenden soll, ist #keepInstanceDefinitionsOnly aufzurufen.
"
Class {
	#name : #APartClientRegistry,
	#superclass : #Object,
	#instVars : [
		'guiBaseClasses',
		'rootPart',
		'interfaceClients',
		'clientClassRegistry',
		'ribbonConfigurations',
		'ribbonConfigurationsById'
	],
	#classInstVars : [
		'GUIBaseClasses',
		'warnedClassNames'
	],
	#category : #'APart Basic-Core'
}

{ #category : #API }
APartClientRegistry class >> addGUIBaseClass: aBaseClass [

	self guiBaseClasses add: aBaseClass
]

{ #category : #API }
APartClientRegistry class >> addWarnedClassName: aRegisteredClass [

	(warnedClassNames includes: aRegisteredClass) ifTrue: [^false].
	warnedClassNames add: aRegisteredClass.
	^true
]

{ #category : #API }
APartClientRegistry class >> guiBaseClasses [

	GUIBaseClasses isNil ifTrue: [self initializeGUIBaseClasses].
	^GUIBaseClasses
]

{ #category : #API }
APartClientRegistry class >> initializeGUIBaseClasses [
	"self initializeGUIBaseClasses"

	GUIBaseClasses := IdentitySet new.
	warnedClassNames := IdentitySet new.
]

{ #category : #'instance creation' }
APartClientRegistry class >> on: aRootPart [

	^self new initOn: aRootPart
]

{ #category : #API }
APartClientRegistry class >> registerGUIClassesByPragma [
	"self registerGUIClassesByPragma"

	self initializeGUIBaseClasses.
	(Pragma allNamed: #aPartGUIBaseClass under: Object class)
		do: [:p | self addGUIBaseClass: p methodClass soleInstance]
]

{ #category : #API }
APartClientRegistry >> addGUIBaseClass: aBaseClass [

	guiBaseClasses add: aBaseClass
]

{ #category : #API }
APartClientRegistry >> clientClassRegistry [

	clientClassRegistry isNil ifTrue: [self refreshClientClassRegistry].
	^clientClassRegistry
]

{ #category : #API }
APartClientRegistry >> clientTypesForInterface: aPartInterface [

	| result |
	result := Set new.
	self 
		clientsForInterface: aPartInterface
		ifPresent: [ :setOfClients | 
			(setOfClients collect: [:client | client class ])
				do: [ :clientClass | result addAll: clientClass clientTypes]] 
		ifAbsent: [].
	^result
]

{ #category : #API }
APartClientRegistry >> clientsForInterface: anInterface ifPresent: aPresentBlock ifAbsent: anAbsentBlock [

	interfaceClients at: anInterface
		ifPresent: [:matches | ^aPresentBlock value: matches].
	^anAbsentBlock value
]

{ #category : #API }
APartClientRegistry >> defaultPromptExecutor [

	^APPromptExecutor defaultForClientType: #GUI
]

{ #category : #private }
APartClientRegistry >> dictionaryOnClientClassFromPart: aPart [

	| clientClass resultDict |
	clientClass := aPart findClientClassForOpening.
	resultDict := Dictionary new.
	clientClass clientTypes do: [:ct | resultDict at: ct put: clientClass].
	^resultDict
]

{ #category : #API }
APartClientRegistry >> endExclusivePart: promptingPart [
	"See #startExclusivePart:"
]

{ #category : #API }
APartClientRegistry >> findAnyClientForInterface: aPartInterface [
	"nil if nothing has been found. Mind that #findClientsForInterface: never answers an empty set."

	^( self findClientsForInterface: aPartInterface)
		ifNotNil: [:setOfClients | setOfClients anyOne]

]

{ #category : #API }
APartClientRegistry >> findClientClassesForPart: aPart [

	^(self findClientClassesWithTypesForPart: aPart) values
]

{ #category : #API }
APartClientRegistry >> findClientClassesWithTypesForPart: aPart [
	"If multiple clients of different types are active for the part, a matching class is returned for each type.
	If more than one client is available per type, the part must resolve the callback. "

	| matchesByType activeClientTypes classesByType resultDict |
	activeClientTypes := self clientTypesForInterface: aPart partInterface.
	matchesByType := self clientClassRegistry at: aPart class name ifAbsent: [
   		"Support for newly added classes in developer mode"
		self refreshClientClassRegistry.
		self clientClassRegistry at: aPart class name ifAbsent: [
			"If we end up here, a client class for opening aPart could not be found generically.
			Hopefully the part itself can provide something, see the following call"
			^self dictionaryOnClientClassFromPart: aPart
		]
	].
	classesByType := Dictionary new.
	activeClientTypes do: [:ct |
		matchesByType at: ct ifPresent: [:clientClass |
			(classesByType at: ct ifAbsentPut: [OrderedCollection new])
				add: clientClass.
		]
	].
	matchesByType isEmpty
		ifTrue: [^self dictionaryOnClientClassFromPart: aPart].
	resultDict := Dictionary new.
	matchesByType keysAndValuesDo: [:clientType :possibleClasses |
		resultDict at: clientType put: (
			possibleClasses size = 1
				ifTrue: [possibleClasses any]
				ifFalse: 	[aPart chooseClientClassForOpeningType: clientType among: possibleClasses]
		)
	].
	^resultDict
]

{ #category : #API }
APartClientRegistry >> findClientsForInterface: aPartInterface [
	"nil if nothing has been found"

	^ self clientsForInterface: aPartInterface
			ifPresent: [ :setOfClients | setOfClients notEmpty ifTrue: [ setOfClients]]
			ifAbsent: []

]

{ #category : #API }
APartClientRegistry >> guiBaseClasses [

	guiBaseClasses isEmpty
		ifTrue: 
			[self class guiBaseClasses isEmpty
				ifTrue: [self class registerGUIClassesByPragma].
			self class guiBaseClasses do: [:bc | self addGUIBaseClass: bc]].
	^guiBaseClasses
]

{ #category : #'initialize-release' }
APartClientRegistry >> initOn: aRootPart [

	rootPart := aRootPart.
	guiBaseClasses := IdentitySet new.
	interfaceClients := Dictionary new.
	clientClassRegistry := Dictionary new.
	ribbonConfigurations := OrderedCollection new.
	ribbonConfigurationsById := Dictionary new.
]

{ #category : #testing }
APartClientRegistry >> isClientRegistered: aClient forInterface: anInterface [

	^(interfaceClients at: anInterface ifAbsentPut: [IdentitySet new])
		includes: aClient
]

{ #category : #private }
APartClientRegistry >> logWarningIfDuplicateRegistrationOfPartClass: partClass clientClass: clientClass inDictionary: clientRegDict [
	| dictToLog |
	
	(self class addWarnedClassName: partClass name)
		ifFalse: [ ^ false].
	
	dictToLog := ((clientRegDict at: #GUI) copy)
		add: clientClass;
		yourself.
	'Warning: Duplicate client registration for ' trace.
	partClass trace.
	': ' trace. 
	dictToLog traceCr.
	^ true 
]

{ #category : #API }
APartClientRegistry >> openClientsForPart: aPart [
	"If several clients of different types are active for the part, a #openOnPart: is called for each one.
If several clients are available per type, the part has to decide via callback (see #findClientClassesForPart :). "
	"DE:Falls für den Part mehrere Clients unterschiedlicher Typen aktiv sind, wird für jeden ein #openOnPart: aufgerufen.
	Falls pro Typ mehrere Clients verfügbar sind, muss der Part per callback entscheiden (siehe #findClientClassesForPart:)."

	| clientClasses |
	clientClasses := self findClientClassesForPart: aPart.
	^ clientClasses collect: [:clientClass | clientClass openOnPart: aPart]
]

{ #category : #private }
APartClientRegistry >> refreshClientClassRegistry [
	"Refresh instance variables of the registry that 
	Top level: key = part class, value: Dictionary with key clientType, value client class or GUI class.
	Typically, clients themselves have no matchingPartClasses. This assignment is built later, because each GUI class knows its client class and instantiates it when opened.
	clientClassRegistry thus also contains all GUI classes that have at least one #matchingPartClass. Both client class and GUI class must implement the #openOnPart: protocol.
	However, a GUIClient may fail on #openOnPart because it itself cannot instantiate a GUI object."


	| allClasses |
	clientClassRegistry := Dictionary new.
	guiBaseClasses := IdentitySet new.
	allClasses := APartAbstractClient allSubclasses.
	self guiBaseClasses do: [:gbc | allClasses addAll: gbc allSubclasses].
	allClasses do: [ :clientClass |
		clientClass matchingPartClasses do: [ :partClass | | subDict |
			subDict := clientClassRegistry at: partClass name
				ifPresent: [ :aDict |
					self logWarningIfDuplicateRegistrationOfPartClass: partClass clientClass: clientClass inDictionary: aDict.
					aDict]
				ifAbsent: [ clientClassRegistry at: partClass name put: Dictionary new].
			clientClass clientTypes do: [ :ct | 
				(subDict at: ct ifAbsentPut: [OrderedCollection new]) add: clientClass
			]
		]
	]
]

{ #category : #API }
APartClientRegistry >> registerClient: aClient forInterface: anInterface [

	(interfaceClients at: anInterface ifAbsentPut: [IdentitySet new]) add: aClient.
	
	anInterface clientRegistered: aClient
]

{ #category : #'initialize-release' }
APartClientRegistry >> release [

	rootPart := nil.
	guiBaseClasses := nil.
	interfaceClients := nil.
	clientClassRegistry := nil
]

{ #category : #API }
APartClientRegistry >> removeClientsFor: anInterface [

	^interfaceClients removeKey: anInterface ifAbsent: []
]

{ #category : #API }
APartClientRegistry >> resetClients [

	interfaceClients copy
		keysAndValuesDo: [:interface :clients | clients do: [:client | interface unregisterClient: client]].
	interfaceClients wipe
]

{ #category : #API }
APartClientRegistry >> rootPart [

	^rootPart
]

{ #category : #API }
APartClientRegistry >> startExclusivePart: promptingPart [
	"Wenn der übergebene Part von sich aus als Prompt agieren kann, dann ist nichts zu tun.
	Andernfalls muss Modalität durch temporäres Deaktivieren der ParentParts emuliert werden."

	promptingPart isPromptable ifTrue: [^self].
	self error: 'Non-modal prompting not yet implemented'
]

{ #category : #API }
APartClientRegistry >> unRegisterClient: aClient forInterface: anInterface [

	(interfaceClients at: anInterface
		ifAbsentPut: [self error: 'Interface not registered!']) remove: aClient.
	(interfaceClients at: anInterface) isEmpty
		ifTrue: [interfaceClients removeKey: anInterface]
]
