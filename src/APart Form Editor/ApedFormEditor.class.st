"
A general purpose APart form editor

To open me, evaluate:

```language=Pharo
ApedFormEditor openWithGtk.
```
"
Class {
	#name : #ApedFormEditor,
	#superclass : #APartPresenter,
	#category : #'APart Form Editor-Main'
}

{ #category : #specs }
ApedFormEditor class >> addButtonButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tbutton' and: 'Add a button'.
]

{ #category : #specs }
ApedFormEditor class >> addCheckBoxButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tcheckbox' and: 'Add a checkbox'.
]

{ #category : #specs }
ApedFormEditor class >> addColorInputButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tcolorinput' and: 'Add a color input'.

]

{ #category : #specs }
ApedFormEditor class >> addDropListButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tcombobox' and: 'Add a drop list'.
]

{ #category : #specs }
ApedFormEditor class >> addLabelButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tlabel' and: 'Add a label'.
	
]

{ #category : #specs }
ApedFormEditor class >> addListButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tlistbox' and: 'Add a list'.
]

{ #category : #specs }
ApedFormEditor class >> addNumberInputButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tnumberedit' and: 'Add a numberinput'.
]

{ #category : #specs }
ApedFormEditor class >> addPogressBarButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tprogressbar' and: 'Add a progress bar'.
]

{ #category : #specs }
ApedFormEditor class >> addRadioButtonButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tradiobutton' and: 'Add a radiobutton'.
]

{ #category : #specs }
ApedFormEditor class >> addStatusBarButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tstatusbar' and: 'Add a status bar'.
]

{ #category : #specs }
ApedFormEditor class >> addTextButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tmemo' and: 'Add a multi-line text input'.
]

{ #category : #specs }
ApedFormEditor class >> addTextInputButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'tedit' and: 'Add a text input field'.
]

{ #category : #specs }
ApedFormEditor class >> addTreeTableButtonTo: aPresenter [

	^ self createButtonFor: aPresenter with: 'ttreeview' and: 'Add a tree'.
]

{ #category : #specs }
ApedFormEditor class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
			  (#mainMenu -> [ 
			   | mainMenu |
			   mainMenu := SpMenuBarPresenter new.
			   aPresenter applyKeyBindingsFromMenu: mainMenu.
				mainMenu ]).
			  (#elementsList -> [ 
			   | aList |
			   aList := aPresenter newList
				            dynamicContextMenu: #elementsContextMenu in: aPresenter;
				            beMultipleSelection;
				            yourself ]).
			  (#removeElements -> [ 
			   aPresenter newButton
				   icon: (self iconNamed: #smallDelete);
				   help:
					   (aPresenter aPartTranslate: 'Remove selected form element') ]).
			  (#currentElement -> [ 
			   | part switchingPart |
			   switchingPart := (aPresenter aspectFor:
				                     #currentElementSwitchingPart) value.
			   part := (aPresenter aspectFor: #currentElement) value.
			   APartPresenter newOnPart: part owner: aPresenter ]).
			  (#removeSelectedLayouts -> [ 
			   aPresenter newButton
				   icon: (self iconNamed: #smallDelete);
				   help: (aPresenter aPartTranslate: 'Remove selected layout') ]).
			  (#currentLayout -> [ 
			   | part switchingPart |
			   switchingPart := (aPresenter aspectFor:
				                     #currentLayoutSwitchingPart) value.
			   part := (aPresenter aspectFor: #currentLayout) value.
			   APartPresenter newOnPart: part owner: aPresenter ]).
			  (#currentLayoutChild -> [ 
			   | part switchingPart |
			   switchingPart := (aPresenter aspectFor:
				                     #currentLayoutChildSwitchingPart) value.
			   part := (aPresenter aspectFor: #currentLayoutChild) value.
			   APartPresenter newOnPart: part owner: aPresenter ]).
			  (#layoutTree -> [ 
			   | aTree |
			   aTree := aPresenter newTreeTable
				            dynamicContextMenu: #layoutsContextMenu
				            in: aPresenter;
				            beMultipleSelection;
				            yourself ]).			
			  (#openPreview -> [ 
			   aPresenter newButton
				   label: 'Preview window';
				   help: (aPresenter aPartTranslate:
							    'Open a form preview in a standalone window') ]).

			  (#addLabel -> [ self addLabelButtonTo: aPresenter ]).
			  (#addButton -> [ self addButtonButtonTo: aPresenter ]).
			  (#addColorInput -> [ self addColorInputButtonTo: aPresenter ]).
			  (#addDropList -> [ self addDropListButtonTo: aPresenter ]).
			  (#addList -> [ self addListButtonTo: aPresenter ]).
			  (#addProgressBar -> [ self addPogressBarButtonTo: aPresenter ]).
			  (#addStatusBar -> [ self addStatusBarButtonTo: aPresenter ]).
			  (#addTextInput -> [ self addTextInputButtonTo: aPresenter ]).
			  (#addText -> [ self addTextButtonTo: aPresenter ]).
			  (#addTreeTable -> [ self addTreeTableButtonTo: aPresenter ]).
			  (#addCheckBox -> [ self addCheckBoxButtonTo: aPresenter ]).
			  (#addRadioButton -> [ self addRadioButtonButtonTo: aPresenter ]).
			  (#addNumberInput -> [ self addNumberInputButtonTo: aPresenter ]).

			  (#addLabelToTree -> [ self addLabelButtonTo: aPresenter ]).
			  (#addButtonToTree -> [ self addButtonButtonTo: aPresenter ]).
			  (#addColorInputToTree
			   -> [ self addColorInputButtonTo: aPresenter ]).
			  (#addDropListToTree -> [ self addDropListButtonTo: aPresenter ]).
			  (#addListToTree -> [ self addListButtonTo: aPresenter ]).
			  (#addProgressBarToTree
			   -> [ self addPogressBarButtonTo: aPresenter ]).
			  (#addStatusBarToTree -> [ self addStatusBarButtonTo: aPresenter ]).
			  (#addTextInputToTree -> [ self addTextInputButtonTo: aPresenter ]).
			  (#addTextToTree -> [ self addTextButtonTo: aPresenter ]).
			  (#addTreeTableToTree -> [ self addTreeTableButtonTo: aPresenter ]).
			  (#addCheckBoxToTree -> [ self addCheckBoxButtonTo: aPresenter ]).
			  (#addRadioButtonToTree
			   -> [ self addRadioButtonButtonTo: aPresenter ]).
			  (#addNumberInputToTree
			   -> [ self addNumberInputButtonTo: aPresenter ]).
			  (#addBoxLayout -> [ 
			   aPresenter newButton
				   icon: (aPresenter partInterface part iconNamed: 'tboxlayout');
				   help: (aPresenter aPartTranslate: 'Add a box layout') ]).
			  (#addGridLayout -> [ 
			   aPresenter newButton
				   icon: (aPresenter partInterface part iconNamed: 'tgridlayout');
				   help: (aPresenter aPartTranslate: 'Add a grid layout') ]).
			  (#addFrameLayout -> [ 
			   aPresenter newButton
				   icon: (aPresenter partInterface part iconNamed: 'tframelayout');
				   help: (aPresenter aPartTranslate: 'Add a frame') ]).
			  (#addScrollLayout -> [ 
			   aPresenter newButton
				   icon: (aPresenter partInterface part iconNamed: 'greenArrowUpAndDown');
				   help: (aPresenter aPartTranslate: 'Add a scroll layout') ]) }
]

{ #category : #specs }
ApedFormEditor class >> createButtonFor: aPresenter with: iconString and: helpText [

	^ aPresenter newButton
		  icon: (aPresenter partInterface part iconNamed: iconString );
		  help: (aPresenter aPartTranslateDynamic: helpText )
]

{ #category : #specs }
ApedFormEditor class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		  borderWidth: 10;
		  spacing: 10;
		  add: ((SpBoxLayout newHorizontal
				    borderWidth: 10;
				    spacing: 10;
				    add:
					    ((SpFrameLayout newLabel: 'Layouts') add:
							     (SpBoxLayout newHorizontal
								      borderWidth: 10;
								      spacing: 10;
								      add: (SpBoxLayout newVertical
										       borderWidth: 10;
										       add: (SpBoxLayout newVertical
												        spacing: 5;
												        add: (SpBoxLayout newHorizontal
														         spacing: 5;
														         add: (SpBoxLayout newVertical
																          add:
																	          ((SpFrameLayout newLabel: 'Layouts') add:
																			           (SpBoxLayout newVertical
																				            spacing: 5;
																				            add: (SpBoxLayout newHorizontal
																						             spacing: 5;
																						             add: #addBoxLayout expand: false;
																						             add: #addFrameLayout expand: false;
																						             yourself)
																				            withConstraints: [ :c | 
																					            c
																						            expand: false;
																						            fill: false ];
																				            add: (SpBoxLayout newHorizontal
																						             spacing: 5;
																						             add: #addGridLayout expand: false;
																										 add: #addScrollLayout expand: false;	
																						             yourself)
																				            withConstraints: [ :c | 
																					            c
																						            expand: false;
																						            fill: false ]
																					))
																          withConstraints: [ :c | 
																	          c
																		          expand: false;
																		          fill: false ];
																          add:
																	          ((SpFrameLayout newLabel: 'Presenter') 
																		           add: (SpBoxLayout newHorizontal
																				            spacing: 5;
																				            add: (SpBoxLayout newVertical
																						             spacing: 5;
																						             add: #addLabelToTree expand: false;
																						             add: #addButtonToTree
																						             expand: false;
																						             add: #addTextInputToTree
																						             expand: false;
																						             add: #addDropListToTree
																						             expand: false;
																						             add: #addCheckBoxToTree
																						             expand: false;
																						             add: #addRadioButtonToTree
																						             expand: false;
																						             add: #addColorInputToTree
																						             expand: false;
																						             yourself)
																				            withConstraints: [ :c | 
																					            c
																						            expand: false;
																						            fill: false ];
																				            add: (SpBoxLayout newVertical
																						             spacing: 5;
																						             add: #addNumberInputToTree
																						             expand: false;
																						             add: #addListToTree expand: false;
																						             add: #addTextToTree expand: false;
																						             add: #addTreeTableToTree
																						             expand: false;
																						             add: #addProgressBarToTree
																						             expand: false;
																						             add: #addStatusBarToTree
																						             expand: false;
																						             yourself)
																				            withConstraints: [ :c | 
																					            c
																						            expand: false;
																						            fill: false ]))
																          expand: true
																          fill: true
																          padding: 0;
																          add: (SpBoxLayout newHorizontal
																		           spacing: 5;
																		           add: #removeSelectedLayouts
																		           withConstraints: [ :c | 
																			           c
																				           expand: false;
																				           fill: false ];																			
																		           yourself)
																          withConstraints: [ :c | 
																	          c
																		          expand: false;
																		          fill: false ])
														         expand: false
														         fill: false
														         padding: 0;
														         add: #layoutTree width: 300)
												        expand: true
												        fill: true
												        padding: 0;
												        add: (SpBoxLayout newHorizontal
														         spacing: 5;
														         yourself)
												        expand: false
												        fill: false
												        padding: 0;
												        yourself));
								      add: (SpBoxLayout newVertical
										       borderWidth: 0;
										       spacing: 0;
										       add: #currentLayout width: 250;
										       add: #currentLayoutChild width: 250;
										       yourself))))
				   add:
					   ((SpFrameLayout newLabel: 'Presenters') add:
						    (SpBoxLayout newVertical
							     spacing: 5;
							     borderWidth: 10;
							     add: (SpBoxLayout newHorizontal
									      spacing: 5;
									      hAlignEnd;
									      add: #removeElements withConstraints: [ :c | 
										      c
											      expand: false;
											      fill: false ];
									      yourself)
							     withConstraints: [ :c | 
								     c
									     expand: false;
									     fill: false ];
							     add: (SpBoxLayout newHorizontal
									      spacing: 5;
									      add: #addLabel expand: false;
									      add: #addButton expand: false;
									      add: #addTextInput expand: false;
									      add: #addDropList expand: false;
									      add: #addCheckBox expand: false;
									      add: #addRadioButton expand: false;
									      yourself)
							     withConstraints: [ :c | 
								     c
									     expand: false;
									     fill: false ];
							     add: (SpBoxLayout newHorizontal
									      spacing: 5;
									      add: #addNumberInput expand: false;
									      add: #addList expand: false;
									      add: #addText expand: false;
									      add: #addTreeTable expand: false;
									      add: #addProgressBar expand: false;
									      add: #addStatusBar expand: false;
									      add: #addColorInput expand: false;
									      yourself)
							     withConstraints: [ :c | 
								     c
									     expand: false;
									     fill: false ];
							     add: #elementsList));
				   add: (SpBoxLayout newVertical
						    add: #currentElement;
						    yourself));		 
		  yourself
]

{ #category : #API }
ApedFormEditor class >> matchingPartClass [

	^ApedFormEditorPart
]

{ #category : #specs }
ApedFormEditor class >> openWithGtkDE [
	
	| presenter app part |

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.

	part := self matchingPartClasses first createWithClientRegistry.
	part locale: APartLocaleDeDE new.
	presenter := self openOnPart: part application: app.

	^ presenter
]

{ #category : #API }
ApedFormEditor >> createLayoutCanvas [
	| layoutCanvas |
	layoutCanvas := SpRoassalPresenterWithEditor
		on: self
		withCanvas: self partInterface part layoutCanvas.
	"contextMenuAspect := self partInterface description
		aspectFor: #contextMenu
		ifAbsent: [  ].
	contextMenuAspect
		ifNotNil: [ cm := self partInterface
				menuFor: contextMenuAspect value
				ifAbsent: [  ].
			cm
				ifNotNil: [ layoutCanvas
						contextMenu: [ cm value asSpecMenuIn: self application ] ] ].
	layoutCanvas
		whenPresenterResized: [ :newExtent | 
			self partInterface part
				visibleCanvasSizeComputer: [ newExtent ];
				notifyPresenterResized ]."
"	self
		whenBuiltDo: [ :aWidget | 
			self partInterface part
				visibleCanvasSizeComputer: [ layoutCanvas trachelCanvas extent ];
				updateAfterResizeCanvas ]."
	^ layoutCanvas
]

{ #category : #API }
ApedFormEditor >> currentElementSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| svClass subView newPart |

	newPart := (self aspectFor: #currentElement) value.
	
	svClass := ApedPresenterEditor allSubclasses detect: [ :each | each matchingPartClasses includes:  newPart class ].
		
	subView := svClass ifNotNil: [
		svClass asSubViewOn: self subInterface: aSwitchingInterface subInterface ].
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #currentElement
]

{ #category : #API }
ApedFormEditor >> currentLayoutChildSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| svClass subView newPart |

	newPart := (self aspectFor: #currentLayoutChild) value.
	
	svClass := ApedLayoutChildEditor withAllSubclasses detect: [ :each | each matchingPartClasses includes:  newPart class ].
			
	subView := svClass ifNotNil: [
		svClass asSubViewOn: self subInterface: aSwitchingInterface subInterface ].
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #currentLayoutChild
]

{ #category : #API }
ApedFormEditor >> currentLayoutSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| svClass subView newPart |

	newPart := (self aspectFor: #currentLayout) value.
	svClass:= (newPart class = ApedLayoutPart) 
		ifTrue:[ApedLayoutEditor]
		ifFalse:[
			ApedLayoutEditor allSubclasses detect: [ :each | each matchingPartClasses includes:  newPart class ].
		].	
	subView := svClass ifNotNil: [
		svClass asSubViewOn: self subInterface: aSwitchingInterface subInterface ].
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #currentLayout
]

{ #category : #API }
ApedFormEditor >> defaultLayout [ 

	^ self class defaultLayout
]

{ #category : #API }
ApedFormEditor >> initialExtent [ 

	^ 1424@800
]

{ #category : #API }
ApedFormEditor >> initializePresenters [

	super initializePresenters.
	layout := self defaultLayout. 
]

{ #category : #API }
ApedFormEditor >> initializeWindow: aWindowPresenter [

|layoutTree|
	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: (self aPartTranslate: 'Form editor').	
	self client onNotification: #changeWindowTitle do: [ :title | aWindowPresenter title: title ].
	aWindowPresenter whenClosedDo: [ self partInterface closePart ].
	aWindowPresenter bindKeyCombination: KeyboardKey F5 asKeyCombination toAction: [self partInterface part updatePreview].
	aWindowPresenter bindKeyCombination:	$s ctrl asKeyCombination toAction: [self partInterface part save].
	layoutTree := aWindowPresenter presenter presenters at: #layoutTree.
	layoutTree bindKeyCombination: Character arrowLeft alt asKeyCombination toAction: [self partInterface part movePresenterIntree: Character arrowLeft ].
	layoutTree bindKeyCombination: Character arrowRight alt asKeyCombination toAction: [self partInterface part movePresenterIntree: Character arrowRight ].
	layoutTree bindKeyCombination: Character arrowUp alt asKeyCombination toAction: [self partInterface part movePresenterIntree: Character arrowUp ].
	layoutTree bindKeyCombination: Character arrowDown alt asKeyCombination toAction: [self partInterface part movePresenterIntree: Character arrowDown ].
	aWindowPresenter bindKeyCombination:	$z ctrl asKeyCombination toAction: [self partInterface part undo].
	aWindowPresenter bindKeyCombination:	$y ctrl asKeyCombination toAction: [self partInterface part redo].
	aWindowPresenter menu: ((self presenterNamed: #mainMenu)
		addGroup: [ :group | 
			| aspect |
			aspect := self aspectFor: #mainMenu.
			self addItemsFromEnumerationValuePart: aspect value to: (self presenterNamed: #mainMenu) adaptor: aspect. ]).
]

{ #category : #API }
ApedFormEditor >> partSwitched: anAnnouncement from: aSwitchingInterface [

	anAnnouncement containerId = #currentElementSwitchingPart ifTrue: [
		^self currentElementSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].
	
	anAnnouncement containerId = #currentLayoutSwitchingPart ifTrue: [
		^self currentLayoutSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].

	anAnnouncement containerId = #currentLayoutChildSwitchingPart ifTrue: [
		^self currentLayoutChildSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].

	anAnnouncement containerId = #previewSwitchingPart ifTrue: [
		^self previewSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].

	anAnnouncement containerId = #windowedPreviewSwitchingPart ifTrue: [
		^self windowedPreviewSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].

]

{ #category : #API }
ApedFormEditor >> previewSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| subView newPart |

	newPart := (self aspectFor: #preview) value.
				
	subView := ApedFormPreview asSubViewOn: self subInterface: aSwitchingInterface subInterface.
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #preview
]

{ #category : #API }
ApedFormEditor >> windowedPreviewSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| subView newPart |

	newPart := (self aspectFor: #windowedPreview) value.
				
	subView := ApedFormPreview asSubViewOn: self subInterface: aSwitchingInterface subInterface.
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #preview
]
