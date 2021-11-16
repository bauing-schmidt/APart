Class {
	#name : #APartScopesTestPartUI,
	#superclass : #APartExampleGUI,
	#category : #'APart PharoTests-Scopes'
}

{ #category : #specs }
APartScopesTestPartUI class >> defaultSpec [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.
	
	(self associatedPresentersFor: nil) keysDo: [ :aKey |
		aLayout add: aKey ].
		
	^ aLayout
]

{ #category : #specs }
APartScopesTestPartUI class >> matchingPartClass [

	^ self environment at: (self name withoutSuffix: #UI) asSymbol
]
