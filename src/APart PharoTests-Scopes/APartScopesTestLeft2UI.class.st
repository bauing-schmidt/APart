Class {
	#name : #APartScopesTestLeft2UI,
	#superclass : #APartScopesTestPartUI,
	#category : #'APart PharoTests-Scopes'
}

{ #category : #API }
APartScopesTestLeft2UI class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#aspectInLeft2 -> [ aPresenter newTextInput ].
		#aspectInLeft2Absolute -> [ aPresenter newTextInput ].
	}.

]
