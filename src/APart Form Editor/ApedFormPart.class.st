Class {
	#name : #ApedFormPart,
	#superclass : #APart,
	#instVars : [
		'elementsList',
		'rootLayout',
		'layoutTree',
		'elementAspectsEnumeration',
		'elementIDsEnumeration',
		'initializeElementIDs'
	],
	#category : #'APart Form Editor-Main'
}

{ #category : #visiting }
ApedFormPart >> accept: anApedVisitor [

	anApedVisitor visitForm: self
]

{ #category : #'initialize-release' }
ApedFormPart >> addElement: newElement [

	elementsList list add: newElement.

	^ newElement
]

{ #category : #'initialize-release' }
ApedFormPart >> addLayout: newLayout to: aLayout layoutChild: aLayoutChild [

	aLayout ifNotNil: [ 
		aLayout addChild: newLayout layoutChild: aLayoutChild ].

	self announce: (ApedAddLayoutAnnouncement new
		newLayout: newLayout;
		parentLayout: aLayout;
		layoutChild: aLayoutChild).

	^ newLayout
	"^ self privAddLayout: newLayout to: aLayout layoutChild: aLayoutChild"
]

{ #category : #'initialize-release' }
ApedFormPart >> addLayoutOf: layoutClass to: aLayout [

	| newLayout layoutToAddTo |
	
	aLayout ifNotNil: [ 
		layoutToAddTo := aLayout isNode 
			ifTrue: [aLayout parentLayout ] 
			ifFalse: [aLayout]].

	newLayout := self privAddLayoutOf: layoutClass to: layoutToAddTo.

	layoutToAddTo ifNil: [ rootLayout := newLayout ].

	layoutTree refresh.
	
	layoutTree selections: (Array with: newLayout).
		
	^ newLayout
]

{ #category : #accessing }
ApedFormPart >> canAddLayoutFor: aClass [

	layoutTree treeModel root children isEmpty ifTrue: [ 
		aClass canBeRoot ifFalse: [ ^ false ].
		^ true ].	
	layoutTree selections size > 1 ifTrue:[^ false].
	layoutTree selection ifNil: [ ^ false ].	
	layoutTree selection canAddChild ifFalse: [ ^ false ].

	^ true
]

{ #category : #accessing }
ApedFormPart >> canRemoveElement [

	elementsList list isEmpty ifTrue: [ 
		^ false ].
	
	elementsList selection ifNil: [ ^ false ].

	^ true
]

{ #category : #accessing }
ApedFormPart >> canRemoveLayout [ 

	layoutTree treeModel root children isEmpty ifTrue: [ 
		^ false ].
	
	layoutTree selection ifNil: [ ^ false ].

	^ true
]

{ #category : #accessing }
ApedFormPart >> confirmOverwrite: fileRef [ 

	(APConfirmationYesNo onPart: self)
				trigger: #confirmYes do: [ ^ true];
				trigger: #confirmNo do: [ ^ false ];
				title: 'Overwrite file';
				message: 'Overwrite file ', fileRef fullName asString, '?';
				openClientPrompt.
				
	^ false
]

{ #category : #'initialize-release' }
ApedFormPart >> defineAspects [

	partInterface description createAllAspectsNamed: #(elementsList layoutTree)

]

{ #category : #accessing }
ApedFormPart >> elementIDsEnumeration [

	^ elementIDsEnumeration ifNil: [ self initializeElementIDsEnumeration ]
]

{ #category : #serialization }
ApedFormPart >> elementWithID: anId [ 

	^ self elementsList list detect: [ :each | anId = each presenterId ] ifNone: [ nil ]
]

{ #category : #serialization }
ApedFormPart >> elements: aCollection [ 

	elementsList removeAll.
	aCollection do: [ :each | 
		| aPart |
		aPart := ApedPresenterPart onPart: self key: UUID new onJson: each.
		elementsList list add: aPart ]

]

{ #category : #'initialize-release' }
ApedFormPart >> elementsList [ 

	^ elementsList
]

{ #category : #serialization }
ApedFormPart >> elementsWithIDs: idList [ 

	|elements|
	elements := OrderedCollection new.
	idList do:[:ids | elements addAll: (self elementsList list select: [ :each | ids includes: each presenterId ])].
	^elements

]

{ #category : #'initialize-release' }
ApedFormPart >> formPart [ 

	^ self
]

{ #category : #'initialize-release' }
ApedFormPart >> iconNamed: aSymbol [
	
	^ self rootPart iconNamed: aSymbol
]

{ #category : #serialization }
ApedFormPart >> initOnJson: aJsonObj [
		
	self elements: ((aJsonObj at: #elements ifAbsent: [ self pdmError: #PdmInvalidJsonObject ])).

	self layoutTree: ((aJsonObj at: #layoutTree ifAbsent: [ self pdmError: #PdmInvalidJsonObject ])).

]

{ #category : #'initialize-release' }
ApedFormPart >> initializeElementIDsEnumeration [

	initializeElementIDs := APDynamicEnumeration  named: #elementIDs.
	
	initializeElementIDs associationsBlock: [ 
		self elementsList list withIndexCollect: [ :each :index | 'index', index asString -> each presenterId] ].
	
	^ initializeElementIDs
]

{ #category : #'initialize-release' }
ApedFormPart >> initializeValues [

	elementsList := (APartList) 
		onPart: self 
		key: #elementsList 
		preInit: [:p | p isMultiSelection: true].
	
	layoutTree := APartTree onPart: self key: #layoutTree preInit: [:p | p isMultiSelection: true].
	layoutTree 
		displayRoot: true;
		root: (ApedRootLayoutTreeNodeModel new);
		getChildrenBlock: [:each | each children].
]

{ #category : #testing }
ApedFormPart >> isFormPart [ 

	^ true
]

{ #category : #serialization }
ApedFormPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := { 
		#className -> self className.
		#elements -> elementsList list.
		#layoutTree -> rootLayout.
	} asOrderedCollection.
	
	^ assocs 
	
]

{ #category : #'initialize-release' }
ApedFormPart >> layoutTree [ 

	^ layoutTree
]

{ #category : #serialization }
ApedFormPart >> layoutTree: aJsonObject [

	layoutTree clear.

	aJsonObject 
		ifNotNil: [	
			| newLayout |
			newLayout := ApedLayoutPart createWithClientRegistry materializeLayoutFrom: aJsonObject andAddTo: nil parent: self.
			rootLayout := newLayout.		
			self setElementKeysForChildren: rootLayout children.					
			self addLayout: newLayout to: layoutTree selection layoutChild: newLayout layoutChild.
		 ]
		ifNil:[rootLayout := nil].
	layoutTree refresh.

]

{ #category : #accessing }
ApedFormPart >> layoutsDo: aBlock [ 

	| children aRoot |
	
	children := self layoutTree treeModel root children.
	
	children ifEmpty: [ ^ self ].
	
	aRoot := children first value.
	aRoot withChildrenDo: aBlock 
]

{ #category : #accessing }
ApedFormPart >> open [

	| jsonObject prompt file |
	
	prompt :=(APRequestNewFilenamePrompt onPart: self)
			title: 'Choose file'.
	prompt openClientPrompt.
	file := prompt value.
	file ifNil: [ ^ self ].
	
	file readStreamDo: [ :aStream |
		jsonObject := APJsonParser parseStream: aStream.
		self initOnJson: jsonObject ].
]

{ #category : #'initialize-release' }
ApedFormPart >> privAddLayout: newLayout to: aLayout [ 

	| newChildModel |
	
	newChildModel := (ApedLayoutTreeNodeModel new)
				value: newLayout; 			
				yourself.
				
	aLayout 
		ifNil: [ layoutTree root addChild: newChildModel ]
		ifNotNil: [ (layoutTree treeModel nodeModelFor: aLayout) addChild: newChildModel. 
			newChildModel parent opened: true].
		
	newLayout children do: [ :aChild | 
		self privAddLayout: aChild to: newLayout  ].
		
	^ newLayout
]

{ #category : #'initialize-release' }
ApedFormPart >> privAddLayout: newLayout to: aLayout layoutChild: aLayoutChild [

	| newChildModel |
	
	newChildModel := (ApedLayoutTreeNodeModel new)
				value: newLayout; 			
				yourself.
				
	aLayout 
		ifNil: [ layoutTree root addChild: newChildModel ]
		ifNotNil: [ (layoutTree treeModel nodeModelFor: aLayout) addChild: newChildModel. 
			newChildModel parent opened: true].
		
	newLayout children do: [ :aChild | 
		self privAddLayout: aChild to: newLayout ].
		
	^ newLayout
]

{ #category : #'initialize-release' }
ApedFormPart >> privAddLayoutOf: layoutClass to: aLayout [

	| newLayout aLayoutChild  |

	newLayout := layoutClass onPart: self key: UUID new.
	aLayoutChild := aLayout ifNil: [nil] ifNotNil: [aLayout layoutChildFor: newLayout].

	self addLayout: newLayout to: aLayout layoutChild: aLayoutChild.
	
	^ newLayout
]

{ #category : #accessing }
ApedFormPart >> privRemoveLayout: aLayout [

	| aLayoutModel parentLayout parentModel |
	
	aLayoutModel := layoutTree treeModel nodeModelFor: aLayout.
	
	aLayoutModel ifNil:[^self].
	
	parentModel := aLayoutModel parent.
	parentLayout := aLayout parentLayout.

	parentModel children remove: aLayoutModel.

	layoutTree refresh.
	layoutTree selectionIndex: {}.

]

{ #category : #accessing }
ApedFormPart >> removeElement: elm [

	elementsList removeAllSuchThat: [ :each | each = elm ].
	
	self layoutsDo: [ :each | each presenterRemoved: elm presenterId ]
]

{ #category : #accessing }
ApedFormPart >> removeLayouts: aLayoutCollection [

	| parentLayout lastElement oldSelectionIndex|
	
	oldSelectionIndex := layoutTree selectionIndexes last.
	
	aLayoutCollection do:[:layout|		
		self announce: (ApedRemoveLayoutAnnouncement new
			layout: layout).			
						
	parentLayout := layout parentLayout.
	parentLayout 
		ifNotNil: [parentLayout removeChild: layout].	
				
	layout = rootLayout 
		ifTrue: [ rootLayout := nil ]].

	parentLayout ifNotNil:[		
		parentLayout children size >= oldSelectionIndex last
			ifTrue: [self layoutTree selectionIndexes: {oldSelectionIndex}]
			ifFalse:[lastElement := parentLayout children ifNotEmpty:[:c| c last] ifEmpty:[parentLayout].
				   (self layoutTree includes: lastElement)
					ifTrue:[self layoutTree selection:lastElement]]].		
]

{ #category : #accessing }
ApedFormPart >> rootLayout [
	^ rootLayout
]

{ #category : #accessing }
ApedFormPart >> rootLayout: anObject [
	rootLayout := anObject
]

{ #category : #accessing }
ApedFormPart >> save [ 

	| prompt file |
	
	prompt :=(APRequestNewFilenamePrompt onPart: self)
			title: 'Choose file'.
	prompt openClientPrompt.
	file := prompt value.
	file ifNil: [ ^ self ].
	
	file ifExists: [ 
		(self confirmOverwrite: file) ifFalse: [ ^ self ] ].
	
	file ensureDelete.
	
	file writeStreamDo: [ :aStream |
		self printJsonOn: aStream ].
		
"	jsonObject := APJsonParser parse: json.

	self initOnJson: jsonObject"
]

{ #category : #serialization }
ApedFormPart >> setElementKeysForChildren: aChildCollection [

	| children element |
	children := aChildCollection copy.

	children do: [ :child | 
		child isNode
			ifTrue: [ 
				| aCollection |
				aCollection := self elementsList list select: [ :e | 
					            e presenterId value = child presenterId value ].
				element := aCollection ifEmpty: [ nil ] ifNotEmpty: [ aCollection anyOne ].
				element ifNotNil: [ child elementKey: element key ] ]
			ifFalse: [ self setElementKeysForChildren: child children  ] ]
]

{ #category : #'initialize-release' }
ApedFormPart >> uniqueElementNameWithPrefix: aPrefix [ 

	| index aName |
	
	index := 1.
	[ 
		aName := aPrefix, index asString.
		index := index + 1.
		elementsList list anySatisfy: [ :each | each aspect = aName ] ] whileTrue.
	
	^ aName
]

{ #category : #'initialize-release' }
ApedFormPart >> whenLayoutAdded: aBlock [ 

	self announcer announcer
		when: ApedAddLayoutAnnouncement
		do: aBlock
]

{ #category : #'initialize-release' }
ApedFormPart >> whenLayoutRemoved: aBlock [ 

	self announcer announcer
		when: ApedRemoveLayoutAnnouncement
		do: aBlock
]
