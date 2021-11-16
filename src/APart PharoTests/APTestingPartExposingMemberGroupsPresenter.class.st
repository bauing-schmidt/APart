Class {
	#name : #APTestingPartExposingMemberGroupsPresenter,
	#superclass : #APartPresenter,
	#traits : 'APTPartWithFocus',
	#classTraits : 'APTPartWithFocus classTrait',
	#category : #'APart PharoTests-MemberGroups'
}

{ #category : #API }
APTestingPartExposingMemberGroupsPresenter class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#someAspect -> [ aPresenter newTextInput ].
		#someAction -> [ aPresenter newButton label: #someAction  ].
	 }.

]

{ #category : #API }
APTestingPartExposingMemberGroupsPresenter class >> defaultSpec [
	<spec>
	^ SpBoxLayout newHorizontal
		add: #someAction;
		add: #someAspect.
]

{ #category : #API }
APTestingPartExposingMemberGroupsPresenter class >> matchingPartClass [

	^APTestingPartExposingMemberGroups
]
