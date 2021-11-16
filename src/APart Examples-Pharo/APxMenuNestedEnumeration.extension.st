Extension { #name : #APxMenuNestedEnumeration }

{ #category : #'*APart Examples-Pharo' }
APxMenuNestedEnumeration class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#menu -> [ | mainMenu |
			mainMenu := SpMenuBarPresenter new.
			"mainMenu applyTo: aPresenter" ].
		#actionDisplay -> [ aPresenter newTextInput ].
		#valueMenu -> [ APartMenuButtonPresenter owner: aPresenter ].
		#valueDisplay -> [ aPresenter newTextInput ].
		
		#label1 -> [ aPresenter newLabel label: 'Action display' ].
		#label2 -> [ aPresenter newLabel label: 'Value menu' ].
		#label3 -> [ aPresenter newLabel label: 'Value display' ].
	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxMenuNestedEnumeration class >> defaultSpec [
	<spec>
	
	^ SpGridLayout new
		add: #label1 at: 1@1;
		add: #actionDisplay at: 2@1;
		add: #label2 at: 1@2;
		add: #valueMenu at: 2@2;
		add: #label3 at: 1@3;
		add: #valueDisplay at: 2@3.
]

{ #category : #'*APart Examples-Pharo' }
APxMenuNestedEnumeration >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	
	aWindow menu: ((self presenterNamed: #menu)
		addGroup: [ :group | 
			#(actionMenu valueMenu) do: [ :aspectName |
				| aspect aMenu |
				aspect := self aspectFor: aspectName.
				aMenu := self subMenuForEnumerationValueAdaptor: aspect.
				group addItem: [ :item  |
					item name: aspectName;
					subMenu: aMenu.
					 ]
				 ] ]).
]
