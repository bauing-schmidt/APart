Extension { #name : #APxEnablementExample }

{ #category : #'*APart Examples-Pharo' }
APxEnablementExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#stringField -> [ aPresenter newTextInput ].
		#intField -> [ aPresenter newNumberInput ].
		#confirmString -> [ aPresenter newCheckBox label: 'Confirm String' ].
		#confirmNumber -> [ aPresenter newCheckBox label: 'Confirm number'  ].
		#disableInput -> [ aPresenter newCheckBox label: 'disable input'  ].
		#clearNumber -> [  aPresenter newButton label: 'clear number'   ].
		#clearString -> [  aPresenter newButton label: 'clear string'   ].
		#saveData -> [  aPresenter newButton label: 'save data'   ].

		#label1 -> [  aPresenter newLabel label: 'String'   ].
		#label2 -> [  aPresenter newLabel label: 'Integer'   ].
		#label3 -> [  aPresenter newLabel label: '(Enter String of minimum size 2 and number > 9, then conform both)'   ].
	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxEnablementExample class >> defaultSpec [
	<spec>
	^ SpGridLayout new
		add: #label1 at: 1@1;
		add: #stringField at: 2@1;
		add: #clearString at: 3@1;
		add: #confirmString at: 4@1;

		add: #label2 at: 1@2;
		add: #intField at: 2@2;
		add: #clearNumber at: 3@2;
		add: #confirmNumber at: 4@2;
		
		add: #disableInput at: 2@3;
		add: #saveData at: 4@3;

		add: #label3 at: 1@4 span: 4@1.
]

{ #category : #'*APart Examples-Pharo' }
APxEnablementExample >> initialExtent [
	^ (880@200) scaledByDisplayScaleFactor
]
