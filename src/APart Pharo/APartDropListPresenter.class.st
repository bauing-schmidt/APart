Class {
	#name : #APartDropListPresenter,
	#superclass : #SpDropListPresenter,
	#traits : 'TAPartPresenter',
	#classTraits : 'TAPartPresenter classTrait',
	#instVars : [
		'choicesSymbol'
	],
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartDropListPresenter >> choicesSymbol [
	^ choicesSymbol
]

{ #category : #accessing }
APartDropListPresenter >> choicesSymbol: anObject [
	choicesSymbol := anObject
]

{ #category : #accessing }
APartDropListPresenter >> defaultModel [
	self notYetImplemented
]

{ #category : #initialization }
APartDropListPresenter >> selectItemByItemModel: aModel [
	
	| realItem |
	
	aModel ifNil: [ self selection unselectAll. ^self ].
	
	realItem := model collection detect: [ :each | each model = aModel ] ifNone: [ ^ self ].
	self selection selectItem: realItem.
	"I execute the block associated with the item"
	realItem value.	
]

{ #category : #initialization }
APartDropListPresenter >> setValueAdaptor: aspectObject aspect: anAspect parent: parentPresenter interface: toPart [

	| selectionObject choices aValueAdaptor |
	
	aValueAdaptor := aspectObject subAdaptor.

	self assert: self id notNil.

	selectionObject := (parentPresenter bindingsManager 
		source: parentPresenter;
		listAt: self id) subAdaptor.

	(selectionObject isKindOf: APListSelection)
		ifTrue: [ 	
			self setupForContentAdaptor: selectionObject listHolder.
			self setupForSelectionIndexAdaptor: selectionObject selectionIndexHolder ]
		ifFalse: [ 	
			selectionObject := (parentPresenter bindingsManager 
				source: parentPresenter;
				listAt: self aspectSymbol) subAdaptor.
	
			choices := (parentPresenter bindingsManager 
				source: parentPresenter;
				listAt: self choicesSymbol).
			choices ifNotNil: [ 
				self setupForChoicesAdaptor: choices selection: selectionObject.
				self setupForSelectionIndexAdaptor2: selectionObject .]]

]

{ #category : #initialization }
APartDropListPresenter >> setupForChoicesAdaptor: contentAdaptor selection: selectionAdaptor [
	
	| content dropListItems listAdapter |
	
	content := contentAdaptor value.
	
	"this is probably very wrong"
"	listAdapter := contentAdaptor subject partInterface aspectFor: #listHolder ifAbsent: [ nil ].
	listAdapter ifNil: [ ^self ].
"
	"initial update"

	dropListItems := content value 
		ifNil: [ OrderedCollection new ]
		ifNotNil: [ 	
			content value collect: [ :each | 
				SpDropListItem new 
					model: each; 
					action: []; 
"					label: (self iconBlock cull: each); "
					yourself ] ].
	model collection: dropListItems.

	"make me dependen directly on the List collection. When it will be changed, the message
	#update:with: will be invoked"

	"listAdapter value addDependent: self."

	contentAdaptor addDependent: (APartUpdateConverter on: [:aspect | 
		"the list itself was changed, we need to set it as the new value and 
		make a new dependency subscription to the List"
		| list |
		list := contentAdaptor value.
		self updateList.
		list addDependent: self ]).

]

{ #category : #initialization }
APartDropListPresenter >> setupForContentAdaptor: contentAdaptor [
	
	| content dropListItems |
	
	content := contentAdaptor value.

	"initial update"
	dropListItems := content collect: [ :each | 
		SpDropListItem new model: each; action: []; yourself ].
	model collection: dropListItems.

	"make me dependen directly on the List collection. When it will be changed, the message
	#update:with: will be invoked"
	contentAdaptor value addDependent: self.
		
	contentAdaptor addDependent: (APartUpdateConverter on: [:aspect | 
		"the list itself was changed, we need to set it as the new value and 
		make a new dependency subscription to the List"
		| list |
		list := contentAdaptor value.
		self updateList.
		list addDependent: self ]).


		 
]

{ #category : #initialization }
APartDropListPresenter >> setupForSelectionIndexAdaptor2: selectionIndexAdaptor [
	self
		whenSelectionChangedDo: [ :newSelection | 
			self ignoreUpdates
				ifFalse: [ newSelection selectedIndex > 0
						ifTrue: [ selectionIndexAdaptor
								value: (model at: newSelection selectedIndex) model ]
						ifFalse: [ selectionIndexAdaptor value: nil ] ] ].
	selectionIndexAdaptor
		addDependent:
			(APartUpdateConverter
				on: [ :aspect | self selectItemByItemModel: selectionIndexAdaptor value ]).

	"initial update"
	self selectItem: selectionIndexAdaptor value
]

{ #category : #initialization }
APartDropListPresenter >> setupForSelectionIndexAdaptor: selectionIndexAdaptor [
	selectionIndexAdaptor
		ifNotNil: [ selectionIndexAdaptor aspect = #selectionIndex
				ifTrue: [ self
						whenSelectionChangedDo: [ :newSelection | 
							self ignoreUpdates
								ifFalse: [ selectionIndexAdaptor setValue: newSelection selectedIndex ] ].
					selectionIndexAdaptor
						addDependent:
							(APartUpdateConverter
								on: [ :aspect | self selectIndex: selectionIndexAdaptor value ]).

					"initial update"
					self selectIndex: selectionIndexAdaptor value ] ]
]

{ #category : #initialization }
APartDropListPresenter >> update: anAspect with: anObject [

	anAspect == #at: ifTrue: [ self updateList ].
	anAspect == #add ifTrue: [ self updateList ].
	anAspect == #insert: ifTrue: [ self updateList ].
	anAspect == #replace: ifTrue: [ self updateList ].
	anAspect == #remove: ifTrue: [ self updateList ].
	anAspect == #removeFrom:to: ifTrue: [ self updateList ].
	anAspect == #insertCollection: ifTrue: [ self updateList ].
	anAspect == #appendCollection: ifTrue: [ self updateList ].

]

{ #category : #initialization }
APartDropListPresenter >> updateList [

	| selectionInList dropListItems aListHolder |
self ignoreUpdatesWhile: [ 
	selectionInList := (self owner aspectFor: self id) value.
	(selectionInList isKindOf: APListSelection) 
		ifTrue: [ 
			aListHolder := selectionInList listHolder.
			dropListItems := aListHolder value collect: [ :each | 
				SpDropListItem new model: each; action: []; yourself ].
			selection unselectAll.
			model collection: dropListItems ]
		ifFalse: [ 
			| choices |

		"			contentAdaptor value logCr.
		contentAdaptor identityHash logCr."
		
			choices := (self owner bindingsManager 
				source: self owner;
				listAt: self choicesSymbol).
			dropListItems := choices value collect: [ :each | 
				SpDropListItem new model: each; action: []; yourself ].
			"dropListItems := selectionInList value collect: [ :each | 
				DropListItem new model: each; action: []; yourself ]."
			model collection: dropListItems value 
			 ] ]
]
