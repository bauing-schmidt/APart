Extension { #name : #APxPeriodSelectionExample }

{ #category : #'*APart Examples-Pharo' }
APxPeriodSelectionExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#label1 -> [ aPresenter newLabel label: 'Selected period type' ].
		#selectedPeriodType -> [ aPresenter newTextInput 
			aspectSymbol: #'selectedPeriod type';
			id: #selectedPeriod].

		#label2 -> [ aPresenter newLabel label: 'Selected period formatted print' ].
		#selectedPeriodPrintModel -> [ aPresenter newTextInput 
			aspectSymbol: #'selectedPeriod printModel';
			id: #selectedPeriod].

		#label3 -> [ aPresenter newLabel label: 'From Date -> To Date' ].
		#selectedPeriodFromToPrint -> [ aPresenter newTextInput ].

		#selectPeriod -> [ aPresenter newButton label: 'Select Period' ].

		#enableAllOption -> [ aPresenter newCheckBox label: 'Show "All" Option' ].
		#enableYearOption -> [ aPresenter newCheckBox label: 'Enable "Year" Option' ].
		#enableMonthOption -> [ aPresenter newCheckBox label: 'Enable "Month" Option' ].
		#enableWeekOption -> [ aPresenter newCheckBox label: 'Enable "Week" Option' ].
		#enableDayOption -> [ aPresenter newCheckBox label: 'Enable "Day" Option' ].
		#enableFromToOption -> [ aPresenter newCheckBox label: 'Enable "From/To" Option' ].


	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxPeriodSelectionExample class >> defaultSpec [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.

	(self associatedPresentersFor: nil) keysDo: [ :aKey |
		aLayout add: aKey ].
		
	^ aLayout
]

{ #category : #'*APart Examples-Pharo' }
APxPeriodSelectionExample >> initialExtent [
	^ 400@550
]
