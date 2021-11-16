Extension { #name : #APxMenuFromDynamicEnumExample }

{ #category : #'*APart Examples-Pharo' }
APxMenuFromDynamicEnumExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#menu -> [ | mainMenu |
			mainMenu := SpMenuBarPresenter new.
			aPresenter applyKeyBindingsFromMenu: mainMenu.
			mainMenu ].
		#actionText -> [ aPresenter newTextInput ].
		#testValueFromMenu -> [ aPresenter newTextInput ].
		#mirroredTestMenuValue -> [ APartMenuButtonPresenter owner: aPresenter ].

		#enumValueList -> [ aPresenter newList ].
		#removeEnum -> [  aPresenter newButton label: 'Remove'   ].
		#addEnum -> [  aPresenter newButton label: 'Add'   ].
		
		#label1 -> [ aPresenter newLabel label: 'Menu action' ].
		#label2 -> [ aPresenter newLabel label: 'Menu value' ].
	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxMenuFromDynamicEnumExample class >> defaultSpec [
	<spec>
	
	^ SpBoxLayout newHorizontal
		add: (
			SpGridLayout new
			add: #label1 at: 1@1;
			add: #actionText at: 2@1;
			add: #label2 at: 1@2;
			add: #testValueFromMenu at: 2@2;
			add: #mirroredTestMenuValue at: 2@3);	
		add: (
			SpBoxLayout newVertical
				spacing: 5;
				add: #enumValueList;
				addLast: (SpBoxLayout newHorizontal
					add: #removeEnum;
					add: #addEnum))
]

{ #category : #'*APart Examples-Pharo' }
APxMenuFromDynamicEnumExample >> initialExtent [
	^ (850@400) scaledByDisplayScaleFactor
]

{ #category : #'*APart Examples-Pharo' }
APxMenuFromDynamicEnumExample >> initializeWindow: aWindow [

	super initializeWindow: aWindow.
	
	aWindow menu: ((self presenterNamed: #menu)
		addGroup: [ :group | 
			#(menuAction menuValue) do: [ :aspectName |
				| aspect aMenu |
				aspect := self aspectFor: aspectName.
				aMenu := self subMenuForEnumerationValueAdaptor: aspect.
				group addItem: [ :item  |
					item name: aspectName;
					subMenu: aMenu.
					 ]
				 ] ]).
]
