Class {
	#name : #APxMultiSelectionListExamplePartTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxMultiSelectionListExamplePartTest >> classToBeTested [

	^ APxMultiSelectionListExample
]

{ #category : #tests }
APxMultiSelectionListExamplePartTest >> testDeselectAll [

	self performTest: [ :part :form |
		(form presenterNamed: #allNamesList) selection selectIndexes: #(1 3).
		self assertCollection: (form presenterNamed: #selectedNamesList) model collection hasSameElements: #('Finn' 'Jannik').
	].

]

{ #category : #tests }
APxMultiSelectionListExamplePartTest >> testInitialState [

	self performTest: [ :part :form |
		self assert: (form presenterNamed: #allNamesList) selection selectedIndexes isEmpty.
		self assert: (form presenterNamed: #selectedNamesList) model collection isEmpty.
	].

]

{ #category : #tests }
APxMultiSelectionListExamplePartTest >> testSelectMore [

	self performTest: [ :part :form |
		(form presenterNamed: #allNamesList) selection selectIndexes: #(1 3).
		(form presenterNamed: #deselectAll) performAction.
		self assert: (form presenterNamed: #selectedNamesList) model collection isEmpty.
	].

]

{ #category : #tests }
APxMultiSelectionListExamplePartTest >> testSelectOne [

	self performTest: [ :part :form |
		(form presenterNamed: #allNamesList) selection selectIndexes: #(1).
		self assertCollection: (form presenterNamed: #selectedNamesList) model collection hasSameElements: #('Finn').
	].

]
