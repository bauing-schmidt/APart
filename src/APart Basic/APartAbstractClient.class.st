"
APartAbstractClient is the base class for all types of clients that work with APart objects.

--

APartAbstractClient ist die Basisklasse für alle Arten von Clients, die mit APart-Objekten zusammenarbeiten. Obwohl die Klasse von ApplicationModel erbt (da Mehrfachvererbung nicht möglich ist), ist auch ein Zweig für headless-Clients vorgesehen.
"
Class {
	#name : #APartAbstractClient,
	#superclass : #Model,
	#instVars : [
		'clientConfiguration',
		'promptExecutor',
		'partInterface',
		'subAppConfiguration',
		'notificationHandlers'
	],
	#category : #'APart Basic-Clients'
}

{ #category : #API }
APartAbstractClient class >> clientTypes [

	self subclassResponsibility
]

{ #category : #API }
APartAbstractClient class >> matchingPartClass [
	"Can be redefined directly"
	"DE:Kann direkt überdefiniert werden"

	^nil
]

{ #category : #API }
APartAbstractClient class >> matchingPartClasses [
	"If a subclass supports multiple part classes, it must redefine this method. If it supports exactly one, it is expected in #matchingPartClass."
	"DE:Falls eine Subklasse mehrere Part-Klassen unterstützt, muss sie diese Methode überdefinieren. Falls sie genau eine unterstützt, wird diese in #matchingPartClass erwartet."

	^self matchingPartClass ifNotNil: [:class | Array with: class] ifNil: [#()]
]

{ #category : #'instance creation' }
APartAbstractClient class >> on: aPartInterface [
	"basicNew, so that #initialize is called only after setting the interface"
	"DE:basicNew, damit #initialize erst nach Setzen des Interface aufgerufen wird"

	^self basicNew initOn: aPartInterface
]

{ #category : #'interface opening' }
APartAbstractClient class >> openModalOnPart: aPromptPart parentClient: aParentClient [

	| client |
	client := self basicNew.
	client initOn: aPromptPart partInterface.
	client openModalUnder: aParentClient
]

{ #category : #'interface opening' }
APartAbstractClient class >> openOnPart: aPart [

	self subclassResponsibility
]

{ #category : #'interface opening' }
APartAbstractClient class >> usedPragmas [
	<pragmas: #class>

	^#(#aPartGUIBaseClass)
]

{ #category : #'VisualWorks metadata' }
APartAbstractClient class >> visualWorksMetadata [

	^ #(
		'superclassNamespace' 'UI'
	)

]

{ #category : #binding }
APartAbstractClient >> actionFor: aKey ifAbsent: absentBlock [

	^partInterface actionAdaptorFor: aKey client: self ifAbsent: absentBlock
]

{ #category : #announcements }
APartAbstractClient >> announcedStatesSpecialKeys [
	"Here are those keys to return, which are not subject to the standard treatment"
	"DE:Hier sind diejenigen Keys zurückzugeben, die nicht der Standardbehandlung unterliegen sollen"

	^Set new
]

{ #category : #binding }
APartAbstractClient >> aspectFor: aKey ifAbsent: absentBlock [

	^partInterface
		ifNil: [absentBlock value]
		ifNotNil: [partInterface description aspectFor: aKey ifAbsent: absentBlock]
]

{ #category : #notification }
APartAbstractClient >> changeInterfaceFrom: currentInterface to: newInterface [

	currentInterface == partInterface ifFalse: [^self].
	partInterface := newInterface
]

{ #category : #API }
APartAbstractClient >> clientConfiguration [

	^clientConfiguration
]

{ #category : #API }
APartAbstractClient >> clientConfiguration: anObject [

	anObject = clientConfiguration ifTrue: [^self].
	self configurationChangingTo: anObject.
	clientConfiguration := anObject
]

{ #category : #'interface closing' }
APartAbstractClient >> close [
]

{ #category : #API }
APartAbstractClient >> closeActiveSubApp [
	"Usually nothing to do"
	"DE:Normalerweise nichts zu tun"
	
]

{ #category : #private }
APartAbstractClient >> configurationChangingTo: newConfiguration [
	"Specific clients can react to the change here. If necessary, the new value can already be adopted here in the instance variable."
	"DE:Spezifische Clients können hier auf die Änderung reagieren. Falls erforderlich, kann der neue Wert bereits hier in die Instanzvariable übernommen werden."
]

{ #category : #private }
APartAbstractClient >> createPromptExecutor [

	self subclassResponsibility
]

{ #category : #API }
APartAbstractClient >> executeActionFor: aKey [
	"In this way, no result of an execution can be transmitted"
	"DE:Auf diesem Weg kann kein Ergebnis einer Ausführung übermittelt werden"

	(self actionFor: aKey
		ifAbsent: [ APMissingActionError signalKey: aKey])
			value: true
]

{ #category : #API }
APartAbstractClient >> executeActionFor: aKey ifDisabled: disabledBlock [

	^self executeActionFor: aKey with: nil ifDisabled: disabledBlock
]

{ #category : #API }
APartAbstractClient >> executeActionFor: aKey with: anArgument ifDisabled: disabledBlock [

	^partInterface
		execute: aKey
		with: anArgument
		ifDisabled: disabledBlock
		ifAbsent: [ APMissingActionError signalKey: aKey ]
]

{ #category : #announcements }
APartAbstractClient >> handleDefaultAnnouncedState: anAnnouncedState [

	self subclassResponsibility
]

{ #category : #announcements }
APartAbstractClient >> handleSpecialAnnouncedStates: specialAnnouncedStatesOrNil [
	"Can also be used as a hook for post-processing the ordinary AnnouncedStates.
	nil as an argument means that there are no special states.
	An empty dictionary means there were no changes to the special states."
	"DE:Kann auch als Hook für Nachbearbeitungen der gewöhnlichen AnnouncedStates verwendet werden.
	nil als Argument bedeutet, dass es keine special states gibt.
	Ein leeres Dictionary bedeutet, dass es keine Änderungen an den special states gab."
]

{ #category : #'initialize-release' }
APartAbstractClient >> initOn: aPartInterface [

	partInterface := aPartInterface.
	self updateConfigurationsFromPart.
	self initialize
]

{ #category : #announcements }
APartAbstractClient >> interfaceChanged: anAnnouncement [

	self interfaceChanged: anAnnouncement from: anAnnouncement interface
]

{ #category : #announcements }
APartAbstractClient >> interfaceChanged: anAnnouncement from: anAnnouncer [

	| hasNoMatch specialKeys specialStates anInterface |
	
	anInterface := anAnnouncement interface.

	self isDisconnected ifTrue: [^self].
	hasNoMatch := true.
	anInterface == partInterface
		ifTrue: 
			[hasNoMatch := false.
			specialKeys := self announcedStatesSpecialKeys asSet.
			specialStates := specialKeys notEmpty ifTrue: [Dictionary new].
			anAnnouncement announcedStates do: 
					[:as |
					(specialStates notNil and: [specialKeys includes: as key])
						ifTrue: [specialStates at: as key put: as]
						ifFalse: 
							[subAppConfiguration notNil
								ifTrue: [subAppConfiguration handleAnnouncedState: as].
							self handleDefaultAnnouncedState: as]].
			self handleSpecialAnnouncedStates: specialStates].
	self subClients do: 
			[:subClient |
			subClient partInterface == anInterface
				ifTrue: 
					[hasNoMatch := false.
					subClient interfaceChanged: anAnnouncement from: anInterface]].
	hasNoMatch
		ifTrue: [self interfaceChanged: anAnnouncement fromSubInterface: anInterface]
]

{ #category : #announcements }
APartAbstractClient >> interfaceChanged: anAnnouncement fromSubInterface: anAnnouncer [
	"This connection is reached when an announcement arrives for which no explicitly built sub-client was found. This is e.g. then the case when the top GUI contains widgets pointing directly to aspects of sub-parts, typically in a ribbon UI. A GUI client can handle this situation accordingly."
	"DE:Dieser Anschluss wird erreicht, wenn ein Announcement eintrifft, für das kein explizit aufgebauter Sub-Client gefunden wurde. Das ist z.B. dann der Fall, wenn das Top-GUI Widgets enthält, die direkt auf Aspekte von Sub-Parts zeigen, typischerweise in einem Ribbon-UI. Ein GUI-Client kann diese Situation entsprechend verarbeiten."
]

{ #category : #announcements }
APartAbstractClient >> interfaceClosing: anAnnouncement [

	self close
]

{ #category : #announcements }
APartAbstractClient >> interfaceFocusRequest: anAnnouncement [
	"Only GUI clients have to do something here"
	"DE:Nur GUI-Clients müssen hier etwas tun"
]

{ #category : #announcements }
APartAbstractClient >> interfaceFocusRequest: anAnnouncement from: anAnnouncer [
	"Only GUI clients have to do something here"
	"DE:Nur GUI-Clients müssen hier etwas tun"
]

{ #category : #private }
APartAbstractClient >> isDisconnected [

	^partInterface isDisconnected
]

{ #category : #API }
APartAbstractClient >> isHeadlessClient [

	^false
]

{ #category : #API }
APartAbstractClient >> isOpen [

	self subclassResponsibility
]

{ #category : #binding }
APartAbstractClient >> listFor: aKey ifAbsent: absentBlock [

	^partInterface
		ifNil: [absentBlock value]
		ifNotNil: [partInterface description aspectFor: aKey ifAbsent: absentBlock]
]

{ #category : #announcements }
APartAbstractClient >> localeChanged: anAnnouncement [

]

{ #category : #binding }
APartAbstractClient >> menuFor: aKey ifAbsent: absentBlock [

	^partInterface
		ifNil: [absentBlock value]
		ifNotNil: [partInterface menuFor: aKey ifAbsent: absentBlock]
]

{ #category : #binding }
APartAbstractClient >> menuFor: aKey wrappedIn: parentMenu [

	| rawMenu |
	rawMenu := self menuFor: aKey
				ifAbsent: [self error: 'Missing menu definition for key ' , aKey printString].
	rawMenu value menuItems do: [:anItem | parentMenu addItem: anItem].
	^parentMenu
]

{ #category : #notification }
APartAbstractClient >> notifyCalledDisabledAction: anAction [

	| reason |
	reason := anAction statefulCondition conditionChange reason.
	APDisabledActionCallError signalReason: reason
]

{ #category : #'API notifications' }
APartAbstractClient >> onNotification: aNotificationNameSymbol do: aBlock [ 

	notificationHandlers ifNil: [ notificationHandlers := OrderedCollection new ].
	
	notificationHandlers add: (aNotificationNameSymbol -> aBlock).
]

{ #category : #'interface opening' }
APartAbstractClient >> openModalUnder: aParentClient [

	self subclassResponsibility
]

{ #category : #API }
APartAbstractClient >> partInterface [

	^partInterface
]

{ #category : #'API inspector' }
APartAbstractClient >> printDescriptionForInspectorOn: s [

	<ignoreForCoverage>

	s
		nextPutAll: 'Client class ';
		nextPutAll: self class name;
		cr;
		nextPutAll: 'Types: '.
	self class clientTypes printOn: s.
	s cr
]

{ #category : #printing }
APartAbstractClient >> printOn: s [

	<ignoreForCoverage>
	
	super printOn: s.
	partInterface notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: partInterface part class name;
				nextPut: $)]
]

{ #category : #notifications }
APartAbstractClient >> processInterfaceNotification: anAPInterfaceNotificationAnnouncement [

	notificationHandlers ifNil: [ ^ self ].
	
	notificationHandlers do: [ :assoc | 
		(assoc key = anAPInterfaceNotificationAnnouncement notificationName)
			ifTrue: [
				assoc value valueWithEnoughArguments: anAPInterfaceNotificationAnnouncement arguments ] ]
	

]

{ #category : #private }
APartAbstractClient >> promptExecutor [

	promptExecutor isNil ifTrue: [promptExecutor := self createPromptExecutor].
	^promptExecutor
]

{ #category : #'initialize-release' }
APartAbstractClient >> promptExecutor: anObject [

	promptExecutor := anObject
]

{ #category : #announcements }
APartAbstractClient >> receiverForExtraAnnouncements [

	^self
]

{ #category : #'API notifications' }
APartAbstractClient >> removeNotificationsNamed: aNotificationNameSymbol [ 

	notificationHandlers ifNil: [ ^ self ].
	
	notificationHandlers := notificationHandlers reject: [ :each | each key = aNotificationNameSymbol ]

]

{ #category : #'interface closing' }
APartAbstractClient >> requestForPartClose [

	^partInterface requestForPartClose
]

{ #category : #announcements }
APartAbstractClient >> selectorForExtraAnnouncement: originalSelector [

	<ignoreForCoverage>
	"for overriding in subclasses"
	^originalSelector
]

{ #category : #API }
APartAbstractClient >> setActiveSubAppForKey: aSubAppKey [
	<ignoreForCoverage>
	"Usually nothing to do"
	"DE:Normalerweise nichts zu tun"
]

{ #category : #API }
APartAbstractClient >> setAspect: anAspectKey value: aValue [

	(self aspectFor: anAspectKey ifAbsent: [^nil]) value: aValue
]

{ #category : #API }
APartAbstractClient >> subAppConfiguration [

	^subAppConfiguration
]

{ #category : #announcements }
APartAbstractClient >> subClients [
	"Override if SubClients are present."
	"DE:Überdefinieren, falls SubClients vorhanden sind."

	^#()
]

{ #category : #'initialize-release' }
APartAbstractClient >> updateConfigurationsFromPart [

	clientConfiguration := partInterface part clientConfiguration.
	subAppConfiguration := partInterface part subAppConfiguration.

]

{ #category : #API }
APartAbstractClient >> valueForAspect: aKey [

	^(self aspectFor: aKey
		ifAbsent: 
			[ APMissingAspectKeyError signalKey: aKey ])
			value
]
