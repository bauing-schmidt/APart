"
APartApplicationModel ist die Basisklasse für alle Subklassen von ApplicationModel, die mit dem aPart-Framework arbeiten.

contextMenuSymbol 
	- holds information about the aspect providing the context menus
"
Class {
	#name : #APartPresenter,
	#superclass : #SpPresenterWithModel,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#instVars : [
		'client',
		'dialog',
		'ribbonUI',
		'ribbonConfigurator',
		'tooltips',
		'isOpen',
		'subAppViews',
		'presenters',
		'oldPresenters'
	],
	#category : #'APart Pharo'
}

{ #category : #API }
APartPresenter class >> aPartGUIBaseClass [
	<aPartGUIBaseClass>
]

{ #category : #'instance creation' }
APartPresenter class >> asSubViewOn: aParentView [

	^ APartPlatform current subViewOn: aParentView from: self
]

{ #category : #'instance creation' }
APartPresenter class >> asSubViewOn: aParentView subInterface: aSubInterface [

	^self basicNew 
		owner: aParentView;
		initOn: (self guiClientFor: aSubInterface)
]

{ #category : #binding }
APartPresenter class >> aspectPathClass [

	^APAspectPath
]

{ #category : #'as yet unclassified' }
APartPresenter class >> associatedPresenters [

	^ Dictionary new
]

{ #category : #specs }
APartPresenter class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
	}
]

{ #category : #API }
APartPresenter class >> clientTypes [

	^#(#GUI)
]

{ #category : #'private-events' }
APartPresenter class >> constructEventsTriggered [

	^(super constructEventsTriggered)
		add: #containerChanging;
		yourself
]

{ #category : #API }
APartPresenter class >> guiClientClass [
	"This class is generic"
	"DEDiese Klasse ist generisch"
	
	^APartGUIClient
]

{ #category : #API }
APartPresenter class >> guiClientFor: aPartInterface [

	^self guiClientClass on: aPartInterface
]

{ #category : #API }
APartPresenter class >> matchingPartClass [
	"Muss in Subklassen definiert werden"

	^nil
]

{ #category : #API }
APartPresenter class >> matchingPartClasses [
	"Falls eine Subklasse mehrere Part-Klassen unterstützt, muss sie diese Methode überdefinieren. Falls sie genau eine unterstützt, wird diese in #matchingPartClass erwartet."

	^self matchingPartClass ifNotNil: [:class | Array with: class] ifNil: [#()]
]

{ #category : #'as yet unclassified' }
APartPresenter class >> newOnPart: aPart owner: aPresenter [

	| aClient instance aClass |

	aClient := self guiClientFor: aPart partInterface.
	aClient application: aPresenter application.
	aClient backendToUse: aPresenter application backend class backendName.
	aClass := (aPart clientRegistry findClientClassesWithTypesForPart: aPart) at: #GUI ifAbsent: [ APCouldNotFindClientForOpeningError signal: aPart ].
	instance := aClass basicNew. 
	instance owner: aPresenter.
	instance initOn: aClient.
	^ instance.
]

{ #category : #'instance creation' }
APartPresenter class >> onGuiClient: aClient [

	^self basicNew initOn: aClient
]

{ #category : #API }
APartPresenter class >> openModalOnPart: aPromptPart parentClient: aParentClient [

	APartPlatform current openModal: self onPart: aPromptPart parentClient: aParentClient
]

{ #category : #'instance creation' }
APartPresenter class >> openOn: anInstance [

	^ self openOn: anInstance withSpec: #defaultLayout
]

{ #category : #'instance creation' }
APartPresenter class >> openOn: anInstance in: anApplication [
	
	anInstance application: anApplication.
	^ self openOn: anInstance withSpec: #defaultLayout
]

{ #category : #'as yet unclassified' }
APartPresenter class >> openOn: anInstance withSpec: aSymbol [
	"Create a running instance of the application and open its user 
	interface using the designated specification."

	| presenter |
	presenter := anInstance openWithSpec: aSymbol.
	anInstance privateClient
		ifNotNil: [ :c | 
			c clientConfiguration ifNotNil: [ :aClientConfiguration |
				anInstance computeSpecForConfiguration: aClientConfiguration specKey: #windowSpec ].
			c registerView: presenter presenter value.
			anInstance postOpen ].
	^ presenter
]

{ #category : #'instance creation' }
APartPresenter class >> openOnPart: aPart [

	^self openOn: (self onGuiClient: (self guiClientFor: aPart partInterface))
]

{ #category : #'as yet unclassified' }
APartPresenter class >> openOnPart: aPart application: anApplication [

	| aGuiClient |
	aGuiClient := self guiClientFor: aPart partInterface.
	aGuiClient application: anApplication.
	anApplication aPartGuiClient: aGuiClient.
	^self openOn: (self onGuiClient: aGuiClient) in: anApplication
]

{ #category : #'instance creation' }
APartPresenter class >> openOnPart: aPart withSpec: aSymbol [

	^self openOn: (self onGuiClient: (self guiClientFor: aPart partInterface))
		withSpec: aSymbol
]

{ #category : #'as yet unclassified' }
APartPresenter class >> openWithGtk [

	"utility method"
	
	| presenter app part |

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.

	part := self matchingPartClasses first createWithClientRegistry.
	presenter := self openOnPart: part application: app.

	^ presenter
]

{ #category : #API }
APartPresenter class >> usedPragmas [
	<pragmas: #class>

	^#(#aPartGUIBaseClass #aPartRibbonConfiguration)
]

{ #category : #'VisualWorks metadata' }
APartPresenter class >> visualWorksMetadata [

	^ #(
		'superclassNamespace' 'UI'
	)

]

{ #category : #'widget callbacks' }
APartPresenter >> aPartValidateAspect: aController [
	"Hier wird immer true zurückgegeben, weil das Blockieren des Widgets unerwünscht ist.
	Falls das Model den Wert gegenüber dem Part zurückweisen will, muss es auch beim #value: die Validierung durchführen und die Übergabe ggf. vermeiden."

	| m |
	m := aController model.
	aController hasEditValue
		ifFalse: 
			[m noticeInvalidValue.
			^true].
	(m validate: aController view editValue) ifFalse: [aController view flash].
	^true
]

{ #category : #binding }
APartPresenter >> actionFor: aKey [

	^client
		ifNil: [ [self perform: aKey] ]
		ifNotNil: [client actionFor: aKey ifAbsent: [ [self perform: aKey]]]
]

{ #category : #private }
APartPresenter >> addAllSubpresentersTo: anOrderedCollection [ 

	self presenters valuesDo: [ :each |
		anOrderedCollection add: each.
		each isAPartPresenter ifTrue: [ 
			each addAllSubpresentersTo: anOrderedCollection ] ].
	
]

{ #category : #TOREMOVE }
APartPresenter >> additionalSubpresentersMap [

	^ additionalSubpresentersMap ifNil: [ additionalSubpresentersMap := OrderedDictionary new ]
]

{ #category : #API }
APartPresenter >> allSubpresenters [ 

	| result |
	
	result := OrderedCollection new.
	result addAllSubpresentersTo: result.
	^ result
]

{ #category : #announcements }
APartPresenter >> announcedStatesSpecialKeys [

	^Set new
]

{ #category : #accessing }
APartPresenter >> application [

	^ self hasOwner 
		ifTrue: [ self owner application ]
		ifFalse: [
			application ifNil: [ 
				application :=  SpApplication new useBackend: #Gtk ] ]
]

{ #category : #'as yet unclassified' }
APartPresenter >> askOkToClose [ 

	^ true
]

{ #category : #binding }
APartPresenter >> aspectFor: aKey [
	"nil query on interface allows to use the same view class without parts. The notation of the method makes it possible to set a breakpoint on such a case."

	^client
		ifNil: [ APAspect named: aKey for: (self perform: aKey) ]
		ifNotNil: [(client aspectFor: aKey ifAbsent: [ APAspect named: aKey for: (self perform: aKey) ])]
]

{ #category : #'as yet unclassified' }
APartPresenter >> associatedPresenters [

	^ self class associatedPresentersFor: self
]

{ #category : #accessing }
APartPresenter >> client [ 
	
	^ client
]

{ #category : #'interface closing' }
APartPresenter >> closeAndUnschedule [
	"#executeAutosave is usually executed on #requestForClose. However, if #close starts from the part, #requestForClose will not be reached."
	"DE:#executeAutosave wird normalerweise beim #requestForClose ausgeführt. Falls der #close jedoch vom Part ausgeht, wird #requestForClose nicht erreicht."

	^ self window close
]

{ #category : #announcements }
APartPresenter >> componentAt: k [
	"Bei Bedarf können Unterklassen weitere builder hier einbinden"

	^self bindingsManager componentAt: k
]

{ #category : #'as yet unclassified' }
APartPresenter >> computePreferredExtentForText: aText [

	"stub"
	^ 100@20
]

{ #category : #private }
APartPresenter >> computeSpecForConfiguration: clientConfiguration specKey: originalSpecKey [
	"Default: clientConfiguration wird als specKey benutzt"

	^self class interfaceSpecFor: clientConfiguration
]

{ #category : #updating }
APartPresenter >> containerChanging [
	"by default containerChanging event is propagated through this call to all subcanvases of the current model"

	^ APartPlatform current containerChanging: self
]

{ #category : #'as yet unclassified' }
APartPresenter >> createPresenters [
	
	self createPresentersFrom: self associatedPresenters source: self.


]

{ #category : #'as yet unclassified' }
APartPresenter >> createPresentersFrom: aDictionary source: aSource [
		
	aDictionary associationsDo: [ :aspectAssociation | 
		| aPresenter |
		aPresenter := (aspectAssociation value) value.
		self presenters at: aspectAssociation key put: aPresenter.
		aPresenter suggestAspectSymbol: aspectAssociation key.
		self additionalSubpresentersMap at: aspectAssociation key put: aPresenter].

	(self presenters select: #isAPartPresenter) do: [ :aPresenter |
		self setupPresenter: aPresenter fromSource: aSource owner: self ].
	
]

{ #category : #accessing }
APartPresenter >> createPromptExecutor [

	^APViewPromptExecutor on: client
]

{ #category : #announcements }
APartPresenter >> defaultKeyboardFocus [

	| aSubPart |
	
	self hasPartInterface ifFalse: [ ^ nil ].
	
	aSubPart := self partInterface part defaultKeyboardFocus.
		
	^ self additionalSubpresentersMap detect: [ :each | 
		each hasPartInterface and: [ each partInterface part = aSubPart ] ] ifNone: [ nil ]
]

{ #category : #'as yet unclassified' }
APartPresenter >> defaultLayout [ 

	^ self class defaultLayout
]

{ #category : #accessing }
APartPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #'as yet unclassified' }
APartPresenter >> detachFromPart [ 

	self partInterface ifNotNil: [ 
		self presenters values do: [ :aPresenter |
			self partInterface part description ifNotNil: [ :desc |
				(desc aspects values do: [ :each | each subAdaptor removeDependent: aPresenter])].
	] ].

	super detachFromPart. 

	 self client release.
	
]

{ #category : #'interface closing' }
APartPresenter >> dialogClose [

	^client requestForPartClose ifTrue: [self privateCloseDialog] ifFalse: [false]
]

{ #category : #access }
APartPresenter >> disable [

	
]

{ #category : #accessing }
APartPresenter >> enable [

	
]

{ #category : #actions }
APartPresenter >> executeActionFor: actionKey [

	client executeActionFor: actionKey
]

{ #category : #'as yet unclassified' }
APartPresenter >> getPresenterNamed: aSymbol argumetns: args [

	^ self presenters at: aSymbol
]

{ #category : #'interface closing' }
APartPresenter >> handleDefaultAnnouncedState: anAnnouncedState [

	^ APartPlatform current handleDefaultAnnouncedState: anAnnouncedState in: self
]

{ #category : #accessing }
APartPresenter >> hasPartInterface [

	^ true and: [ self partInterface notNil  ]
]

{ #category : #help }
APartPresenter >> help: aString [
]

{ #category : #'initialize-release' }
APartPresenter >> initOn: aClient [

	client := aClient.
	self application: aClient application.	
	self initialize
]

{ #category : #'as yet unclassified' }
APartPresenter >> initializationFinished [

	"all the presenter initialization is done (but adapter may still not be created)"
]

{ #category : #'initialize-release' }
APartPresenter >> initialize [

	super initialize.
	isOpen := false.
	tooltips := Dictionary new.
	subAppViews := Dictionary new.
]

{ #category : #'as yet unclassified' }
APartPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	"do not use any dialog buttons when opened as modal dialog"
]

{ #category : #'as yet unclassified' }
APartPresenter >> initializePresenters [ 

	super initializePresenters.
	client ifNotNil: [:c | c registerView: self].
	
	"place this send here to perform it at the very end of "
	self whenBuiltDo: [ :this | self notifyPartAboutMyself ]
]

{ #category : #'as yet unclassified' }
APartPresenter >> initializePrivateAnnouncements [

	super initializePrivateAnnouncements.
	
	self initializationFinished.
]

{ #category : #'as yet unclassified' }
APartPresenter >> initializePrivateHooks [

	self createPresenters.
	super initializePrivateHooks.
]

{ #category : #'as yet unclassified' }
APartPresenter >> initializeWidgets [
]

{ #category : #'interface opening' }
APartPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.

	aWindowPresenter ifNotNil: [:w | 
		self partInterface part windowTitle ifNotNil: [ :t |
			w title: t ] 
	]
		
]

{ #category : #API }
APartPresenter >> inspectorLabel [

	^'GUI: ' , self class name
]

{ #category : #'interface opening callbacks' }
APartPresenter >> installDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [

	^ APartPlatform current installDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: self
]

{ #category : #'interface opening callbacks' }
APartPresenter >> installFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [

	^ APartPlatform current installFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: self

]

{ #category : #'interface opening callbacks' }
APartPresenter >> installItemCollapsedActionFrom: anInterface forTreeViewKey: aTreeViewKey [

	(self bindingsManager componentAt: aTreeViewKey)
		ifNotNil: 
			[:treeView |
			(anInterface hasTrigger: #itemCollapsed)
				ifTrue: 
					[treeView widget whenEvent: #itemCollapsed
						do: [:arg | anInterface executeTrigger: #itemCollapsed with: arg]]]
]

{ #category : #'interface opening callbacks' }
APartPresenter >> installItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey [

	^ APartPlatform current installItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey
in: self
]

{ #category : #'interface opening callbacks' }
APartPresenter >> installRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [

	^ APartPlatform current installRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: self
]

{ #category : #'interface opening callbacks' }
APartPresenter >> installRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [

	^ APartPlatform current installRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: self

]

{ #category : #announcements }
APartPresenter >> interfaceChanged: anAnnouncement fromSubInterface: anAnnouncer [


]

{ #category : #'interface opening callbacks' }
APartPresenter >> interfaceFocusRequest: anAnnouncement from: anAnnouncer [

	^ APartPlatform current interfaceFocusRequest: anAnnouncement from: anAnnouncement interface
in: self
]

{ #category : #'interface opening' }
APartPresenter >> interfaceSpecFor: aSymbol [

	^(client ifNotNil: [:c | c clientConfiguration])
		ifNotNil: [:cc | self computeSpecForConfiguration: cc specKey: aSymbol]
		ifNil: [super interfaceSpecFor: aSymbol]
]

{ #category : #accessing }
APartPresenter >> isOpen [

	^isOpen
]

{ #category : #'interface opening callbacks' }
APartPresenter >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey [

	^ APartPlatform current itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey in: self

]

{ #category : #'interface opening callbacks' }
APartPresenter >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forTreeViewKey: aTreeViewKey [

	(self bindingsManager componentAt: aTreeViewKey)
		ifNotNil: 
			[:treeView |
			(treeView widget)
				selectedVisualBlock: 
						[:view :index |
						| wrapper |
						wrapper := self"
									boundedWrapperAt: index
									in: view
									useStringRepresentationBlock: isrb
									iconRepresentationBlock: iirb".
						wrapper component selected setValue: true.
						wrapper]]
]

{ #category : #binding }
APartPresenter >> listFor: aKey [

	^client
		ifNil: [ self ownListFor: aKey ]
		ifNotNil: 
			[client listFor: aKey
				ifAbsent: 
					[(aKey includes: Character space)
						ifTrue: [self bindingsManager tryCompositeKey: aKey]
						ifFalse: [ self ownListFor: aKey ]]]
]

{ #category : #binding }
APartPresenter >> menuFor: aKey [

	^client
		ifNil: [super menuFor: aKey]
		ifNotNil: [client menuFor: aKey ifAbsent: [super menuFor: aKey]]
]

{ #category : #actions }
APartPresenter >> menuPresenterFor: aMenu action: aBlock [

	| menuPresenter |
	
	menuPresenter := self instantiate: SpMenuPresenter.

	menuPresenter addGroup: [ :aGroup |
		aMenu items do: [ :menuItem |
			aGroup addItem: [ :anItem |
				menuItem hasSubmenu ifTrue: [
					anItem 
						name: (menuItem label translateFor: self application locale);
						subMenu: (self menuPresenterFor: menuItem submenu action: aBlock)	
 ]
				ifFalse: [
					anItem
						name: menuItem label;
						action: [ aBlock value: menuItem ] ] ] ] ].
	^ menuPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newButton [
	^ self instantiate: APartButtonPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newCheckBox [
	^ self instantiate: APartCheckBoxPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newColorInput [
	^ self instantiate: APartColorInputPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newDropList [ 
	^ self instantiate: APartDropListPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newDropListWithEntry [ 
	^ self instantiate: APartDropListWithEntryPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newList [
	^ self instantiate: APartListPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newNumberInput [
	^ self instantiate: APartNumberInputFieldPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newProgressBar [
	^ self instantiate: APartProgressBarPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newRadioButton [
	^ self instantiate: APartRadioButtonPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newStatusBar [
	^ self instantiate: APartStatusBarPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newSubcanvas [

	^ self newLabel
]

{ #category : #'as yet unclassified' }
APartPresenter >> newText [
	^ self instantiate: APartTextPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newTextInput [
	^ self instantiate: APartTextInputFieldPresenter
]

{ #category : #'as yet unclassified' }
APartPresenter >> newTreeTable [

	^ self instantiate: APartTreeTablePresenter
]

{ #category : #utilities }
APartPresenter >> newUniqueId [

	| prefix i aKey |
	
	prefix := 'generatedId'.
	
	i := 1.
	[ 
		aKey := prefix, i asString.	
		i := i + 1.
		self additionalSubpresentersMap includesKey: aKey ] whileTrue.
	
	^ aKey
]

{ #category : #'as yet unclassified' }
APartPresenter >> notifyPartAboutMyself [

	self partInterface part presenterBuilt: self
]

{ #category : #actions }
APartPresenter >> openMenu: aMenu itemValueDo: aOneArgBlock atPosition: aPoint [
	| menuPresenter selectedItem |
	selectedItem := nil.
	menuPresenter := self
		menuPresenterFor: aMenu
		action: [ :menuItem | selectedItem := menuItem ].
	menuPresenter openWithSpecAt: aPoint.
	selectedItem
		ifNotNil: [ "
	((MenuView model: aMenu) openFromView: builder window)
		ifNotNil: [:activeItem | aOneArgBlock value: activeItem value]" aOneArgBlock value: selectedItem value ]
]

{ #category : #showing }
APartPresenter >> openWithSpec: aSelector [

	application isNil ifTrue: [ self application: client specApplication ].
	^ super openWithLayout: (self perform: aSelector)
]

{ #category : #binding }
APartPresenter >> ownListFor: aKey [

	^[self perform: aKey]
		on: MessageNotUnderstood 
		do: [:ex | | sel |
			sel := ex message selector.
			(sel == aKey)
				ifTrue: [ ex return: (self application listFor: aKey)]
				ifFalse: [ex pass]].
]

{ #category : #accessing }
APartPresenter >> partInterface [

	^client ifNotNil: [:c | c partInterface]
]

{ #category : #announcements }
APartPresenter >> partSwitched: anAnnouncement from: aSwitchingInterface [
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoCloseAndUnschedule [

	"#executeAutosave is usually executed on #requestForClose. However, if #close starts from the part, #requestForClose will not be reached."
	"DE:#executeAutosave wird normalerweise beim #requestForClose ausgeführt. Falls der #close jedoch vom Part ausgeht, wird #requestForClose nicht erreicht."

	isOpen := false.
	self triggerEvent: #containerChanging.
	self releaseRibbonUI.
	client ifNotNil: [:c | c unregisterView: self].
	subAppViews
		ifNotNil: 
			[subAppViews do: [:subAppView | subAppView closeAndUnschedule].
			subAppViews wipe].
	subAppViews := nil.
	super closeAndUnschedule.
	"client darf aufgrund von closeAndUnschedule-Entscheidung fürs Runtime bzgl. Beenden des Images erst ganz am Ende ausgenilt werden, da ansonsten kein Zugriff auf Aspekt #quitOnWindowClose mehr möglich ist über client;
ist imho dem Umstand geschuldet, dass das APart-Framework  nicht wirklich konsistent requestForWindowClose/noticeOfWindowClose/release verwendet, sondern wild gemischt; sollte überabeitet werden!"
	client := nil
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoContainerChanging [
	"by default containerChanging event is propagated through this call to all subcanvases of the current model"

	self presenters do: [ :aPresenter |
		aPresenter triggerEvent: #changing ].
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoHandleDefaultAnnouncedState: anAnnouncedState [

	| k relatedPresenters |
	k := anAnnouncedState key.
			
	relatedPresenters := OrderedCollection new.
	(self presenters, self additionalSubpresentersMap) at: k ifPresent: [ :aPresenter | relatedPresenters add: aPresenter ].

	relatedPresenters addAll: (self presenters values select: [ :each | each isAPartPresenter and: [ each aspectSymbol = k ] ]).
	
	relatedPresenters asSet do: [ :aPresenter |
		aPresenter ifNotNil: [
			anAnnouncedState isActive 
				ifTrue: [aPresenter enable] 
				ifFalse: [aPresenter disable].
			aPresenter enablementHelp: (anAnnouncedState resolvedStateExplainingText ifNil: [ nil ] ifNotNil: [ :val | val asString ] ) ] ].
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoInstallDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [

	
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoInstallFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [


]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoInstallItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey [


]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoInstallRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [


]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoInstallRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey [

	
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoInterfaceFocusRequest: anAnnouncement from: anInterface [
	
	self flag: #todo.
	"https://github.com/pharo-spec/Spec/issues/206"
	
	self window changed: #open with: #().
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoItemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey [

	(isrb isNil and: [iirb isNil]) ifTrue: [^self].
]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoSetSubView: aSubView inSubCanvas: aSubCanvasKey [
	"A change in subcanvas will always send #postOpenWith: to aSubView!"
	"DE:Eine Änderung im Subcanvas wird immer #postOpenWith: an die aSubView senden!"


]

{ #category : #'as yet unclassified' }
APartPresenter >> pharoSetSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey [
	"Listening to #changing events and propagating the call as a containerChanging event to the old subview before switching to another subview.
	When the new subview model is nil, the client:spec:build: does not trigger #changing event.
	When the same model is used to install a different spec, the event will not be installed"

	| subCanvas  |

	subCanvas := self presenterAt: aSubCanvasKey.
			
	aSubView ifNotNil: [ 
		"aSubView createPresenters."
		additionalSubpresentersMap at: aSubCanvasKey put: aSubView.
		presenters at: aSubCanvasKey put: aSubView.
	] ifNil: [ 
		subCanvas triggerEvent: #changing.
		additionalSubpresentersMap at: aSubCanvasKey put: (self newSubcanvas).
		presenters at: aSubCanvasKey put: aSubView.
	].

	layout := self defaultLayout.
	
	subCanvas withAllSubpresenters do: [ :each | 
		each detachFromPart].
		
	GtkRunLoop current processEvents.

]

{ #category : #popups }
APartPresenter >> popup: aPart at: aPoint [

	| presenterClass partPresenter popover| 
	
	presenterClass := aPart matchingPresenterClass.	
	partPresenter := presenterClass newOnPart: aPart owner: self.
	
    popover := SpPopoverPresenter new
        owner: self;
        presenter: partPresenter;
        yourself.        

    popover popupPointingTo: (aPoint extent: 0@0)	
]

{ #category : #'as yet unclassified' }
APartPresenter >> postOpen [

	isOpen := true.
	client ifNotNil: [:c | c updateAndAnnounceAll].
	self 
		when: #containerChanging
		send: #containerChanging
		to: self
]

{ #category : #'interface opening' }
APartPresenter >> postOpenWith: aBuilder [

	isOpen := true.
	super postOpenWith: aBuilder.
	client ifNotNil: [:c | c updateAndAnnounceAll].
	self 
		when: #containerChanging
		send: #containerChanging
		to: self
]

{ #category : #accessing }
APartPresenter >> preferredSpec [

	^#windowSpec
]

{ #category : #API }
APartPresenter >> presenterAt: aName [

	^ self additionalSubpresentersMap at: aName ifAbsent: [ super presenterAt: aName ]
]

{ #category : #'as yet unclassified' }
APartPresenter >> presenterNamed: aString [

	^ self presenters at: aString
]

{ #category : #'as yet unclassified' }
APartPresenter >> presenters [

	^ presenters ifNil: [ presenters := Dictionary new ]
]

{ #category : #'API inspector' }
APartPresenter >> printDescriptionForInspectorOn: s [

	| matchingPartClasses |
	s
		nextPutAll: 'GUI class: ';
		nextPutAll: self class name;
		cr.
	matchingPartClasses := self class matchingPartClasses.
	matchingPartClasses size = 1
		ifTrue: 
			[s
				nextPutAll: 'Matching Part class: ';
				nextPutAll: matchingPartClasses any name;
				cr]
		ifFalse: 
			[s nextPutAll: 'Matching Part classes:'.
			matchingPartClasses do: 
					[:cl |
					s
						cr;
						tab;
						nextPutAll: cl name].
			s cr]
]

{ #category : #'as yet unclassified' }
APartPresenter >> privateClient [
	
	^ client.
]

{ #category : #'interface closing' }
APartPresenter >> privateCloseDialog [

	^dialog close
]

{ #category : #'interface closing' }
APartPresenter >> releaseRibbonUI [

	ribbonConfigurator
		ifNotNil: 
			[self partInterface unregisterTopClient: client
				forChangesInSubInterfaces: (ribbonConfigurator partsToUse
						collect: [:p | p partInterface]).
			ribbonUI ifNotNil: [ribbonUI release]]
]

{ #category : #'interface closing' }
APartPresenter >> requestForWindowClose [

	^client ifNotNil: [client requestForPartClose] ifNil: [true]
]

{ #category : #'as yet unclassified' }
APartPresenter >> requestWindowClose [

	^client ifNotNil: [client requestForPartClose] ifNil: [true]
]

{ #category : #actions }
APartPresenter >> ribbonTabSelected: aRibbonTab [

	| desc |
	client subAppConfiguration
		ifNotNil: 
			[:sac |
			desc := ribbonUI ribbon.
			sac noticeSelectedTab: aRibbonTab]
]

{ #category : #subviews }
APartPresenter >> setSubView: aSubView inSubCanvas: aSubCanvasKey [
	"A change in subcanvas will always send #postOpenWith: to aSubView!"
	"DE:Eine Änderung im Subcanvas wird immer #postOpenWith: an die aSubView senden!"

	^ APartPlatform current setSubView: aSubView inSubCanvas: aSubCanvasKey in: self
]

{ #category : #subviews }
APartPresenter >> setSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey [
	"Listening to #changing events and propagating the call as a containerChanging event to the old subview before switching to another subview.
	When the new subview model is nil, the client:spec:build: does not trigger #changing event.
	When the same model is used to install a different spec, the event will not be installed"

	^ APartPlatform current setSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey in: self
]

{ #category : #'as yet unclassified' }
APartPresenter >> setupPresenter2: aPresenter fromSource: aSource owner: ownerPresenter [

	| valueAdaptor |
	valueAdaptor := (aPresenter bindingsManager source: aSource) aspectAt: aPresenter aspectSymbol.
	valueAdaptor subAdaptor ifNil: [
		valueAdaptor := (ownerPresenter bindingsManager source: ownerPresenter) aspectAt: aPresenter aspectSymbol. ].
	aPresenter setValueAdaptor: valueAdaptor aspect: aPresenter aspectSymbol parent: self interface: self partInterface  
	
]

{ #category : #'as yet unclassified' }
APartPresenter >> setupPresenter: aPresenter fromSource: aSource owner: ownerPresenter [

	| valueAdaptor |
	valueAdaptor := (aPresenter bindingsManager source: aSource) aspectAt: aPresenter aspectSymbol.
	valueAdaptor subAdaptor ifNil: [
		valueAdaptor := (ownerPresenter bindingsManager source: aSource) aspectAt: aPresenter aspectSymbol. ].
	aPresenter setValueAdaptor: valueAdaptor aspect: aPresenter aspectSymbol parent: self interface: self partInterface  
	
]

{ #category : #'interface closing' }
APartPresenter >> simulateEscapeKey [

	self closeRequest
]

{ #category : #'interface opening callbacks' }
APartPresenter >> sliderStart: aStart stop: aStop step: aStep forSteppedSliderKey: aSteppedSliderKey [

	self flag: #todo.
"	(builder componentAt: aSteppedSliderKey)
		ifNotNil: 
			[:slider |
			(slider widget)
				rangeMap: (RangeMap start: aStart stop: aStop grid: aStep);
				propertyAt: #shallSendValueWithState put: true]"
]

{ #category : #subviews }
APartPresenter >> subAppViewAt: aKey ifAbsentPut: aBlock [

	^subAppViews at: aKey ifAbsentPut: aBlock
]

{ #category : #'as yet unclassified' }
APartPresenter >> subPart: anAspect [ 

	| aPart |
	aPart := (self aspectFor: anAspect) value.
	^ APartPresenter newOnPart: aPart owner: self. 
	
]

{ #category : #accessing }
APartPresenter >> tooltipForKey: aKey [

	^tooltips at: aKey ifAbsent: []
]

{ #category : #updating }
APartPresenter >> updateAfterResize [
]

{ #category : #actions }
APartPresenter >> valueForAspect: aspectKey [

	^client valueForAspect: aspectKey
]

{ #category : #API }
APartPresenter >> withAllSubpresenters [ 

	| result |
	
	result := OrderedCollection new.
	result add: self.
	self addAllSubpresentersTo: result.
	^ result
]

{ #category : #accessing }
APartPresenter >> withPartDo: aBlock [

	self partInterface ifNotNil: [ :anInterface |
		aBlock cull: anInterface part ]
	
]
