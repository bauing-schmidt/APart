Class {
	#name : #APartScopesTestRootPartUI,
	#superclass : #APartScopesTestPartUI,
	#category : #'APart PharoTests-Scopes'
}

{ #category : #specs }
APartScopesTestRootPartUI class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#left -> [ aPresenter subPart: #left ].
		#right -> [ aPresenter subPart: #right ].
	}.

]

{ #category : #specs }
APartScopesTestRootPartUI class >> defaultSpec [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newHorizontal.
	aLayout borderWidth: 5; spacing: 10.	
	
	(self associatedPresentersFor: nil) keysDo: [ :aKey |
		aLayout add: aKey ].
		
	^ aLayout
]

{ #category : #initialization }
APartScopesTestRootPartUI >> initializeWidgets [
	super initializeWidgets.
	
	self 	whenBuiltDo: [ :this |
		self partInterface part subPartsDo: #openClient.
			
			 ].

]
