Extension { #name : #APxMenuHierarchyFromEnumPragmaExample }

{ #category : #'*APart Examples-Pharo' }
APxMenuHierarchyFromEnumPragmaExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#menu -> [ | mainMenu |
			mainMenu := SpMenuBarPresenter new.
			"mainMenu applyTo: aPresenter" ].
		#actionMenu -> [ APartMenuButtonPresenter owner: aPresenter ].
		#actionText -> [ aPresenter newTextInput ].
		#peripheralActionText -> [ aPresenter newTextInput ].
		
		#label1 -> [ aPresenter newLabel label: 'Menu-Action-Button' ].
		#label2 -> [ aPresenter newLabel label: 'Menu-Action' ].
		#label3 -> [ aPresenter newLabel label: 'Menu-Peripherals' ].
	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxMenuHierarchyFromEnumPragmaExample class >> defaultSpec [
	<spec>
	
	^ SpGridLayout new
		add: #label1 at: 1@1;
		add: #actionMenu at: 2@1;
		add: #label2 at: 1@2;
		add: #actionText at: 2@2;
		add: #label3 at: 1@3;
		add: #peripheralActionText at: 2@3.
]

{ #category : #'*APart Examples-Pharo' }
APxMenuHierarchyFromEnumPragmaExample >> initializeWindow: aWindow [

	| items |

	super initializeWindow: aWindow.
	
	 items := #(actionMenu peripheralMenu) collect: [ :aspectName |
		| aspect aMenu item |
		aspect := self aspectFor: aspectName.
		aMenu := self subMenuForEnumerationValueAdaptor: aspect.
		item := SpMenuItemPresenter new.
		item name: aspectName;
			subMenu: aMenu. ]. 

	aWindow menu: ((self presenterNamed: #menu)
		addGroup: [ :group | 
			items do: [ :each | group addMenuItem: each ].
			group addItem: [ :item | 
				item name: 'All'.
				item subMenu: (SpMenuPresenter new addGroup: [ :allGroup |
					items do: [ :each | allGroup addMenuItem: each ] ])]]).
]
