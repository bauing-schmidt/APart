Class {
	#name : #APartPharoPlatform,
	#superclass : #APartPlatform,
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartPharoPlatform class >> isResponsibleForCurrentPlatform [

	^ Object superclass notNil
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> allPragmasNamed: aSymbol under: parentClass [

	^ Array streamContents: [ :stream | 
		parentClass withAllSubclassesDo: [ :class | 
			class pragmasDo: [ :pragma |
				pragma selector = aSymbol ifTrue: [ stream nextPut: pragma ] ].
			parentClass = class ifTrue: [ ^ stream contents ] ] ]
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> associationClassForDialogs [

	^ Association
]

{ #category : #accessing }
APartPharoPlatform >> chooseFromList: newList values: newListValues part: aPartDialog label: aLabel messageString: messageString [
	| associations dialog listPresenter result |
	associations := newList
		with: newListValues
		collect: [ :text :value | text -> value ].
	dialog := APVersatileDialogPresenter
		newApplication: aPartDialog specApplication.
	dialog title: aLabel.
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	listPresenter := dialog newList.
	listPresenter items: associations.
	listPresenter display: [ :association | association key ].
	dialog contentArea: listPresenter.
	dialog
		addButton: #ok
		text: (dialog translate: (self aPartTranslateDeferred: 'OK'))
		value: #ok
		condition: [ listPresenter selection isEmpty not ].
	dialog addButton: #cancel text: (dialog translate: (self aPartTranslateDeferred: 'Cancel')) value: nil.
	dialog defaultButtonId: #ok.
	dialog initialExtent: 500@((150 + (newListValues size * 30)) min: 700).
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction
		ifNotNil: [ :anAction | anAction cull: dialog ].
	result := dialog result = #ok
		ifTrue: [ listPresenter selection selectedItem value ]
		ifFalse: [ nil ].
	^ result
]

{ #category : #accessing }
APartPharoPlatform >> chooseManyFromList: newList values: newListValues part: aPartDialog label: aLabel messageString: messageString [
	| associations dialog listPresenter result |
	associations := newList
		with: newListValues
		collect: [ :text :value | text -> value ].
	dialog := APVersatileDialogPresenter
		newApplication: aPartDialog specApplication.
	dialog title: aLabel.
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	listPresenter := dialog newList.
	listPresenter items: associations.
	listPresenter display: [ :association | association key ].
	listPresenter beMultipleSelection.
	dialog contentArea: listPresenter.
	dialog addButton: #ok text: (dialog translate: (self aPartTranslateDeferred: 'OK')) value: #ok.
	dialog addButton: #cancel text: (dialog translate: (self aPartTranslateDeferred: 'Cancel')) value: nil.
	dialog defaultButtonId: #ok.
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction
		ifNotNil: [ :anAction | anAction cull: dialog ].
	result := dialog result = #ok
		ifTrue: [ listPresenter selectedItems collect: #value ]
		ifFalse: [ nil ].
	^ result
]

{ #category : #accessing }
APartPharoPlatform >> chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil dialog: aPartDialog [
	"Ask the user a question, expecting the question to be a rather long string.
	The question is displayed in a scrollable text editor rather than with a simple label.
	Let the user pick from a row of buttons made up
	to match the labels collection.  Return the response from the corresponding
	item from the values collection. aVisualOrNil, if not nil, may be either a VisualPart or a
	ScheduledWindow.  It controls the look and feel and color choices
	used by the dialog, and supplies the dialog's master window, which
	is used by some window systems to create a visual connection between
	the dialog and the window that created it."

	| dialog result buttonIndex title |
	
	title := 'asdf'.
	
	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: (title translateFor: aPartDialog locale).
	dialog contentArea: (dialog newText text: (messageString translateFor: aPartDialog locale)).
	buttonIndex := 1.
	
	labels with: values do: [ :text :value | 
		| buttonId |
		buttonId := ('button', buttonIndex asString) asSymbol.
		dialog addButton: buttonId text: text value: value.
		buttonIndex := buttonIndex + 1 ].
	
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction ifNotNil: [ :anAction |
		anAction cull: dialog ].

	result := dialog result.
	
	^ result
]

{ #category : #accessing }
APartPharoPlatform >> chooseReport: messageString labels: labels values: values default: defaultValue equalize: eqBoolean for: aVisualOrNil wLabel: wLabel dialog: aPartDialog [
	"Ask the user a question, expecting the question to be a rather long string.
	The question is displayed in a scrollable text editor rather than with a simple label.
	Let the user pick from a row of buttons made up
	to match the labels collection.  Return the response from the corresponding
	item from the values collection. aVisualOrNil, if not nil, may be either a VisualPart or a
	ScheduledWindow.  It controls the look and feel and color choices
	used by the dialog, and supplies the dialog's master window, which
	is used by some window systems to create a visual connection between
	the dialog and the window that created it."

	| dialog result buttonIndex |
	
	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: (wLabel translateFor: aPartDialog locale).
	dialog contentArea: (dialog newText text: (messageString translateFor: aPartDialog locale)).
	buttonIndex := 1.
	
	labels with: values do: [ :text :value | 
		| buttonId |
		buttonId := ('button', buttonIndex asString) asSymbol.
		dialog addButton: buttonId text: text value: value.
		buttonIndex := buttonIndex + 1 ].
	
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction ifNotNil: [ :anAction |
		anAction cull: dialog ].

	result := dialog result.
	
	^ result
]

{ #category : #accessing }
APartPharoPlatform >> clipboardText: aString [

	Clipboard clipboardText: aString
]

{ #category : #accessing }
APartPharoPlatform >> closeAndUnschedule: aPartApplicationModel [

	^ aPartApplicationModel pharoCloseAndUnschedule
]

{ #category : #accessing }
APartPharoPlatform >> computeSpecForConfiguration: clientConfiguration specKey: specKey in: anApplicationModel [

	| uiSpec |
	
	(APValueConfigurationRendererSpecGUI on: anApplicationModel specKey: specKey)
		renderDialogForConfiguration: clientConfiguration.
	clientConfiguration reasonForInvalidity notNil ifTrue: [^nil].
	^uiSpec
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> containerChanging: aPartApplicationModel [

	^ aPartApplicationModel pharoContainerChanging
]

{ #category : #accessing }
APartPharoPlatform >> errorMessage: messageString wLabel: wLabel dialog: aPartDialog [

	| dialog result |
		
	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: (wLabel isEmptyOrNil
		ifTrue: ['PDM error']
		ifFalse: [wLabel]).
	"dialog mainMessage: (aPartDialog client ownerDo: [ :theOwner | messageString translateFor: theOwner ]) expandMacros."
	dialog mainMessage: (messageString translateFor: aPartDialog specApplication locale).
	dialog mainIcon: (aPartDialog iconNamed: #error).
	dialog addButton: #ok text: 'OK' value: #ok.
	dialog defaultButtonId: #ok. 
		
	dialog openModalWithSpec.

	result := dialog result.
	result ifNil: [ result := #ok ].
	
	^ result
]

{ #category : #accessing }
APartPharoPlatform >> handleDefaultAnnouncedState: anAnnouncedState in: aPartApplicationModel [

	^ aPartApplicationModel pharoHandleDefaultAnnouncedState: anAnnouncedState
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> installDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoInstallDoubleClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> installFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoInstallFocusInActionFrom: anInterface forSequenceViewKey: aSequenceViewKey

]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> installItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoInstallItemExpandedActionFrom: anInterface forTreeViewKey: aTreeViewKey 

]

{ #category : #accessing }
APartPharoPlatform >> installRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoInstallRequestSelectionChangedActionFrom: anInterface forSequenceViewKey: aSequenceViewKey
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> installRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoInstallRightClickActionFrom: anInterface forSequenceViewKey: aSequenceViewKey
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> interfaceFocusRequest: anAnnouncement from: anInterface in: aPartApplicationModel [

	^ aPartApplicationModel pharoInterfaceFocusRequest: anAnnouncement from: anInterface
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoItemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey

]

{ #category : #accessing }
APartPharoPlatform >> message: messageString wLabel: wLabel dialog: aPartDialog [

	| theLabel dialog result |
	(wLabel isNil or: [wLabel = ''])
		ifTrue: 
			[theLabel := (self aPartTranslate: 'pdm - Information')]
		ifFalse: [theLabel := wLabel].
		
	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: theLabel.
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	dialog mainIcon: (aPartDialog iconNamed: #warning).
	dialog addButton: #ok text: (dialog translate: 'OK') value: #ok.
	dialog defaultButtonId: #ok. 
	
	dialog openModalWithSpec.

	result := dialog result.
	result ifNil: [ result := #ok ].
	
	^ result
]

{ #category : #accessing }
APartPharoPlatform >> multipleChoice: messageString labels: labelArray values: valueArray default: defaultValue wLabel: wLabel dialog: aPartDialog [

	| theLabel result dialog defaultButton buttonIndex |
	theLabel := wLabel.
	((theLabel isNil) or: [theLabel = ''])
		ifTrue:	[theLabel := 'IMS - Frage'.
				theLabel := self translate: theLabel with: 'question' in: aPartDialog.
				].

	buttonIndex := 1.
	
	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: theLabel.
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	dialog mainIcon: (aPartDialog iconNamed: #question).
	labelArray with: valueArray do: [ :text :value | 
		| buttonId |
		buttonId := ('button', buttonIndex asString) asSymbol.
		value = defaultValue ifTrue: [ defaultButton := buttonId ].
		dialog addButton: buttonId text: text value: value.
		buttonIndex := buttonIndex + 1 ].
	dialog defaultButtonId: defaultButton.
	
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction ifNotNil: [ :anAction |
		anAction cull: dialog ].

	result := dialog result.

	result isNil ifTrue: [ result := #cancel ].
	^result
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> nativeValueHolderFrom: anObject [

	^ NewValueHolder value: anObject
]

{ #category : #accessing }
APartPharoPlatform >> numberInputFrom: anObject [

	^ [anObject asNumber] onErrorDo: [ 0 ]
]

{ #category : #accessing }
APartPharoPlatform >> openClientFor: aPart [

	| app clients | 
	
	clients := (aPart partInterface findParentClientsForPrompt: aPart) reject: #isPart.
	
	^ clients 
		ifNotEmpty: [ 
			app := [ (((clients collect: [:eachClient | eachClient promptExecutor]) asSortedCollection: [:a :b |
				(a weightForExecutingPrompt: aPart) >= (b weightForExecutingPrompt: aPart)]) removeFirst owner ownerDo: #yourself) application ] onErrorDo: [SpApplication defaultApplication ].
			aPart clientRegistry openClientsForPart: aPart application: app ]
		ifEmpty: [ 
			aPart clientRegistry openClientsForPart: aPart application: aPart newApplication]
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> openModal: aClass onPart: aPromptPart parentClient: aParentClient [

	| promptClient anApplication  presenter | 
	promptClient := APartGUIClient on: aPromptPart partInterface.
	
	anApplication := aParentClient 
		ifNil: [ SpApplication defaultApplication ]
		ifNotNil: [ 
			aParentClient application
				ifNil: [ 	aParentClient ownerDo: [ :theOwner | theOwner application ] ] ].
		
	presenter := (aClass basicNew initOn: promptClient)
		application: anApplication.
			
	presenter privateClient
		ifNotNil: [ :c | 
			c clientConfiguration ifNotNil: [ :aClientConfiguration |
				presenter computeSpecForConfiguration: aClientConfiguration specKey: #windowSpec ].
			c registerView: presenter value.
			presenter postOpen ].
			
	presenter openModalWithSpec.

]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> ownerWindowOf: aGUIElement [

	^ nil
]

{ #category : #accessing }
APartPharoPlatform >> postBuildTreeKey: aTreeViewKey in: aView interface: interface builder: anAspectBuilder [
]

{ #category : #accessing }
APartPharoPlatform >> questionYesNo: messageString wLabel: wLabel labelYes: aYesLabel labelNo: aNoLabel dialog: aPartDialog [

	| dialog  result|

	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: wLabel.
	dialog withWindowDo: [ :aWindow | aWindow title: wLabel ].
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	dialog mainIcon: (aPartDialog iconNamed: #question).
	dialog addButton: #yes text: aYesLabel value: #yes.
	dialog addButton: #no text: aNoLabel value: #no.
	dialog defaultButtonId: #yes. 

	(ProvideAnswerNotification signal: messageString) 
		ifNotNil: [ :answer | 
			result := answer ifTrue: [ #yes ] ifFalse: [ #no ] ]
		ifNil: [ 	
			dialog openModalWithSpec.
			result := dialog result.
			result ifNil: [ result := #no ] ].
		
	^result
]

{ #category : #accessing }
APartPharoPlatform >> request: messageString initialAnswer: initialAnswer wLabel: wLabel dialog: aPartDialog [

	| theLabel theAnswer dialog result |
	theLabel := wLabel.
	((theLabel isNil) or: [theLabel = ''])
		ifTrue:	[theLabel := 'IMS - Eingabe'.
				theLabel := self translate: theLabel with: 'request' in: aPartDialog.
				].
	theAnswer := initialAnswer.
	theAnswer isNil ifTrue: [ theAnswer := ' ' ].
	theAnswer = #password ifTrue: [ theAnswer := '#password' ].
			
	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.
	dialog title: theLabel.
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	dialog contentArea: (dialog newTextInput text: theAnswer).
	dialog addButton: #ok text: (dialog translate: (self aPartTranslateDeferred: 'OK')) value: #ok.
	dialog addButton: #cancel text: (dialog translate: (self aPartTranslateDeferred: 'Cancel')) value: #cancel.
	dialog defaultButtonId: #ok. 
	dialog expandContentVertically: false.
	
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction ifNotNil: [ :anAction |
		anAction cull: dialog ].

	result := dialog result.
	(result isNil or: [dialog result = #cancel]) ifTrue: [ ^ nil ].
	
	^dialog contentArea text
]

{ #category : #accessing }
APartPharoPlatform >> requestColorValue: aPromptPart [

	aPromptPart value: (UIManager default chooseFullFileNameMatching: nil label: aPromptPart title).
	^aPromptPart value = ''
		ifTrue: 
			[aPromptPart value: nil.
			#fileSelectionCancelled]
		ifFalse: [#fileSelected]
]

{ #category : #accessing }
APartPharoPlatform >> requestExistingFilename: aPromptPart [

	self flag: #todo
]

{ #category : #accessing }
APartPharoPlatform >> requestMultiline: messageString initialAnswer: initialAnswer wLabel: wLabel dialog: aPartDialog [

	| theLabel theAnswer dialog result |

	dialog := APVersatileDialogPresenter newApplication: aPartDialog specApplication.

	theLabel := wLabel.
	((theLabel isNil) or: [theLabel = ''])
		ifTrue:	[theLabel := 'IMS - Eingabe'.
				theLabel := self translate: theLabel with: 'request' in: aPartDialog.
				].
	theAnswer := initialAnswer.
	theAnswer isNil ifTrue: [ theAnswer := ' ' ].
	theAnswer = #password ifTrue: [ theAnswer := '#password' ].
			
	dialog title: theLabel.
	dialog mainMessage: (messageString localizedForPresenter: dialog).
	dialog contentArea: (dialog newText text: theAnswer).
	dialog addButton: #ok text: (dialog translate: (self aPartTranslateDeferred: 'OK')) value: #ok.
	dialog addButton: #cancel text: (dialog translate: (self aPartTranslateDeferred: 'Cancel')) value: #cancel.
	dialog defaultButtonId: #ok. 
	
	dialog openModalWithSpec.
	aPartDialog client promptExecutor postOpenAction ifNotNil: [ :anAction |
		anAction cull: dialog ].

	result := dialog result.
	(result isNil or: [dialog result = #cancel]) ifTrue: [ ^ nil ].
	
	^dialog contentArea text
]

{ #category : #accessing }
APartPharoPlatform >> requestNewFilename: aPromptPart [

	aPromptPart value: (UIManager default chooseFullFileNameMatching: nil label: aPromptPart title).

	^aPromptPart value = ''
		ifTrue: 
			[aPromptPart value: nil.
			#fileSelectionCancelled]
		ifFalse: [#fileSelected]
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> setSubView: aSubView inSubCanvas: aSubCanvasKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoSetSubView: aSubView inSubCanvas: aSubCanvasKey
]

{ #category : #'as yet unclassified' }
APartPharoPlatform >> setSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey in: aPartApplicationModel [

	^ aPartApplicationModel pharoSetSubView: aSubView spec: aSpecSymbol inSubCanvas: aSubCanvasKey
]

{ #category : #accessing }
APartPharoPlatform >> subViewOn: aParentView from: aClass [

	^(aClass basicNew)
		owner: aParentView;
		initOn: aParentView client;
		yourself
]

{ #category : #accessing }
APartPharoPlatform >> translate: theLabel with: aTranslation in: aPartDialog [

	^ theLabel
]
