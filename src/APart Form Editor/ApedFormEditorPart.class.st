"
To open me, evaluate:

```language=Pharo
ApedFormEditor openWithGtk.
```
"
Class {
	#name : #ApedFormEditorPart,
	#superclass : #APart,
	#traits : 'APTRootPart + APTPartWithLocale',
	#classTraits : 'APTRootPart classTrait + APTPartWithLocale classTrait',
	#instVars : [
		'form',
		'elementType',
		'currentElement',
		'currentElementSwitchingPart',
		'currentLayoutSwitchingPart',
		'currentLayout',
		'currentLayoutChild',
		'currentLayoutChildSwitchingPart',
		'elementAspectsEnumeration',
		'previewSwitchingPart',
		'mainMenu',
		'elementsContextMenu',
		'layoutsContextMenu',
		'loadedFile',
		'emptyFormJsonString',
		'jsonForm',
		'changesStack',
		'changesIndex',
		'doNotUpdatePreview',
		'saveChanges',
		'windowedPreview'
	],
	#category : #'APart Form Editor-Main'
}

{ #category : #'initialize-release' }
ApedFormEditorPart >> addElementOf: elementClass [

	| uniqueName |
	
	uniqueName := self form uniqueElementNameWithPrefix: elementClass aspectPrefix.

	^ self addElementOf: elementClass named: uniqueName 
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> addElementOf: elementClass named: uniqueName [

	| newElement |
	
	newElement := elementClass onPart: currentElementSwitchingPart key: UUID new.

	newElement aspect: uniqueName.
	newElement presenterId: uniqueName.
	self form addElement: newElement.
	self elementsList selection: newElement.
	
	^ newElement
]

{ #category : #adding }
ApedFormEditorPart >> addLabelForPresenter [

	| selectedLayout label labelPrompt idPrompt labelName labelId labelLayoutPart selectionX layoutsInRow|
	
	selectedLayout := self layoutTree selections.
	
	selectedLayout size > 1 ifTrue:[^self].

	selectedLayout := selectedLayout any.

	labelPrompt :=(APTextPrompt onPart: self)
        title: 'Label Name';
        message: 'Enter name for label'.
    labelPrompt openClientPrompt.
    labelName := labelPrompt value.

	labelName ifNotNil:[

		labelLayoutPart := self addPresenterOf: ApedLabelPresenterPart to: selectedLayout parentLayout. 
	
		label := (self elementsList list select:[:element| element key = labelLayoutPart elementKey ]) any.

		label label: labelName
	]
	ifNil:[^self].
	
	idPrompt  :=(APTextPrompt onPart: self)
        title: 'Label Id';
        message: 'Enter id for label';
		  value: label presenterId .
    idPrompt openClientPrompt.
    labelId := idPrompt value.

	labelId isEmptyOrNil ifTrue: [labelId:= label presenterId].
	
	label presenterId: labelId.
	label aspect: labelId.
		
	selectionX := selectedLayout layoutChild x.
	
	labelLayoutPart layoutChild x: selectionX.
	
	layoutsInRow := selectedLayout parentLayout children select:[
		:layout| layout layoutChild y = selectedLayout layoutChild y and:[ layout layoutChild x >= selectedLayout layoutChild x] ].
	
	layoutsInRow do:[:layout| layout layoutChild x: (layout layoutChild x + 1) ].
	
	labelLayoutPart layoutChild x: (selectedLayout layoutChild x - 1).
	
	labelLayoutPart layoutChild y: selectedLayout layoutChild y.
	
	self switchCurrentElementToSelection.
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> addPresenterOf: aPresenterClass to: aLayout [

	^self addPresenterOf: aPresenterClass  to:  aLayout  presenter: nil.
	

]

{ #category : #'initialize-release' }
ApedFormEditorPart >> addPresenterOf: aPresenterClass to: aLayout presenter: aPresenter [

	| newLayout newElement layoutToAddTo|
	
	doNotUpdatePreview:= true.
	
	aPresenter ifNil:[
		newElement := self addElementOf: aPresenterClass]
	ifNotNil:[newElement := aPresenter].
	
	layoutToAddTo := aLayout.
	
	aLayout isNode ifTrue: [layoutToAddTo := aLayout parentLayout].	

	newLayout := self form addLayoutOf: ApedNodeLayoutPart to: layoutToAddTo.	

	newLayout presenterId value: newElement presenterId value.
	
	newLayout elementKey: newElement key.	
	
	self layoutTree selections: (Array with: newLayout).
			
	doNotUpdatePreview := false.
	
	self updatePreview.
	
	^ newLayout
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> addPresenters: aPresenterColl to: aLayout [

	aPresenterColl do:[:p| self addPresenterOf: p class to: aLayout presenter: p ].

]

{ #category : #adding }
ApedFormEditorPart >> addStateToChangesStack [

	|currentState|
	self changesIndex < self changesStack size
	ifTrue:[self changesStack removeLast: (changesStack size - changesIndex)].
	currentState := ApedFormSavedState new.
	currentState jsonForm: self form printJson;
					 selectedElementIndexes: self elementsList selectionIndexes;
					selectedLayoutIndexes: self layoutTree selectionIndexes.
	self changesStack add: currentState.
	self changesIndex: self changesStack size.
]

{ #category : #accessing }
ApedFormEditorPart >> allElementAspects [ 
	
	^ self elementsList list collect: [ :each | each aspect ].
	
]

{ #category : #accessing }
ApedFormEditorPart >> allElementIDs [ 
	
	^ self elementsList list collect: [ :each | each id ].
	
]

{ #category : #accessing }
ApedFormEditorPart >> canAddLayout [ 

	self layoutTree selections size > 1 ifTrue:[^ false].
	self layoutTree selection ifNil: [ ^ false ].
	
	self layoutTree selection canAddChild ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> canAddLayoutFor: aClass [

	self layoutTree treeModel root children isEmpty ifTrue: [ 
		aClass canBeRoot ifFalse: [ ^ false ].
		^ true ].
	^self canAddPresenter

]

{ #category : #accessing }
ApedFormEditorPart >> canAddPresenter [

	|layoutToAddTo selection|
	selection := self layoutTree selection.
	self layoutTree selections size > 1 ifTrue:[ ^ false].
	selection ifNil: [ ^ false ].	
	layoutToAddTo := selection isNode ifFalse:[selection]ifTrue:[selection parentLayout].
	layoutToAddTo canAddChild
			ifFalse: [^false].
	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> canInsertInTree [		

	self canPasteLayout ifFalse: [^false].
	self elementsList selection ifNil:[^false].
	^true
]

{ #category : #accessing }
ApedFormEditorPart >> canPasteElements [

	self clipboardContent ifNil:[^false].
			
	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> canPasteLayout [
	| currentSelection clipboardContent|		

	self layoutTree selections size > 1 ifTrue:[^ false].
	currentSelection := self layoutTree selection.
	
	clipboardContent := self clipboardContent.

	currentSelection ifNil:[
		self form rootLayout 
			ifNil:[ clipboardContent ifNotNil:[:cCon| (cCon layouts size = 1 and:[cCon layouts first class canBeRoot]) 
					ifTrue:[^true]
					ifFalse:[^false]]
				ifNil: [^false]]
			ifNotNil:[^false]		
	].	
	clipboardContent ifNotNil:[:cCon| cCon layouts size <= currentSelection maximalChildrenCount ifFalse:[^ false]].
				
	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> canRemoveElement [

	self elementsList list isEmpty ifTrue: [ 
		^ false ].
	
	self elementsList selection ifNil: [ ^ false ].

	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> canRemoveLayout [ 

	self layoutTree treeModel root children isEmpty ifTrue: [ 
		^ false ].
	
	self layoutTree selection ifNil: [ ^ false ].

	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> changesIndex [

	^ changesIndex ifNil:[self changesStack size].
]

{ #category : #accessing }
ApedFormEditorPart >> changesIndex: anObject [

	changesIndex := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> changesStack [

	^ changesStack
]

{ #category : #accessing }
ApedFormEditorPart >> changesStack: anObject [

	changesStack := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> clipboardContent [

	| input jsonObject aClassName clipboardContent | 
	
	input := Clipboard clipboardText.
	
	jsonObject := [ APJsonParser parse: input readStream handleSyntaxError: [:error| ^nil ] ] on: Error do: [ nil ].
	jsonObject ifNil: [^nil].
	jsonObject isJsonObject ifFalse: [
		"avoid simple JSON primitive objects like string and numbers"
		^ nil ].
	
	aClassName := jsonObject at: #className ifAbsent: [ ^ nil ].
	aClassName = #ApedClipboardContentPart ifFalse: [ ^ nil ].
	
	self removeSubPartForKey: #clipboardContent.
	clipboardContent := ApedClipboardContentPart onPart: self key: #clipboardContent.
	clipboardContent elementIDsEnumeration: self form elementIDsEnumeration.

	clipboardContent initOnJson: jsonObject.		
	^ clipboardContent 
]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> collectLayoutsForDeletedPresenters: presentersToDelete from: aChildCollection [
	
	|children layoutCollection|	
	children := aChildCollection copy.
	layoutCollection := OrderedCollection new.
	
	children
		do: [:child| child isNode 
			ifTrue:[ (presentersToDelete anySatisfy:[:p| p presenterId value = child presenterId value ])
				ifTrue: [layoutCollection add:child.]
				] 
			ifFalse:[ layoutCollection addAll: (self collectLayoutsForDeletedPresenters: presentersToDelete from: child children) ].
		].
	^layoutCollection
]

{ #category : #accessing }
ApedFormEditorPart >> confirmDiscardChanges: fileName [ 

	(APConfirmationYesNo onPart: self)
				trigger: #confirmYes do: [ ^ true];
				trigger: #confirmNo do: [ ^ false ];
				title: 'Discard changes';
				message: 'There are some unsaved changes in: "', fileName , '" Would you like to discard them?';
				openClientPrompt.				
	^ false
]

{ #category : #accessing }
ApedFormEditorPart >> confirmOverwrite: fileRef [ 

	(APConfirmationYesNo onPart: self)
				trigger: #confirmYes do: [ ^ true];
				trigger: #confirmNo do: [ ^ false ];
				title: 'Overwrite file';
				message: 'Overwrite file ', fileRef fullName asString, '?';
				openClientPrompt.
				
	^ false
]

{ #category : #accessing }
ApedFormEditorPart >> copyElements [

	| clipboardContent |
	
	self removeSubPartForKey: #clipboardContent.
	clipboardContent := ApedClipboardContentPart onPart: self key: #clipboardContent.
	clipboardContent elementIDsEnumeration: self form elementIDsEnumeration.
	
	clipboardContent elements: self elementsList selections .

	Clipboard clipboardText: clipboardContent printJson
]

{ #category : #accessing }
ApedFormEditorPart >> copyLayouts [

	| clipboardContent |
	
	self removeSubPartForKey: #clipboardContent.
	clipboardContent := ApedClipboardContentPart onPart: self key: #clipboardContent.
	clipboardContent elementIDsEnumeration: self form elementIDsEnumeration.
	
	clipboardContent layouts: self layoutTree selections.
	clipboardContent elements: (self form elementsWithIDs: (self layoutTree selections collect:[:sel| sel allElementIDs])).

	Clipboard clipboardText: clipboardContent printJson.
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> createWindowPreview [ 

	windowedPreview := ApedFormPreviewWindowPart onPart: self key: #windowedPreview.
	windowedPreview formPart: self.
	
]

{ #category : #accessing }
ApedFormEditorPart >> currentElement [
	^ currentElement
]

{ #category : #accessing }
ApedFormEditorPart >> currentElement: anObject [
	currentElement := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> currentElementSwitchingPart [
	^ currentElementSwitchingPart
]

{ #category : #accessing }
ApedFormEditorPart >> currentElementSwitchingPart: anObject [
	currentElementSwitchingPart := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayout [
	^ currentLayout
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayout: anObject [
	currentLayout := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayoutChild [
	^ currentLayoutChild
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayoutChild: anObject [
	currentLayoutChild := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayoutChildSwitchingPart [
	^ currentLayoutChildSwitchingPart
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayoutSwitchingPart [
	^ currentLayoutSwitchingPart
]

{ #category : #accessing }
ApedFormEditorPart >> currentLayoutSwitchingPart: anObject [
	currentLayoutSwitchingPart := anObject
]

{ #category : #accessing }
ApedFormEditorPart >> cutElements [

 self copyElements.
 self removeElements.
]

{ #category : #accessing }
ApedFormEditorPart >> cutLayouts [

 self copyLayouts.
 self removeSelectedLayouts.
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> decreasePositionOf: aPresenter [

	| oldPosition presentersInLayout |
	presentersInLayout := aPresenter parentLayout children.
	oldPosition := presentersInLayout indexOf: aPresenter.
	oldPosition > 1 ifTrue:[
		presentersInLayout swap: oldPosition with: oldPosition - 1]
   

	
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> defineAspects [

	partInterface description createAspectNamed: #form.
	partInterface description createAspectNamed: #elementsList redirectTo: #(form elementsList).
	partInterface description createAspectNamed: #layoutTree redirectTo:  #(form layoutTree).
		
	partInterface description createAspectNamed: #currentElement.
	partInterface description createAspectNamed: #currentElementSwitchingPart.
	
	partInterface description createAspectNamed: #currentLayout.
	partInterface description createAspectNamed: #currentLayoutSwitchingPart.
	partInterface description createAspectNamed: #currentLayoutChild.
	partInterface description createAspectNamed: #currentLayoutChildSwitchingPart.

	partInterface description createAspectNamed: #preview.
	partInterface description createAspectNamed: #windowedPreview.

	partInterface description createAspectNamed: #mainMenu.

]

{ #category : #accessing }
ApedFormEditorPart >> elementIDsEnumeration [

	^ form elementIDsEnumeration
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> elementTypesEnumeration [

	| enum |
	
	enum := APEnumeration named: #elementTypes.
	enum textFromKeyBlock: [:k | (self class environment at: k) label ].
	enum iconFromKeyBlock: [ :k | self iconNamed: (self class environment at: k) iconName ].
	
	(ApedWidgetPresenterPart allSubclasses reject: [ :each | each isAbstract ]) do: [ :each | 
		enum addEntry: (APEnumEntry on: enum key: each name value: each  ) ].
	
	^enum
]

{ #category : #accessing }
ApedFormEditorPart >> elementsList [ 

	^ self form elementsList
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> emptyCurrentElement [

	self removeSubPartForKey: #currentElement.
	currentElement := ApedNullPresenterPart
		                  onPart: self
		                  key: #currentElement.
	currentElementSwitchingPart forceSwitchToPart: currentElement.

]

{ #category : #'initialize-release' }
ApedFormEditorPart >> emptyCurrentLayout [

	self removeSubPartForKey: #currentLayout.
	currentLayout := ApedLayoutPart 
		                  onPart: self
		                  key: #currentLayout.
	currentLayoutSwitchingPart forceSwitchToPart: currentLayout.
	
	self removeSubPartForKey: #currentLayoutChild.
	currentLayoutChild := ApedLayoutChildPart 
		                  onPart: self
		                  key: #currentLayoutChild.
	currentLayoutChildSwitchingPart forceSwitchToPart: currentLayoutChild.

]

{ #category : #'initialize-release' }
ApedFormEditorPart >> fileFilterForAll [
	^ GtkFileFilter newFileFilter setName: 'All files' ; addPattern: '*.*' ; addMimeType: ''
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> fileFilterForJson [ 

	^ GtkFileFilter newFileFilter setName: 'JSON File (*.json)' ; addPattern: '*.json' ; addMimeType: 'application/json'
]

{ #category : #accessing }
ApedFormEditorPart >> form [ 

	^ form
]

{ #category : #accessing }
ApedFormEditorPart >> formPart [

	^ self
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> getIconForLayout: aLayoutPart [

	| layoutClass |
	layoutClass := aLayoutPart isNode 
		ifTrue:[
			(aLayoutPart presenterId value isNotNil and:[self elementsList list isNotEmpty])
			ifTrue:[
		 		(self elementsList list select:[:emt| emt key = aLayoutPart elementKey ]) first]	
			ifFalse:[aLayoutPart]]
		ifFalse:[aLayoutPart].
			^layoutClass class iconName	
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> hasActivePreviewWindow [

	windowedPreview ifNil: [ ^ false ].
	windowedPreview partInterface ifNil: [ ^ false ].
	
	^ true
]

{ #category : #accessing }
ApedFormEditorPart >> hasUnsavedChanges [
	
	^self loadedFile
			ifNotNil:[self form printJson ~= self loadedFile asFileReference readStream contents] 
			ifNil:[self form printJson ~= emptyFormJsonString]
			

]

{ #category : #'initialize-release' }
ApedFormEditorPart >> iconNamed: aSymbol [

	| repository |
	
	( 'icons' asFileReference / 'icons-form' / (aSymbol, '.png') ) ifExists: [ :fileRef |
		^ Form fromFileNamed: fileRef  ].
	
	self repositoryPathOrNil ifNotNil: [ :aPath |
	( aPath / 'icons' asFileReference / 'icons-form' / (aSymbol, '.png') ) ifExists: [ :fileRef |
		^ Form fromFileNamed: fileRef  ] ].
	
	^ repository 
		ifNotNil: [ repository location ].
	
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> increasePositionOf: aPresenter [

	| oldPosition presentersInLayout |
	presentersInLayout := aPresenter parentLayout children.
	oldPosition := presentersInLayout indexOf: aPresenter.
	oldPosition < presentersInLayout size ifTrue:[
		presentersInLayout swap: oldPosition with: oldPosition + 1].

	
]

{ #category : #initialization }
ApedFormEditorPart >> initializeActions [ 

	| addLayoutCondition removeLayoutCondition  removeElementCondition |
	
	addLayoutCondition := APCondition on: [self canAddLayout] ifNot: #layoutTypeNotSelected.
	removeLayoutCondition := APCondition on: [self canRemoveLayout] ifNot: #layoutTypeNotSelected.
	removeElementCondition := APCondition on: [self canRemoveElement] ifNot: #elementNotSelected.

	partInterface description
		createAction: #removeElements
		do: [ self removeElements ]
		if: removeElementCondition.
								
	partInterface description
		createAction: #removeSelectedLayouts
		do: [ self removeSelectedLayouts ]
		if: removeLayoutCondition.
						
	partInterface description
		createAction: #updatePreview
		do: [ self updatePreview ]
		if: (APCondition true).
		
	partInterface description
		createAction: #openPreview
		do: [ self openPreview ]
		if: (APCondition true).
		
	partInterface description
		createAction: #save
		do: [ self save ]
		if: (APCondition true).
		
	partInterface description
		createAction: #saveAs
		do: [ self saveAs ]
		if: (APCondition true).
		
	partInterface description
		createAction: #open
		do: [ self open ]
		if: (APCondition true).
	
	self initializeAddElementActions.
	self initializeAddLayoutActions.
		
	self initializeElementsContextMenuActions.
	self initializeElementsContextMenu.

	self initializeLayoutsContextMenuActions.
	self initializeLayoutsContextMenu.


]

{ #category : #initialization }
ApedFormEditorPart >> initializeAddElementActions [ 
		
	partInterface description createAction: #addButton do: [ 
			self addElementOf: ApedButtonPresenterPart ] if: (APCondition true).
	partInterface description createAction: #addLabel do: [ 
			self addElementOf: ApedLabelPresenterPart ] if: (APCondition true).
	partInterface description createAction: #addColorInput do: [ 
			self addElementOf: ApedColorInputPresenterPart ] if: (APCondition true).
	partInterface description createAction: #addDropList do: [ 
			self addElementOf: ApedDropListPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addList do: [ 
			self addElementOf: ApedListPresenterPart ] if: (APCondition true).
	partInterface description createAction: #addProgressBar do: [ 
			self addElementOf: ApedProgressBarPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addStatusBar do: [ 
			self addElementOf: ApedStatusBarPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addTextInput do: [ 
			self addElementOf: ApedTextInputFieldPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addText do: [ 
			self addElementOf: ApedTextPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addTreeTable do: [ 
			self addElementOf: ApedTreeTablePresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addCheckBox do: [ 
			self addElementOf: ApedCheckBoxPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addRadioButton do: [ 
			self addElementOf: ApedRadioButtonPresenterPart  ] if: (APCondition true).
	partInterface description createAction: #addNumberInput do: [ 
			self addElementOf: ApedNumberInputFieldPresenterPart ] if: (APCondition true).
]

{ #category : #initialization }
ApedFormEditorPart >> initializeAddLayoutActions [ 
		
	partInterface description createAction: #addBoxLayout do: [ 
			self form addLayoutOf: ApedBoxLayoutPart to: self layoutTree selection ] if: (APCondition on: [self canAddLayoutFor: ApedBoxLayoutPart ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addFrameLayout do: [ 
			self form addLayoutOf: ApedFrameLayoutPart to: self layoutTree selection] if: (APCondition on: [self canAddLayoutFor: ApedFrameLayoutPart ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addGridLayout do: [ 
			self form addLayoutOf: ApedGridLayoutPart to: self layoutTree selection] if: (APCondition on: [self canAddLayoutFor: ApedGridLayoutPart ] ifNot: #layoutTypeNotSelected).	
	partInterface description createAction: #addScrollLayout do: [ 
			self form addLayoutOf: ApedScrollLayoutPart to: self layoutTree selection] if: (APCondition on: [self canAddLayoutFor: ApedScrollLayoutPart ] ifNot: #layoutTypeNotSelected).	
	partInterface description createAction: #addLabelToTree do: [ 
			self addPresenterOf: ApedLabelPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addButtonToTree do: [ 
			self addPresenterOf: ApedButtonPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addTextInputToTree do: [ 
			self addPresenterOf: ApedTextInputFieldPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addDropListToTree do: [ 
			self addPresenterOf: ApedDropListPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).				
	partInterface description createAction: #addCheckBoxToTree do: [ 
			self addPresenterOf: ApedCheckBoxPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addRadioButtonToTree do: [ 
			self addPresenterOf: ApedRadioButtonPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addNumberInputToTree do: [ 
			self addPresenterOf: ApedNumberInputFieldPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addListToTree do: [ 
			self addPresenterOf: ApedListPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).						
	partInterface description createAction: #addTextToTree do: [ 
			self addPresenterOf: ApedTextPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addTreeTableToTree do: [ 
			self addPresenterOf: ApedTreeTablePresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addProgressBarToTree do: [ 
			self addPresenterOf: ApedProgressBarPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).
	partInterface description createAction: #addStatusBarToTree do: [ 
			self addPresenterOf: ApedStatusBarPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).			
	partInterface description createAction: #addColorInputToTree do: [ 
			self addPresenterOf: ApedColorInputPresenterPart to: self layoutTree selection ] if: (APCondition on: [self canAddPresenter ] ifNot: #layoutTypeNotSelected).										
								

]

{ #category : #initialization }
ApedFormEditorPart >> initializeElementsContextMenu [

	elementsContextMenu := APMenu new.
	elementsContextMenu addItem: ((APMenuItem labeled: 'Copy')
		value: (self description actionAt: #elementsContextMenuCopy ifAbsent: []);
		yourself
		).
		
	elementsContextMenu addItem: ((APMenuItem labeled: 'Cut')
		value: (self description actionAt: #elementsContextMenuCut ifAbsent: []);
		yourself
		).
		
	elementsContextMenu addItem: ((APMenuItem labeled: 'Delete')
		value: (self description actionAt: #elementsContextMenuDelete ifAbsent: []);
		yourself
		).

	elementsContextMenu addItem: ((APMenuItem labeled: 'Paste')
		value: (self description actionAt: #elementsContextMenuPaste ifAbsent: []);
		yourself
		).
		
	elementsContextMenu addItem: ((APMenuItem labeled: 'Insert in tree')
		value: (self description actionAt: #elementsContextMenuInsertInTree ifAbsent: []);
		yourself
		).
	
	partInterface createMenuForKey: #elementsContextMenu use: elementsContextMenu.
	
	^ elementsContextMenu
	
]

{ #category : #initialization }
ApedFormEditorPart >> initializeElementsContextMenuActions [

	partInterface description
		createAction: #elementsContextMenuCopy
		do: [ self copyElements ]
		if: (APCondition on: [ self elementsList selection notNil ] ifNot: #nothingSelected)
		helpText: ''.	
			
	partInterface description
		createAction: #elementsContextMenuCut
		do: [ self cutElements ]
		if: (APCondition on: [ self elementsList selection notNil ] ifNot: #nothingSelected)
		helpText: ''.	
			
	partInterface description
		createAction: #elementsContextMenuDelete
		do: [ self removeElements ]
		if: (APCondition on: [ self elementsList selection notNil ] ifNot: #nothingSelected)
		helpText: ''.							
		
	partInterface description
		createAction: #elementsContextMenuPaste
		do: [ self pasteToElements ]
		if: (APCondition on: [ self canPasteElements ] ifNot: #nothingSelected)
		helpText: ''.	
		
		partInterface description
		createAction: #elementsContextMenuInsertInTree
		do: [ self addPresenters: self elementsList selections to: self layoutTree selection]
		if: (APCondition on: [ self canInsertInTree ] ifNot: #nothingSelected)
		helpText: ''.	
]

{ #category : #initialization }
ApedFormEditorPart >> initializeLayoutsContextMenu [

	layoutsContextMenu := APMenu new.
	layoutsContextMenu addItem: ((APMenuItem labeled: 'Copy')
		value: (self description actionAt: #layoutsContextMenuCopy ifAbsent: []);
		yourself
		).
		
	layoutsContextMenu addItem: ((APMenuItem labeled: 'Cut')
		value: (self description actionAt: #layoutsContextMenuCut ifAbsent: []);
		yourself
		).
		
	layoutsContextMenu addItem: ((APMenuItem labeled: 'Delete')
		value: (self description actionAt: #layoutsContextMenuDelete ifAbsent: []);
		yourself
		).

	layoutsContextMenu addItem: ((APMenuItem labeled: 'Paste (Reuse)')
		value: (self description actionAt: #layoutsContextMenuPasteReuse ifAbsent: []);
		yourself
		).
		
	layoutsContextMenu addItem: ((APMenuItem labeled: 'Paste (Copy)')
		value: (self description actionAt: #layoutsContextMenuPasteCopy ifAbsent: []);
		yourself
		).
		
	layoutsContextMenu addItem: ((APMenuItem labeled: 'AddLabelToPresenter')
		value: (self description actionAt: #layoutsContextMenuAddLabel ifAbsent: []);
		yourself
		).
	
	partInterface createMenuForKey: #layoutsContextMenu use: layoutsContextMenu.
	
	^ layoutsContextMenu
	
]

{ #category : #initialization }
ApedFormEditorPart >> initializeLayoutsContextMenuActions [

	partInterface description
		createAction: #layoutsContextMenuCopy
		do: [ self copyLayouts ]
		if: (APCondition on: [ self layoutTree selection notNil ] ifNot: #nothingSelected)
		helpText: ''.	
			
	partInterface description
		createAction: #layoutsContextMenuCut
		do: [ self cutLayouts ]
		if: (APCondition on: [ self layoutTree selection notNil ] ifNot: #nothingSelected)
		helpText: ''.
		
	partInterface description
		createAction: #layoutsContextMenuDelete
		do: [ self removeSelectedLayouts ]
		if: (APCondition on: [ self layoutTree selection notNil ] ifNot: #nothingSelected)
		helpText: ''.	
		
	partInterface description
		createAction: #layoutsContextMenuPasteReuse
		do: [ self pasteToLayouts: #layoutsContextMenuPasteReuse ]
		if: (APCondition on: [self canPasteLayout ] ifNot: #nothingSelected)
		helpText: ''.	
		
	partInterface description
		createAction: #layoutsContextMenuPasteCopy
		do: [ self pasteToLayouts: #layoutsContextMenuPasteCopy ]
		if: (APCondition on: [self canPasteLayout] ifNot: #nothingSelected)
		helpText: 'test'.	
		
	partInterface description
		createAction: #layoutsContextMenuAddLabel
		do: [ self addLabelForPresenter ]
		if: (APCondition on: [self isSelectionGridLayoutChild] ifNot: #nothingSelected)
		helpText: ''.	
]

{ #category : #initialization }
ApedFormEditorPart >> initializeMainMenu [

	| enum fileEnum editEnum previewEnum |
	self aPartRegisterTranslation: 'aped-mainMenu-file'.
	self aPartRegisterTranslation: 'aped-file-open'.
	self aPartRegisterTranslation: 'aped-file-save'.
	self aPartRegisterTranslation: 'aped-mainMenu-edit'.

	enum := APEnumeration named: #ActionEnumeration.
	enum textFromKeyBlock: [ :k | 
		APartDeferredTranslation for: k in: 'APart' ].
	enum actionFromKeyBlock: [ :k | k ].
	"enum iconFromKeyBlock: [:k| self iconNamed:k]."

	fileEnum := APEnumeration named: #ActionMenuEnumeration.
	fileEnum textFromKeyBlock: [ :k | 
		APartDeferredTranslation for: k in: 'APart' ].
	fileEnum addEntry:
		((APEnumEntry on: enum key: #'aped-file-open' asSymbol) action:
			 #open).
	fileEnum addEntry:
		((APEnumEntry on: enum key: #'aped-file-save' asSymbol) action:
			 #save).
	fileEnum addEntry:
		((APEnumEntry on: enum key: #'aped-file-saveAs' asSymbol) action:
			 #saveAs).

	editEnum := APEnumeration named: #EditMenuEnumeration.
	editEnum textFromKeyBlock: [ :k | 
		APartDeferredTranslation for: k in: 'APart' ].
	editEnum actionFromKeyBlock: [ :k | k ].
	editEnum addEntry: (APEnumEntry on: enum key: #copyLayouts asSymbol).
	editEnum addEntry:
		(APEnumEntry on: enum key: #pasteToLayouts asSymbol).

	previewEnum := APEnumeration named: #PreviewMenuEnumeration.
	fileEnum textFromKeyBlock: [ :k | 
		APartDeferredTranslation for: k in: 'APart' ].
	previewEnum actionFromKeyBlock: [ :k | k ].
	previewEnum addEntry: (APEnumEntry on: enum key: #updatePreview asSymbol).
	previewEnum addEntry: (APEnumEntry on: enum key: #openPreview asSymbol).

	APEnumEntrySubEnumeration
		addUnder: enum
		key: #'aped-mainMenu-file'
		subEnumeration: fileEnum.

	APEnumEntrySubEnumeration
		addUnder: enum
		key: #'aped-mainMenu-edit'
		subEnumeration: editEnum.
		
	APEnumEntrySubEnumeration
		addUnder: enum
		key: #'aped-mainMenu-preview'
		subEnumeration: previewEnum.

	mainMenu := APMenuFromEnumerationPart onPart: self key: #mainMenu.
	mainMenu enumeration: enum.

	partInterface createMenuForKey: #mainMenu
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> initializeValues [

	form := ApedFormPart onPart: self key: #form.

	currentElement := ApedNullPresenterPart onPart: self key: #currentElement.
	currentLayout := ApedLayoutPart onPart: self key: #currentLayout.
	currentLayoutChild := ApedLayoutPart onPart: self key: #currentLayoutChild.
	
	self elementsList
		itemIconRepresentationBlock: [:item | self iconNamed: item class iconName ];
		itemStringRepresentationBlock: [:item | item listLabel ];
		trigger: #selectionChanged
			do: [ self switchCurrentElementToSelection ].
	
	currentElementSwitchingPart := APSwitchingPart onPart: self key: #currentElementSwitchingPart.
	currentElementSwitchingPart releaseInactivePart: false.
	currentElementSwitchingPart addSubPart: currentElement  key: #current.
	currentElementSwitchingPart privCurrentPartKey: #current.
	
	currentLayoutSwitchingPart := APSwitchingPart onPart: self key: #currentLayoutSwitchingPart.
	currentLayoutSwitchingPart releaseInactivePart: false.
	currentLayoutSwitchingPart addSubPart: currentLayout  key: #current.
	currentLayoutSwitchingPart privCurrentPartKey: #current.

	currentLayoutChildSwitchingPart := APSwitchingPart onPart: self key: #currentLayoutChildSwitchingPart.
	currentLayoutChildSwitchingPart releaseInactivePart: false.
	currentLayoutChildSwitchingPart addSubPart: currentLayout  key: #current.
	currentLayoutChildSwitchingPart privCurrentPartKey: #current.

	self layoutTree 
		itemStringRepresentationBlock: [:each | each value labelString];
		itemIconRepresentationBlock: [:item ||icon| 
			icon := self getIconForLayout: item value.	
			self iconNamed: icon];
		trigger: #selectionChanged
			do: [ self switchCurrentLayoutToSelection ].
		
	self initializeMainMenu.
	
	self form whenLayoutAdded: [ :announcement |
		form privAddLayout: announcement newLayout to: announcement parentLayout
		].
	
	self form whenLayoutRemoved: [ :announcement |
		form privRemoveLayout: announcement layout.
		 ].			
					
	emptyFormJsonString := self form printJson.
	
	changesStack := OrderedCollection new.
	doNotUpdatePreview := false.
	saveChanges := true.
	self addStateToChangesStack

]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> isSelectionGridLayoutChild [

	self layoutTree selection ifNil:[^false].
	self layoutTree selections size = 1 ifFalse: [^false].	
 	(self layoutTree selection parentLayout isKindOf: ApedGridLayoutPart ) ifFalse: [^false].

	^true
]

{ #category : #accessing }
ApedFormEditorPart >> layoutTree [ 

	^ self form layoutTree
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> layoutTypesEnumeration [

	| enum |
	
	enum := APEnumeration named: #layoutTypes.
	"enum textFromKeyBlock: [:k | (self class environment at: k) label ]."
	enum iconFromKeyBlock: [ :k | self iconNamed: (self class environment at: k) iconName ].
"	enum actionFromKeyBlock: [:k | k]."
	
	ApedLayoutPart subclasses do: [ :each | 
		enum addEntry: (APEnumEntry on: enum key: each name value: each  ) ].
	
	^enum
]

{ #category : #accessing }
ApedFormEditorPart >> layoutsDo: aBlock [ 

	| children aRoot |
	
	children := self layoutTree treeModel root children.
	
	children ifEmpty: [ ^ self ].
	
	aRoot := children first value.
	aRoot withChildrenDo: aBlock 
]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> loadState: aState [

		saveChanges := false.	
		self form initOnJson: (APJsonParser parse: aState jsonForm).	
		saveChanges := false.	
	   self updatePreview.
		self layoutTree selectionIndexes: aState selectedLayoutIndexes.		
		self elementsList selectionIndexes: aState selectedElementIndexes.				
		self elementsList list isEmpty ifTrue:[self emptyCurrentElement].
		self layoutTree root children isEmpty ifTrue:[self emptyCurrentLayout].
]

{ #category : #accessing }
ApedFormEditorPart >> loadedFile [
	^ loadedFile
]

{ #category : #accessing }
ApedFormEditorPart >> loadedFile: aFileString [
	loadedFile := aFileString.
	self sendNotification: #changeWindowTitle with: aFileString.

]

{ #category : #'initialize-release' }
ApedFormEditorPart >> mainMenu [ 

	^ mainMenu
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> movePresenterDown: aPresenter [

	| oldPosition |
	oldPosition := aPresenter layoutChild position.	
	oldPosition y < aPresenter parentLayout children size ifTrue: [aPresenter layoutChild y: oldPosition y + 1].

]

{ #category : #'initialize-release' }
ApedFormEditorPart >> movePresenterIntree: aCharacter [

	|selection|
	self form layoutTree selections size > 1 ifTrue:[^self].
	selection := self form layoutTree selection.

	((selection parentLayout isKindOf: ApedFrameLayoutPart) or:[selection parentLayout isKindOf: ApedScrollLayoutPart ] ) ifTrue:[^self].	
	(selection parentLayout isKindOf: ApedBoxLayoutPart ) 
	ifTrue:[
		(aCharacter = Character arrowRight or:[aCharacter = Character arrowDown])
		ifTrue:[ self increasePositionOf: selection]
		ifFalse:[ self decreasePositionOf: selection]].	
	
		(selection parentLayout isKindOf: ApedGridLayoutPart) 
		ifTrue:[
			aCharacter = Character arrowLeft ifTrue:[	
				self movePresenterLeft: selection].
			aCharacter = Character arrowRight ifTrue:[	
				self movePresenterRight: selection].
			aCharacter = Character arrowUp ifTrue:[	
				self movePresenterUp: selection].
			aCharacter = Character arrowDown ifTrue:[	
				self movePresenterDown: selection]].
	self switchCurrentLayoutToSelection.

	
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> movePresenterLeft: aPresenter [

	| oldPosition |
	oldPosition := aPresenter layoutChild position.
	oldPosition x > 1 ifTrue: [aPresenter layoutChild x: oldPosition x - 1].

	
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> movePresenterRight: aPresenter [

	| oldPosition |
	oldPosition := aPresenter layoutChild position.
	oldPosition x < aPresenter parentLayout children size ifTrue: [aPresenter layoutChild x: oldPosition x + 1].

	
	
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> movePresenterUp: aPresenter [

	| oldPosition |
	oldPosition := aPresenter layoutChild position.
	oldPosition y > 1 ifTrue: [aPresenter layoutChild y: oldPosition y - 1].

	
]

{ #category : #accessing }
ApedFormEditorPart >> open [

	| jsonObject file currentFilename |
	
	self hasUnsavedChanges 		
		ifTrue:[ 
			currentFilename := self loadedFile ifNil:['newForm']ifNotNil:[self loadedFile]. 			
			(self confirmDiscardChanges: currentFilename) ifFalse: [^self] ].
	
	file := self openWindowsOpenFileDialog.
	file ifNil: [ ^ self ].
	
	file readStreamDo: [ :aStream |
		jsonObject := APJsonParser parseStream: aStream.
	self form initOnJson: jsonObject ].
	self emptyCurrentElement.
	self emptyCurrentLayout.
	self loadedFile: file pathString.
	self updatePreview.
]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> openGtkFileChooser [
	
	| prompt|
	prompt :=(APRequestExistingFilenamePrompt onPart: self)
			title: (self pdmTranslateDeferred: 'Choose file') string;
			addFilter: self fileFilterForJson;
			addFilter: self fileFilterForAll.
	prompt openClientPrompt.
	^ prompt value.
	

]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> openGtkFileChooserForSaving [

	| prompt |
	
	prompt :=(APRequestNewFilenamePrompt onPart: self)
			title: (self pdmTranslateDeferred: 'Save file') string;
			addFilter: self fileFilterForJson;
			addFilter: self fileFilterForAll.
			prompt suggestedFilename: 
				(self loadedFile ifNil:['newForm.json']).
	prompt openClientPrompt.
	^ prompt value.
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> openPreview [ 
	
	self hasActivePreviewWindow ifTrue: [ ^ self ].
	
	self createWindowPreview.
	windowedPreview openClient.
	windowedPreview updatePreview.
	

	

	

]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> openWindowsOpenFileDialog [

	|fileDialog|
	 fileDialog := WindowsOpenFileDialog new 		 
		  filter: 'JSON File (*.json)|*.json|All files (*.*)|*.*';
		  filterIndex: 1;
		  showDialog.
	^ fileDialog fileName ifNotNil: [:fileName| fileName asFileReference]
]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> openWindowsSaveFileDialog [

	|fileDialog|
	 fileDialog := WindowsSaveFileDialog new	 
		  filter: 'JSON File (*.json)|*.json|All files (*.*)|*.*';
		  filterIndex: 1.		
	self loadedFile ifNotNil: [: lf| fileDialog fileName: lf asFileReference basename; 
		initialDirectory: lf asFileReference parent fullName].			
	fileDialog showDialog.
	^ fileDialog fileName ifNotNil: [:fileName| fileName asFileReference]
]

{ #category : #accessing }
ApedFormEditorPart >> pasteToElements [ 

	| input jsonObject aClassName clipboardContent | 
	
	input := Clipboard clipboardText.
	
	jsonObject := APJsonParser parse: input readStream handleSyntaxError: [:error| error signal].

	aClassName := jsonObject at: #className ifAbsent: [ ^ self ].
	aClassName = #ApedClipboardContentPart ifFalse: [ ^ self ].
	
	self removeSubPartForKey: #clipboardContent.
	clipboardContent := ApedClipboardContentPart onPart: self key: #clipboardContent.
	clipboardContent initOnJson: jsonObject.
	
	clipboardContent elements do: [ :newElement ||uniqueName| 
		uniqueName := self form uniqueElementNameWithPrefix: newElement class aspectPrefix.
		newElement aspect: uniqueName. 
		self form addElement: newElement ].

	clipboardContent elements ifNotEmpty: [ 
		self elementsList selection: clipboardContent elements first ].
]

{ #category : #accessing }
ApedFormEditorPart >> pasteToLayouts [

	| input jsonObject aClassName elementClass newLayout  jsonChildren| 
	
	input := Clipboard clipboardText.
	
	jsonObject := APJsonParser parse: input readStream handleSyntaxError: [:error | ].

	aClassName := jsonObject at: #className ifAbsent: [ ^ self ].
	elementClass := self class environment at: aClassName asSymbol ifAbsent: [ ^ self ].
	(elementClass inheritsFrom: ApedLayoutPart) ifFalse: [ ^ self ].
	jsonChildren := (jsonObject at: #children ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]). 
	
	newLayout := elementClass onPart: currentElementSwitchingPart key: UUID new.
	newLayout initOnJson: jsonObject.
		
	newLayout addChild: newLayout layoutChild: nil.
	
	jsonChildren do: [ :aChild |
		newLayout materializeLayoutFrom: aChild andAddTo: newLayout ].
	
	self form layoutTree refresh.
	self form layoutTree selection: newLayout.
	
	^ newLayout
]

{ #category : #accessing }
ApedFormEditorPart >> pasteToLayouts: layoutAction [

	| clipboardContent newLayoutName idDic selection | 
	
	clipboardContent := self clipboardContent.		
			
	clipboardContent ifNil:[^self].
	
	selection := self form layoutTree selection.
		
	selection ifNotNil:[:sel| sel maximalChildrenCount < clipboardContent layouts size ifTrue:[^self]].
			
	idDic := Dictionary new.
			
	layoutAction = #layoutsContextMenuPasteCopy
		ifTrue:[ clipboardContent elements do: [:newElement |
			newLayoutName := self form uniqueElementNameWithPrefix: newElement class aspectPrefix.
			idDic at: newElement aspect put: newLayoutName.
			newElement aspect: newLayoutName. 
			self form addElement: newElement ]].
	layoutAction = #layoutsContextMenuPasteReuse
		ifTrue:[
			clipboardContent elements do:[:celmt|
				(self form elementsList list anySatisfy: [:e| e presenterId value = celmt presenterId value])
				ifFalse:[ self form addElement: celmt]]].
	
	self setNewPresenterIdsFrom: idDic to: clipboardContent layouts. 
	
		clipboardContent layouts do:[:layout| |layoutChild element|				
						layoutChild := selection ifNotNil:[(selection layoutChildFor: layout)]ifNil:[nil].
						layout isNode ifTrue:[
							element := (self form elementsList list select:[:e| e presenterId value = layout presenterId value ]) any.
							element ifNotNil: [layout elementKey: element key]]
							ifFalse:[self setKeysOfChildNodes: layout children].										
						self form addLayout: layout to: selection layoutChild: layoutChild.	
		 ].				
	self form layoutTree refresh.	
	
	clipboardContent layouts ifNotEmpty: [
		self form layoutTree selection: clipboardContent layouts last].
	
self updatePreview.
]

{ #category : #accessing }
ApedFormEditorPart >> previewSwitchingPart [
	^ previewSwitchingPart
]

{ #category : #accessing }
ApedFormEditorPart >> previewSwitchingPart: anObject [
	previewSwitchingPart := anObject
]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> redo [

	|nextState|
		changesIndex < changesStack size ifTrue:[
			nextState := self changesStack at: changesIndex + 1.
			self loadState: nextState.	
			self changesIndex: (self changesStack indexOf: nextState).]
]

{ #category : #accessing }
ApedFormEditorPart >> removeElements [

	| elements layouts oldSelectionIndex |
	elements := self elementsList selections.		
			
	doNotUpdatePreview := true.	
		
	self form rootLayout ifNotNil: [
		layouts := self collectLayoutsForDeletedPresenters: elements from: self form rootLayout children.
		self removeLayouts: layouts ].

	oldSelectionIndex := self elementsList selectionIndexes last.

	elements do:[:elm| self form removeElement: elm].	
	self selectNextElementOf: oldSelectionIndex.

	doNotUpdatePreview := false.
	self updatePreview 
]

{ #category : #accessing }
ApedFormEditorPart >> removeLayouts: aLayoutCollection [

	self form removeLayouts: aLayoutCollection.
	
]

{ #category : #accessing }
ApedFormEditorPart >> removeSelectedLayouts [

	| aLayoutCollection |
	
	aLayoutCollection := self layoutTree selections.
	
	self form removeLayouts: aLayoutCollection.
	self form rootLayout ifNil:[self emptyCurrentLayout].
	self updatePreview.
	

]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> renameChildNodes: aChildCollection whereKey: aKey to: newName [
	
	|children|	
	children := aChildCollection copy.
	
	children
		do: [:child| child isNode 
			ifTrue:[ ( child elementKey = aKey)
				ifTrue: [child presenterId value: newName]
				] 
			ifFalse:[self renameChildNodes: child children whereKey: aKey to: newName].
		]
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> repositoryPathOrNil [ 

	| repository |

	repository := (IceRepository registry
		detect: [ :e | e name = 'APart' ] ifNone: [ ^ nil ]). 
		
	repository location ifExists: [ ^ repository location ].
	
	^ nil
]

{ #category : #accessing }
ApedFormEditorPart >> save [ 
	 	
	loadedFile ifNil:[^self saveAs].
	loadedFile asFileReference ifExists: [ 
		loadedFile asFileReference ensureDelete.	
		loadedFile asFileReference writeStreamDo: [ :aStream |
			self form printJsonOn: aStream ]].
		
]

{ #category : #accessing }
ApedFormEditorPart >> saveAs [ 

	| file |	

	file := self openWindowsSaveFileDialog.
	file ifNil: [ ^ self ].
		
	file ensureDelete.
	
	file writeStreamDo: [ :aStream |
		self form printJsonOn: aStream ].
	self loadedFile: file pathString.		
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> selectElementForLayout: selectedPart [

	| anElement |
	selectedPart isNode ifFalse: [ ^ self ].

	"no presenter ID selected"
	selectedPart presenterId value ifNil: [ ^ self ].

	anElement := self elementsList list
		             detect: [ :each | 
		             each presenterId = selectedPart presenterId value ]
		             ifNone: [ nil ].
	anElement ifNotNil: [ 
		self elementsList selection: anElement ]
]

{ #category : #'as yet unclassified' }
ApedFormEditorPart >> selectNextElementOf: oldIndex [

	|newIndex|
	newIndex:= oldIndex.
	
	(self elementsList list isNotEmpty ) 
		ifTrue: [ 
			oldIndex <= self elementsList list size 			
				ifFalse:[newIndex := newIndex -1].	
			self elementsList selectionIndex: newIndex ]
		ifFalse:[ self emptyCurrentElement ].

]

{ #category : #initialization }
ApedFormEditorPart >> setKeysOfChildNodes: aChildCollection [
	
	|children element|	
	children := aChildCollection copy.
	
	children do:[:child|
		child isNode ifTrue:[
			element := (self form elementsList list select:[:e| e presenterId value = child presenterId value ]) any.
							element ifNotNil: [child elementKey: element key]]						
						ifFalse: [self setKeysOfChildNodes: child children]]		
]

{ #category : #initialization }
ApedFormEditorPart >> setNewPresenterIdsFrom: anIdDictionary to: layouts [

	 layouts do: [ :newLayout |
		newLayout isNode 
			ifTrue:[
				anIdDictionary 
					ifNotEmpty: [newLayout presenterId value: (anIdDictionary at: newLayout presenterId value)] 
					ifEmpty:[newLayout presenterId value: newLayout presenterId value]]
			ifFalse:[ self setNewPresenterIdsFrom: anIdDictionary to: newLayout children].
				
			].


]

{ #category : #'initialize-release' }
ApedFormEditorPart >> switchCurrentElementTo: selectedPart [

	currentElement := selectedPart.
	currentElement memento: selectedPart copy.

	currentElementSwitchingPart forceSwitchToPart: currentElement
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> switchCurrentElementToSelection [

	| selectedPart | 
	
	selectedPart := self elementsList selection.
	
	selectedPart ifNil: [ ^ self ].

	self switchCurrentElementTo: selectedPart.
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> switchCurrentLayoutChildTo: aLayoutChild [
	
	currentLayoutChild := aLayoutChild.
	currentLayoutChild memento: aLayoutChild copy.
	
	currentLayoutChildSwitchingPart forceSwitchToPart: currentLayoutChild
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> switchCurrentLayoutToSelection [

	| selectedPart | 
	
	selectedPart := self layoutTree selection.
	
	selectedPart ifNil: [ ^ self ].
	
	currentLayout := selectedPart.
	currentLayout memento: selectedPart copy.
	
	currentLayoutSwitchingPart forceSwitchToPart: currentLayout.
	
	self switchCurrentLayoutChildTo: currentLayout layoutChild.
	
	self selectElementForLayout: selectedPart
]

{ #category : #'menu messages' }
ApedFormEditorPart >> undo [ 

	|previousState|
	changesIndex > 1 ifTrue:[
		previousState := self changesStack at: changesIndex - 1.	
		self loadState: previousState.	
		self changesIndex: (self changesStack indexOf: previousState).]
]

{ #category : #'initialize-release' }
ApedFormEditorPart >> updatePreview [ 

	(self form printJson = jsonForm) ifFalse:[
		doNotUpdatePreview ifFalse:[				
			self hasActivePreviewWindow ifTrue: [ 
				windowedPreview updatePreview ].
			jsonForm := self form printJson.
			saveChanges ifTrue:[				
				self addStateToChangesStack].
			 ]].
	saveChanges := true
]

{ #category : #accessing }
ApedFormEditorPart >> windowedPreview [ 

	^ windowedPreview
]
