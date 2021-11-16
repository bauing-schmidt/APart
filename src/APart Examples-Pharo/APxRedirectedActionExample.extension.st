Extension { #name : #APxRedirectedActionExample }

{ #category : #'*APart Examples-Pharo' }
APxRedirectedActionExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#countriesList -> [  aPresenter newList   ].
		#citiesList -> [  aPresenter newList  ].
		#removeCountry -> [  aPresenter newButton label: 'Remove Country'   ].
		#removeCity -> [  aPresenter newButton label: 'Remove City'   ].
		#countriesListEnabled -> [ aPresenter newCheckBox label: 'Enable (Coutries)' ].
		#citiesListEnabled -> [ aPresenter newCheckBox label: 'Enable (Cities)' ].
		
		#lastRemoved -> [ aPresenter newTextInput ].
		#lastRemovingKey -> [ aPresenter newTextInput ].
		
		#label1 -> [ aPresenter newLabel label: 'Countries'].
		#label2 -> [ aPresenter newLabel label: 'Cities' ].
		#label3 -> [ aPresenter newLabel label: 'Removed:'].
		#label4 -> [ aPresenter newLabel label: 'in:' ].

	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxRedirectedActionExample class >> defaultSpec [
	<spec>
	
	^ SpBoxLayout newVertical
		  borderWidth: 10;
		  spacing: 10;
        add: (
            SpBoxLayout newHorizontal
					spacing: 10;
                add: (SpBoxLayout newVertical
                    add: #label1 expand: false fill: true padding: 0;
                    add: #countriesList;
						  addLast: #removeCountry;
						  addLast: #countriesListEnabled);
                add: (SpBoxLayout newVertical
                    add: #label2 expand: false fill: true padding: 0;
                    add: #citiesList; 
                    addLast: #removeCity;
						  addLast: #citiesListEnabled);
                yourself);
 		  addLast: (SpBoxLayout newHorizontal
                    add: #label3;
                    add: #lastRemoved);
  		  addLast: (SpBoxLayout newHorizontal
                    add: #label4;
                    add: #lastRemovingKey)
]

{ #category : #'*APart Examples-Pharo' }
APxRedirectedActionExample >> initializePresenters [ 

	super initializePresenters.
	client partInterface allSubInterfaces
		do: [:subCif | subCif collectExtraAnnouncementsFor: client].	
	


]
