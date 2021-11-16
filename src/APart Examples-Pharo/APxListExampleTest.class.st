Class {
	#name : #APxListExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxListExampleTest >> classToBeTested [

	^ APxListExample
]

{ #category : #tests }
APxListExampleTest >> testAddNumber [

	self performTest: [ :part :form | 
		self assertCollection: (form presenterNamed: #numbersList) model items hasSameElements: #(1 2 3).
		(form presenterNamed: #addNumberToList) performAction.
		self assertCollection: (form presenterNamed: #numbersList) model items hasSameElements: #(1 2 3 -1).
	]

]

{ #category : #tests }
APxListExampleTest >> testDropDownListSelectionChangesList [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #numbersSelectionDisplay) selectIndex: 1.
			self
				assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex
				equals: 1.
			self
				assert: (form presenterNamed: #numbersList) selection selectedIndex
				equals: 1.
			(form presenterNamed: #numbersSelectionDisplay) selectIndex: 3.
			self
				assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex
				equals: 3.
			self
				assert: (form presenterNamed: #numbersList) selection selectedIndex
				equals: 3 ]
]

{ #category : #tests }
APxListExampleTest >> testEnabled [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #numbersListEnabled) state: false.
			#(numbersListEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(numbersList replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay removeSelection renameSelection)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			(form presenterNamed: #numbersListEnabled) state: true.
			#(numbersListEnabled numbersList replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(removeSelection renameSelection)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ] ]
]

{ #category : #tests }
APxListExampleTest >> testFirstSelect [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #numbersList) selection selectItem: 1.
			#(numbersListEnabled numbersList replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay removeSelection renameSelection)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			self assert: (form presenterNamed: #numberToAdd) text equals: -1.
			self
				assert: (form presenterNamed: #numbersList) selection selectedIndex
				equals: 1 ]
]

{ #category : #tests }
APxListExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(numbersListEnabled numbersList replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(removeSelection renameSelection)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			self assert: (form presenterNamed: #numberToAdd) text equals: -1.
			self
				assert: (form presenterNamed: #numbersList) selection selectedIndex
				equals: 0 ]
]

{ #category : #tests }
APxListExampleTest >> testListSelectionChangesDropDownList [

	self performTest: [ :part :form |
		(form presenterNamed: #numbersList) selection selectItem: 1.
				
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 1.
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 1.

		(form presenterNamed: #numbersList) selection selectItem: 3.
				
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 3.
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 3.
	].

]

{ #category : #tests }
APxListExampleTest >> testRemoveSelection [
	
	self performTest: [ :part :form | 
		(form presenterNamed: #numbersList) selection selectItem: 2.
		(form presenterNamed: #removeSelection) performAction.
		self assertCollection: (form presenterNamed: #numbersList) model items hasSameElements: #(1 3).
	]

]

{ #category : #tests }
APxListExampleTest >> testSelectNext [

	self performTest: [ :part :form |
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 0.
		(form presenterNamed: #selectNext) performAction.
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 1.
	].

]

{ #category : #tests }
APxListExampleTest >> testSelectPrev [

	self performTest: [ :part :form |
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 0.
		(form presenterNamed: #selectPrevious) performAction.
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 3.
		(form presenterNamed: #selectPrevious) performAction.
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 2.
		(form presenterNamed: #selectPrevious) performAction.
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 1.
		(form presenterNamed: #selectPrevious) performAction.
		self assert: (form presenterNamed: #numbersList) selection selectedIndex equals: 3.
	].

]
