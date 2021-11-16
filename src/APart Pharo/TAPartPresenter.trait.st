Trait {
	#name : #TAPartPresenter,
	#instVars : [
		'aspectSymbol',
		'id',
		'ignoreUpdates',
		'model',
		'enablementHelp',
		'storedHelp',
		'bindingsManager'
	],
	#category : #'APart Pharo'
}

{ #category : #menu }
TAPartPresenter >> addItemsFromEnumerationValuePart: enumerationValuePart to: aMenu adaptor: aValueAdaptor [

	| apEnum menuItems |
	
	enumerationValuePart updateEnumeration.
	apEnum := enumerationValuePart enumeration.
	menuItems := apEnum isRecursive
		ifTrue: [ self createMenuItemsForEnumeration: apEnum under: enumerationValuePart adaptor: aValueAdaptor ]
		ifFalse: [ self createMenuItemsForTagNode: apEnum tagsTreeRoot use: enumerationValuePart adaptor: aValueAdaptor ].
	aMenu addGroup: [ :group |
		menuItems do: [:item |
			group addMenuItem: item ]]
]

{ #category : #accessing }
TAPartPresenter >> aspectSymbol [
	^ aspectSymbol
]

{ #category : #accessing }
TAPartPresenter >> aspectSymbol: anObject [
	aspectSymbol := anObject
]

{ #category : #accessing }
TAPartPresenter >> bindingsManager [

	^ bindingsManager ifNil: [ bindingsManager := APartBindingsManager new. ]
]

{ #category : #menu }
TAPartPresenter >> createMenuItemsForEnumeration: apEnum under: menuPart adaptor: aValueAdaptor [

	| items item submenu  |
	items := OrderedCollection new.
	apEnum keysAndValuesDo: [:k :enumEntry |
			item := SpMenuItemPresenter new.
			item name: ((apEnum textForKey: k) localizedForPresenter: self).
			"item iconName: [apEnum iconForKey: k]."
			item enabled: [apEnum isActiveAt: k].
			enumEntry isEnumeration
				ifTrue:  [ 
					submenu := SpMenuPresenter new.
					submenu addGroup: [ :group | 
						(self createMenuItemsForEnumeration: enumEntry subEnumeration
							under: menuPart adaptor: aValueAdaptor) do: [:subitem | group addMenuItem: subitem]].
					item subMenu: submenu]
				ifFalse: [
					(apEnum actionForKey: k)
						ifNotNil: [:action | item action: (self valueBlockForActionObject: action interface: menuPart targetInterface)]
						ifNil: [ item action: [menuPart value: k from: apEnum ]].
					"item indication: [apEnum isIndicatedOnAt: k]"].
			items add: item].
	^items
]

{ #category : #menu }
TAPartPresenter >> createMenuItemsForTagNode: enumTagNode use: menuPart adaptor: aValueAdaptor [

	| items item submenu |
	items := OrderedCollection new.
	enumTagNode childrenNodes do: 
			[:tagNode | 
			item := SpMenuItemPresenter new.
			item name: ((menuPart enumeration textFromKeyBlock
								ifNotNil: [:block | block value: tagNode tag]
								ifNil: [tagNode tag]) localizedForPresenter: self).
			submenu := SpMenuPresenter new.
			item subMenu: submenu.
			submenu addGroup: [ :group | 
			(self createMenuItemsForTagNode: tagNode use: menuPart adaptor: aValueAdaptor)
				do: [:resItem | group addMenuItem: resItem] ].
			items add: item].
	enumTagNode childrenKeys do: 
			[:k | 
			| anIcon | 
			item := SpMenuItemPresenter new.
			item name: ((menuPart enumeration textFromKeyBlock
								ifNotNil: [:block | block value: k]
								ifNil: [k]) localizedForPresenter: self).
			"((APartDeferredTranslation for: (menuPart enumerationTextForKey: k) in: 'Documaps') localizedForPresenter: self).
			"(menuPart enumerationActionForKey: k)
				ifNotNil: [:action | item action: (self valueBlockForActionObject: action interface: menuPart targetInterface"partInterface")]
				ifNil: 
					[(menuPart enumerationValueForKey: k)
						ifNotNil: 
							[:v | 
							item
								action: [ menuPart value: (menuPart enumeration valueForKey: k) from: menuPart enumeration ]]
						ifNil: [self aPartError: #wrongEnumerationValue text: 'Menu from Enumeration needs either action or value']].
			item enabled: [
				| actionKey anAction  |
				actionKey := (menuPart enumerationActionForKey: k).
				(actionKey isKindOf: APRedirectedAction)
					ifTrue: [ 
						actionKey isExecutable]
					ifFalse: [  
						anAction := nil.
						actionKey ifNotNil: [ 
							anAction := (menuPart targetInterface description actionAt: actionKey ifAbsent: [ nil ]).
						anAction 
							ifNotNil: [ 
								anAction updateCondition.
								(menuPart enumerationIsActiveAtKey: k) and: [ anAction isExecutable ]]
							ifNil: [ 
								menuPart enumerationIsActiveAtKey: k ] ] ].
				"menuPart enumerationIsActiveAtKey: k"].
			"item indication: [menuPart enumerationIsIndicatedOnAtKey: k].
			item labelImage: [menuPart enumerationIconForKey: k]."
			
			anIcon := menuPart enumeration iconFromKeyBlock ifNotNil: [:block | block value: k].
			anIcon ifNotNil: [
				item icon: anIcon ].
			items add: item ].
	^items
	
]

{ #category : #accessing }
TAPartPresenter >> dynamicContextMenu: menuName in: aPresenter [

	"sets a context menu that is rebuilt for every displaying"
	
	| aContextMenu |
	
	aContextMenu := aPresenter menuFor: menuName.
	self contextMenu: [(aContextMenu value asSpecMenuIn: self application) ].
	
]

{ #category : #help }
TAPartPresenter >> enablementHelp [
	^ enablementHelp
]

{ #category : #help }
TAPartPresenter >> enablementHelp: anObject [
	enablementHelp := anObject.
	self updateHelp
]

{ #category : #accessing }
TAPartPresenter >> getBindingIn: aBuilder [

	^ aBuilder aspectAt: self model
]

{ #category : #help }
TAPartPresenter >> help [ 

	^ self privHelp
]

{ #category : #help }
TAPartPresenter >> help: aString [ 

	storedHelp := aString.
	self updateHelp
]

{ #category : #accessing }
TAPartPresenter >> id [
	^ id ifNil: [ self aspectSymbol ]
]

{ #category : #accessing }
TAPartPresenter >> id: anObject [
	id := anObject
]

{ #category : #accessing }
TAPartPresenter >> ignoreUpdates [

	^ ignoreUpdates ifNil: [ ignoreUpdates := false ]
]

{ #category : #accessing }
TAPartPresenter >> ignoreUpdatesWhile: aBlock [

	ignoreUpdates := true.
	aBlock ensure: [ ignoreUpdates := false ].
]

{ #category : #accessing }
TAPartPresenter >> isAPartPresenter [

	^ true
]

{ #category : #accessing }
TAPartPresenter >> model [
	^ model ifNil: [ ^ self aspectSymbol ]
]

{ #category : #accessing }
TAPartPresenter >> model: anObject [
	model := anObject
]

{ #category : #accessing }
TAPartPresenter >> modelInBuilder: aBuilder [

	| result |
	model ifNil: [^ self defaultModel].
	result := model isSymbol
				ifTrue: [self getBindingIn: aBuilder ]
				ifFalse: [ model].
	^result
]

{ #category : #help }
TAPartPresenter >> storedHelp [
	^ storedHelp
]

{ #category : #help }
TAPartPresenter >> storedHelp: anObject [
	storedHelp := anObject.
	
	self updateHelp
]

{ #category : #menu }
TAPartPresenter >> subMenuForEnumerationValueAdaptor: aValueAdaptor [ 

	| aMenu |
	
	aMenu := SpMenuPresenter new.
	self addItemsFromEnumerationValuePart: aValueAdaptor value to: aMenu adaptor: aValueAdaptor.
	^ aMenu

]

{ #category : #accessing }
TAPartPresenter >> suggestAspectSymbol: aSymbol [

	"set the aspect symbol in case that no custom one is set already"
	
	aspectSymbol ifNil: [ aspectSymbol := aSymbol ]
]

{ #category : #help }
TAPartPresenter >> updateHelp [

	(self storedHelp isNil and: [ self enablementHelp isNil ]) ifTrue: [ 
		^ self privHelp: nil ].
	
	self enablementHelp ifNil: [ 
		^ self privHelp: (self storedHelp localizedForPresenter: self) ].

	self storedHelp ifNil: [ 
		^ self privHelp: (self enablementHelp localizedForPresenter: self) ].

	self privHelp: ((self storedHelp localizedForPresenter: self), ' - ', (self enablementHelp localizedForPresenter: self))
]

{ #category : #menu }
TAPartPresenter >> valueBlockForActionObject: action interface: aPartInterface [

	action isSymbol ifTrue: [^[aPartInterface execute: action ifDisabled: []]].
	action class = Association
		ifTrue: 
			[^ [aPartInterface
				execute: action key
				with: action value
				ifDisabled: []]].
	action class = APRedirectedAction
		ifTrue: 
			[ ^ [action executeWith: #()]].
	^action
]
