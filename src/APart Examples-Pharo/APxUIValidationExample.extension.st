Extension { #name : #APxUIValidationExample }

{ #category : #'*APart Examples-Pharo' }
APxUIValidationExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#hours -> [ 
			| textInput |
			textInput := aPresenter newTextInput
							"autoAccept: true".
			textInput whenTextChangedDo: [ textInput text traceCr ]";
							acceptBlock: [ :aText | #h traceCr. false ]".
			textInput ].
		#stringInput -> [ aPresenter newTextInput ].
		#label1 -> [ aPresenter newLabel label: 'Hours:' ].
		#label2 -> [ aPresenter newLabel label: 'String:' ].
		#label3 -> [ aPresenter newLabel label: 'Max value [24:00]' ].
		#label4 -> [ aPresenter newLabel label: 'Max length [20 char]' ].
	 }.
]

{ #category : #'*APart Examples-Pharo' }
APxUIValidationExample class >> defaultLayout [
	<spec>
	^ SpGridLayout new
		add: #label1 at: 1@1;
		add: #label2 at: 1@2;
		add: #hours at: 2@1;
		add: #stringInput at: 2@2;
		add: #label3 at: 3@1;
		add: #label4 at: 3@2.
]

{ #category : #'*APart Examples-Pharo' }
APxUIValidationExample >> initialExtent [
	^ 600@200
]
