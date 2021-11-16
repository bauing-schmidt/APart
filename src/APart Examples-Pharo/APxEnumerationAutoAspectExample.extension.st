Extension { #name : #APxEnumerationAutoAspectExample }

{ #category : #'*APart Examples-Pharo' }
APxEnumerationAutoAspectExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#resolverModeEnabled -> [ aPresenter newCheckBox label: 'enabled' ].
		#resolverModeList -> [ aPresenter newDropList 
			aspectSymbol: #'resolverMode value';
			choicesSymbol: #'resolverMode enumerationKeys';
			id: #'resolverMode value'].
		#resolverModeValue -> [ aPresenter newTextInput
			aspectSymbol: #'resolverMode value'  ].
		#resolverModeText -> [ aPresenter newTextInput ].
		#clearResolverMode -> [ aPresenter newButton label: 'Clear'  ].
		#resolve -> [ aPresenter newButton label: 'Resolve'  ].

		#label1 -> [ aPresenter newLabel label: 'Resolver Mode'  ].
		#label2 -> [ aPresenter newLabel label: 'Modes'  ].
		#label3 -> [ aPresenter newLabel label: 'Value'  ].
		#label4 -> [ aPresenter newLabel label: 'Text'  ].

	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxEnumerationAutoAspectExample class >> defaultSpec [
	<spec>
	^ SpGridLayout new
		add: #label1 at: 1@1 span: 2@1;
		add: #resolverModeEnabled at: 2@2;
		add: #resolverModeList at: 2@3;
		add: #resolverModeValue at: 2@4;
		add: #resolverModeText at: 2@5;
		add: #clearResolverMode at: 1@6;
		add: #resolve  at: 2@6;
		
		add: #label2 at: 1@3;
		add: #label3 at: 1@4;
		add: #label4 at: 1@5.

]
