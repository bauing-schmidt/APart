Extension { #name : #APxEnumerationComboBoxExample }

{ #category : #'*APart Examples-Pharo' }
APxEnumerationComboBoxExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#resolverModeEnabled -> [ aPresenter newCheckBox label: 'enabled' ].

		#resolverMode1List -> [ aPresenter newDropList 
			aspectSymbol: #resolverMode1Text;
			choicesSymbol: #resolverMode1List;
			id: #resolverMode1List ].
		#resolverMode1Value -> [  aPresenter newTextInput
			aspectSymbol: #resolverMode1;
			id: #resolverMode1Value   ].
		#resolverMode1Text -> [  aPresenter newTextInput   ].
		
		#resolverMode2List -> [ aPresenter newDropList 
			aspectSymbol: #'resolverMode2 valueText';
			choicesSymbol: #'resolverMode2 enumerationTextList';
			id: #'resolverMode2 enumerationTextList' ].
		#resolverMode2Value -> [  aPresenter newTextInput 
			aspectSymbol: 'resolverMode2 value' ].
		#resolverMode2Text -> [  aPresenter newTextInput
			aspectSymbol: 'resolverMode2 valueText' ].
		
		#clearResolverMode -> [ aPresenter newButton label: 'Clear'   ].
		#resolve -> [ aPresenter newButton label: 'Resolve'   ].
"		#inspectIt -> [ aPresenter newButton label: 'Inspect'   ]."

		#label1 -> [ aPresenter newLabel label: 'Resolver Modes' ].
		#label2 -> [ aPresenter newLabel label: 'Modes 1 (redirected)' ].
		#label3 -> [ aPresenter newLabel label: 'Value1' ].
		#label4 -> [ aPresenter newLabel label: 'Text1 (readonly)' ].
		#label5 -> [ aPresenter newLabel label: 'Modes 2 (path)' ].
		#label6 -> [ aPresenter newLabel label: 'Value2' ].
		#label7 -> [ aPresenter newLabel label: 'Text2' ].

	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxEnumerationComboBoxExample class >> defaultSpec [
	<spec>
	^ SpGridLayout new
		add: #label1 at: 1@1 span: 2@1;
		add: #resolverModeEnabled at: 2@2;

		add: #resolverMode1List at: 2@3;
		add: #resolverMode1Value at: 2@4;
		add: #resolverMode1Text at: 2@5;
		
		add: #resolverMode2List at: 2@6;
		add: #resolverMode2Value at: 2@7;
		add: #resolverMode2Text at: 2@8;
		
		add: #clearResolverMode at: 1@9;
		add: #resolve  at: 2@9;
		
		add: #label2 at: 1@3;
		add: #label3 at: 1@4;
		add: #label4 at: 1@5;
		add: #label5 at: 1@6;
		add: #label6 at: 1@7;
		add: #label7 at: 1@8.

]

{ #category : #'*APart Examples-Pharo' }
APxEnumerationComboBoxExample >> initialExtent [
	^ (500@350) scaledByDisplayScaleFactor
]
