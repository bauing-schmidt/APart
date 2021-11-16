Extension { #name : #APxComplexPromptSubEditor }

{ #category : #'*APart Examples-Pharo' }
APxComplexPromptSubEditor class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#firstName -> [ aPresenter newTextInput ].
		#lastName -> [ aPresenter newTextInput ].
		#clearFirstName -> [  aPresenter newButton label: 'clear first name'   ].
		#clearLastName -> [  aPresenter newButton label: 'clear last name'   ].
		#cancelEdit -> [  aPresenter newButton label: 'cancel edit'   ].
		#saveData -> [  aPresenter newButton label: 'save data'   ].

		#label1 -> [  aPresenter newLabel label: 'First name'   ].
		#label2 -> [  aPresenter newLabel label: 'Last name'   ].

	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxComplexPromptSubEditor class >> defaultSpec [
	<spec>
	^ SpGridLayout new
		add: #label1 at: 1@1;
		add: #firstName at: 2@1;
		add: #clearFirstName at: 3@1;

		add: #label2 at: 1@2;
		add: #lastName at: 2@2;
		add: #clearLastName at: 3@2;
		
		add: #cancelEdit at: 1@3;
		add: #saveData at: 2@3.

]

{ #category : #'*APart Examples-Pharo' }
APxComplexPromptSubEditor >> initialExtent [
	^ 600@300
]
