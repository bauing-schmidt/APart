Extension { #name : #APxComplexPromptExample }

{ #category : #'*APart Examples-Pharo' }
APxComplexPromptExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#editModal -> [ aPresenter newButton label: 'edit modal'].
		#editNormal -> [ aPresenter newButton label: 'edit normal' ].
		#firstName -> [ aPresenter newTextInput ].
		#lastName -> [ aPresenter newTextInput ].

		#label1 -> [ aPresenter newLabel label: 'First name:' ].
		#label2 -> [ aPresenter newLabel label: 'Last name:' ].
	 }.

]

{ #category : #'*APart Examples-Pharo' }
APxComplexPromptExample class >> defaultLayout [
	<spec>
	^ SpGridLayout new
		add: #editModal at: 1@1;
		add: #editNormal at: 1@2;
		add: #firstName at: 3@1;
		add: #lastName at: 3@2;

		add: #label1 at: 2@1;
		add: #label2 at: 2@2.
]

{ #category : #'*APart Examples-Pharo' }
APxComplexPromptExample >> initialExtent [
	^ 600@300
]
