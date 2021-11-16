Class {
	#name : #APartScopesTestRight1UI,
	#superclass : #APartScopesTestPartUI,
	#category : #'APart PharoTests-Scopes'
}

{ #category : #API }
APartScopesTestRight1UI class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#aspectInRight1 -> [ aPresenter newTextInput ].
		#aspectInRight1Absolute -> [ aPresenter newTextInput ].

		#child -> [ aPresenter subPart: #child ].
	}.

]
