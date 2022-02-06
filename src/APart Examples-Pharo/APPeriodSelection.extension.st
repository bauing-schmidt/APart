Extension { #name : #APPeriodSelection }

{ #category : #'*APart Examples-Pharo' }
APPeriodSelection class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#standardOK -> [ aPresenter newButton label: 'OK'  ].
		#standardCancel -> [ aPresenter newButton label: 'Abbruch'  ].

		#year -> [ aPresenter newTextInput ].
		#month -> [ aPresenter newDropList 
			aspectSymbol: #'monthEnum valueText';
			choicesSymbol: #'monthEnum enumerationTextList';
			id: #month].
		#week -> [ aPresenter newTextInput ].
		#day -> [ aPresenter newTextInput ].
		#fromDate -> [ aPresenter newTextInput ].
		#toDate -> [ aPresenter newTextInput ].
		

		#yearRB -> [ | button |
			button := aPresenter newRadioButton label: 'Jahr'.
			button 
				aspectSymbol: #'periodTypeEnum value';
				lookupKey: #Jahr;
				select: #year;
				id: #yearRB.
			button ].
		#monthRB -> [ | button |
			button := aPresenter newRadioButton label: 'Monat'.
			button 
				aspectSymbol: #'periodTypeEnum value';
				lookupKey: #Monat;
				select: #month;
				id: #monthRB.
			button ].
		#weekRB -> [ | button |
			button := aPresenter newRadioButton label: 'Woche'.
			button 
				aspectSymbol: #'periodTypeEnum value';
				lookupKey: #Woche;
				select: #week;
				id: #weekRB.
			button ].
		#dayRB -> [ | button |
			button := aPresenter newRadioButton label: 'Tag'.
			button 
				aspectSymbol: #'periodTypeEnum value';
				lookupKey: #Tag;
				select: #day;
				id: #dayRB.
			button ].
		#fromToRB -> [ | button |
			button := aPresenter newRadioButton label: 'von - bis'.
			button 
				aspectSymbol: #'periodTypeEnum value';
				lookupKey: #vonBis;
				select: #fromTo;
				id: #fromToRB.
			button ].

		#label1 -> [ aPresenter newLabel label: 'Jahr:'  ].
		#label2 -> [ aPresenter newLabel label: 'Monat:'  ].
		#label3 -> [ aPresenter newLabel label: 'Woche:'  ].
		#label4 -> [ aPresenter newLabel label: 'Tag:'  ].
		#label5 -> [ aPresenter newLabel label: 'von:'  ].
		#label6 -> [ aPresenter newLabel label: 'bis:'  ].

	 }.

]

{ #category : #'*APart Examples-Pharo' }
APPeriodSelection >> createPresenters [

	super createPresenters.
	
	(self presenterNamed: #yearRB) associatedRadioButtons: (#( monthRB weekRB dayRB fromToRB) collect: [ :each | self presenterNamed: each ])
]

{ #category : #'*APart Examples-Pharo' }
APPeriodSelection class >> defaultLayout [
	^ SpGridLayout new
		add: #yearRB at: 1@1;
		add: #monthRB at: 1@2;
		add: #weekRB at: 1@3;
		add: #dayRB at: 1@4;
		add: #fromToRB at: 1@5;
		
		add: #label1 at: 2@1;
		add: #label2 at: 2@2;
		add: #label3 at: 2@3;
		add: #label4 at: 2@4;
		add: #label5 at: 2@5;
		add: #label6 at: 2@6;

		add: #year at: 3@1;
		add: #month at: 3@2;
		add: #week at: 3@3;
		add: #day at: 3@4;
		add: #fromDate at: 3@5;
		add: #toDate at: 3@6;
	
		add: #standardOK at: 4@1;
		add: #standardCancel at: 4@2.

]

{ #category : #'*APart Examples-Pharo' }
APPeriodSelection >> initialExtent [
	^ 650@250
]
