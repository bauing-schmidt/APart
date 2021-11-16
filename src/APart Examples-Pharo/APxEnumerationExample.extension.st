Extension { #name : #APxEnumerationExample }

{ #category : #'*APart Examples-Pharo' }
APxEnumerationExample class >> associatedPresentersFor: aPresenter [
	
	^ OrderedDictionary newFrom: { 
		#resolverModeEnabled -> [ aPresenter newCheckBox label: 'enabled' ].

		#modeResourceResolverOurPerson -> [ | button |
			button := aPresenter newRadioButton label: 'Employees'.
			button initialStateNotSet.
			button 
				aspectSymbol: #resolverMode;
				lookupKey: #lbModeResourceResolverOurPerson;
				select: #modeResourceResolverOurPerson;
				id: #modeResourceResolverOurPerson.
			button ].

		#modeResourceResolverExistingRole -> [ | button |
			button := aPresenter newRadioButton label: 'Existing Role'.
			button 
				aspectSymbol: #resolverMode;
				lookupKey: #lbModeResourceResolverExistingRole;
				select: #modeResourceResolverExistingRole;
				id: #modeResourceResolverOurPerson.
			button ].

		#modeResourceResolverCreateRole -> [ | button |
			button := aPresenter newRadioButton label: 'New Role'.
			button 
				aspectSymbol: #resolverMode;
				lookupKey: #lbModeResourceResolverCreateRole;
				select: #modeResourceResolverCreateRole;
				id: #modeResourceResolverCreateRole.
			button ].
		
		#modeResourceResolverExternalPerson -> [ | button |
			button := aPresenter newRadioButton  label: 'Existing Contact'.
			button 
				aspectSymbol: #resolverMode;
				lookupKey: #lbModeResourceResolverExternalPerson;
				select: #modeResourceResolverExternalPerson;
				id: #modeResourceResolverExternalPerson.
			button ].
		
		#modeResourceResolverExistingUnknown -> [ | button |
			button := aPresenter newRadioButton  label: 'Existing Adhoc Resource'.
			button 
				aspectSymbol: #resolverMode;
				lookupKey: #lbModeResourceResolverExistingUnknown;
				select: #modeResourceResolverExistingUnknown;
				select: #modeResourceResolverExistingUnknown.
			button ].
		
		#modeResourceResolverCreateUnknown -> [ | button |
			button := aPresenter newRadioButton label: 'New Adhoc Resource'.
			button 
				aspectSymbol: #resolverMode;
				lookupKey: #lbModeResourceResolverCreateUnknown;
				select: #modeResourceResolverCreateUnknown;
				id: #modeResourceResolverCreateUnknown.
			button ].
		
		#resolverMode -> [  aPresenter newTextInput
			aspectSymbol: #resolverMode;
			id: #resolverMode1   ].
		#resolverModeText -> [  aPresenter newTextInput 
			aspectSymbol: #resolverModeText;
			id: #resolverModeText  ].
		
		#clearResolverMode -> [ aPresenter newButton label: 'Clear'   ].
		#selectByList -> [ aPresenter newButton label: 'Select'   ].

		#label1 -> [ aPresenter newLabel label: 'Resolver Modes' ].
		#label2 -> [ aPresenter newLabel label: 'Value' ].
		#label3 -> [ aPresenter newLabel label: 'Text' ].
	}.
]

{ #category : #'*APart Examples-Pharo' }
APxEnumerationExample >> createPresenters [

	super createPresenters.
	
	(self presenterNamed: #modeResourceResolverOurPerson) associatedRadioButtons: (#( modeResourceResolverExistingRole modeResourceResolverCreateRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown) collect: [ :each | self presenterNamed: each ])
]

{ #category : #'*APart Examples-Pharo' }
APxEnumerationExample class >> defaultSpec [
	<spec>
	^ SpGridLayout new
		add: #label1 at: 1@1 span: 2@1;
		add: #resolverModeEnabled at: 2@2;

		add: #modeResourceResolverOurPerson at: 2@3;
		add: #modeResourceResolverExistingRole at: 2@4;
		add: #modeResourceResolverCreateRole at: 2@5;
		add: #modeResourceResolverExternalPerson at: 2@6;
		add: #modeResourceResolverExistingUnknown at: 2@7;
		add: #modeResourceResolverCreateUnknown at: 2@8;
		
		add: #resolverMode at: 2@9;
		add: #resolverModeText  at: 2@10;

		add: #clearResolverMode at: 1@11;
		add: #selectByList at: 2@11;
		
		add: #label2 at: 1@9;
		add: #label3 at: 1@10.

]

{ #category : #'*APart Examples-Pharo' }
APxEnumerationExample >> initialExtent [
	^ (400@400) scaledByDisplayScaleFactor
]
