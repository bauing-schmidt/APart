Class {
	#name : #APartScopesTestRight2UI,
	#superclass : #APartScopesTestPartUI,
	#category : #'APart PharoTests-Scopes'
}

{ #category : #API }
APartScopesTestRight2UI class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#aspectInRight2 -> [ aPresenter newTextInput ].
		#aspectInRight2Absolute -> [ aPresenter newTextInput ].

		#right2ActionDependingOnAspectInLeft2 -> [  aPresenter newButton label: 'right2ActionDependingOnAspectInLeft2'   ].
		#disableAspectInLeft2 -> [  aPresenter newButton label: 'disableAspectInLeft2'   ].
		#enableAspectInLeft2 -> [  aPresenter newButton label: 'enableAspectInLeft2'   ].	
	}.

]
