Class {
	#name : #APartScopesTestLeft1UI,
	#superclass : #APartScopesTestPartUI,
	#category : #'APart PharoTests-Scopes'
}

{ #category : #API }
APartScopesTestLeft1UI class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#aspectInLeft1 -> [ aPresenter newTextInput ].
		#aspectInLeft1Absolute -> [ aPresenter newTextInput ].
		#child -> [ aPresenter subPart: #child ].
	}.

]
