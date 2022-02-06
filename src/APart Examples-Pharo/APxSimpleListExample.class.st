Class {
	#name : #APxSimpleListExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-Pharo'
}

{ #category : #'as yet unclassified' }
APxSimpleListExample class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
		#numberList -> [ aPresenter newList ].
		#actionButton -> [  aPresenter newButton label: 'add number'   ].
		#modifyButton -> [  aPresenter newButton label: 'modify number'   ].
		#action -> [  aPresenter newButton label: 'action'   ].
	 }.

]

{ #category : #'as yet unclassified' }
APxSimpleListExample class >> defaultLayout [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.

	(self associatedPresentersFor: nil) keysDo: [ :aKey |
		aLayout add: aKey ].
		
	^ aLayout
]

{ #category : #API }
APxSimpleListExample class >> matchingPartClass [

	^APxSimpleListExamplePart
]
