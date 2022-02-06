Class {
	#name : #APxStatusBarExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-StatusBar'
}

{ #category : #'as yet unclassified' }
APxStatusBarExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#statusBar -> [ aPresenter instantiate: APartStatusBarPresenter ].
		#progressBar -> [ aPresenter instantiate: APartProgressBarPresenter ].
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

{ #category : #'as yet unclassified' }
APxStatusBarExample class >> defaultLayout [
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

		add: #label3 at: 1@4 span: 4@1;		
		add: #statusBar at: 1@5 span: 4@1;		
		add: #progressBar at: 1@6 span: 4@1.
]

{ #category : #API }
APxStatusBarExample class >> matchingPartClass [

	^APxStatusBarExamplePart
]

{ #category : #'as yet unclassified' }
APxStatusBarExample >> initialExtent [
	^ (880@200) scaledByDisplayScaleFactor
]
