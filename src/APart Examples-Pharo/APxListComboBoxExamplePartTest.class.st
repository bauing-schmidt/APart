Class {
	#name : #APxListComboBoxExamplePartTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxListComboBoxExamplePartTest >> classToBeTested [

	^ APxListComboBoxExample
]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testAddNumber [

	self performTest: [ :part :form |
		self assertCollection: ((form presenterNamed: #numbersSelectionDisplay) listItems collect: #asString) hasSameElements: (#(1 2 3) collect: #asString).
		(form presenterNamed: #addNumberToList) performAction.
		self assertCollection: ((form presenterNamed: #numbersSelectionDisplay) listItems collect: #asString) hasSameElements: (#(1 2 3 -1) collect: #asString).
	]

]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testEnabled [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #numbersListEnabled) state: false.
			#(numbersListEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay removeSelection renameSelection)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			(form presenterNamed: #numbersListEnabled) state: true.
			#(numbersListEnabled replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(removeSelection renameSelection)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ] ]
]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testFirstSelect [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #numbersSelectionDisplay) selectIndex: 1.
			#(numbersListEnabled replaceList selectNext selectPrevious numberToAdd addNumberToList numbersSelectionDisplay removeSelection renameSelection)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			self assert: (form presenterNamed: #numberToAdd) text equals: -1.
			self
				assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex
				equals: 1 ]
]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(numbersSelectionDisplay numbersListEnabled replaceList selectNext selectPrevious numberToAdd addNumberToList)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(removeSelection renameSelection)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			self assert: (form presenterNamed: #numberToAdd) text equals: -1.
			self
				assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex
				equals: 0 ]
]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testRemoveSelection [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #numbersSelectionDisplay) selectIndex: 2.
			(form presenterNamed: #removeSelection) performAction.
			self
				assertCollection:
					((form presenterNamed: #numbersSelectionDisplay) listItems
						collect: #asString)
				hasSameElements: (#(1 3) collect: #asString) ]
]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testSelectNext [

	self performTest: [ :part :form |
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 0.
		[ 
			(form presenterNamed: #selectNext) performAction.
		] on: ProvideAnswerNotification do: [ :e | e resume: true ].
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 1.
	].

]

{ #category : #tests }
APxListComboBoxExamplePartTest >> testSelectPrev [

	self performTest: [ :part :form |
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 0.
		[
			(form presenterNamed: #selectPrevious) performAction.
		] on: ProvideAnswerNotification do: [ :e | e resume: true ].
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 3.
		[ 
			(form presenterNamed: #selectPrevious) performAction.
		] on: ProvideAnswerNotification do: [ :e | e resume: true ].
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 2.
		[ 
			(form presenterNamed: #selectPrevious) performAction.
		] on: ProvideAnswerNotification do: [ :e | e resume: true ].
.
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 1.
		[
			(form presenterNamed: #selectPrevious) performAction.
		] on: ProvideAnswerNotification do: [ :e | e resume: true ].
		self assert: (form presenterNamed: #numbersSelectionDisplay) selectedIndex equals: 3.
	].

]
