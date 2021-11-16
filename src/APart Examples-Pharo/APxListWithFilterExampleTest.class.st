Class {
	#name : #APxListWithFilterExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxListWithFilterExampleTest >> classToBeTested [

	^ APxListWithFilterExample
]

{ #category : #tests }
APxListWithFilterExampleTest >> testEnableFilter [

	self performTest: [ :part :form | 
		(form presenterNamed: #isFilterEnabled) state: true.
		#(isSortByFirstName filterName filterFirstName)
			do: [ :name | self assert: (form presenterNamed: name) isEnabled ] 
	]	
]

{ #category : #tests }
APxListWithFilterExampleTest >> testFilterName [

	self performTest: [ :part :form |
 		(form presenterNamed: #isFilterEnabled) state: true.
		(form presenterNamed: #filterName) text: 'g'.

		self assert: (form presenterNamed: #personList) model collection size equals: 2.
	]
]

{ #category : #tests }
APxListWithFilterExampleTest >> testFilterNameWithFilterReneablement [

	self performTest: [ :part :form | 
		(form presenterNamed: #isFilterEnabled) state: true.
		(form presenterNamed: #filterName) text: 'g'.
		
		(form presenterNamed: #isFilterEnabled) state: false.
		(form presenterNamed: #isFilterEnabled) state: true.

		self assert: (form presenterNamed: #personList) model collection size equals: 2.
	] 
]

{ #category : #tests }
APxListWithFilterExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(personList selectPrevious selectNext isFilterEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(isSortByFirstName filterName filterFirstName)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			self
				assert: (form presenterNamed: #personList) model collection size
				equals: 62.
			self assert: (form presenterNamed: #filterName) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #filterFirstName) text isEmptyOrNil ]
]

{ #category : #tests }
APxListWithFilterExampleTest >> testSelectNext [
	
	self performTest: [ :part :form | 
		(form presenterNamed: #personList) selectIndex: 2.
		(form presenterNamed: #selectNext) performAction.
		
		self assert: (form presenterNamed: #personList) selection selectedIndex equals: 3 
	]
	
]

{ #category : #tests }
APxListWithFilterExampleTest >> testSelectNextAfterFiltering [

	self performTest: [ :part :form | 
		(form presenterNamed: #isFilterEnabled) state: true.
		(form presenterNamed: #filterName) text: 'g'.
		
		(form presenterNamed: #isFilterEnabled) state: false.
		(form presenterNamed: #isFilterEnabled) state: true.
		
		(form presenterNamed: #personList) selectIndex: 1.
		(form presenterNamed: #selectNext) performAction.
		
		self assert: (form presenterNamed: #personList) selection selectedIndex equals: 2 
	] 
]

{ #category : #tests }
APxListWithFilterExampleTest >> testSelectNextAfterFilteringWithoutSelection [

	self performTest: [ :part :form | 
		(form presenterNamed: #isFilterEnabled) state: true.
		(form presenterNamed: #filterName) text: 'g'.
		
		(form presenterNamed: #isFilterEnabled) state: false.
		(form presenterNamed: #isFilterEnabled) state: true.
		
		(form presenterNamed: #selectNext) performAction.
		
		self assert: (form presenterNamed: #personList) selection selectedIndex equals: 1 
	] 
]

{ #category : #tests }
APxListWithFilterExampleTest >> testSelectPrev [
	
	self performTest: [ :part :form | 
		(form presenterNamed: #personList) selectIndex: 2.
		(form presenterNamed: #selectPrevious) performAction.
		
		self assert: (form presenterNamed: #personList) selection selectedIndex equals: 1
	]

]

{ #category : #tests }
APxListWithFilterExampleTest >> testSortByFirstName [

	self performTest: [ :part :form | 
		(form presenterNamed: #isFilterEnabled) state: true.
		(form presenterNamed: #isSortByFirstName) state: true.
		
		self assert: (form presenterNamed: #personList) model collection first firstName equals: 'Alexander'.
		self assert: (form presenterNamed: #personList) model collection last firstName equals: 'Yvonne'.
	] 
]

{ #category : #tests }
APxListWithFilterExampleTest >> testSortByFirstNameWithFilterReneablement [

	self performTest: [ :part :form | 
		(form presenterNamed: #isFilterEnabled) state: true.
		(form presenterNamed: #isSortByFirstName) state: true.
		
		(form presenterNamed: #isFilterEnabled) state: false.
		(form presenterNamed: #isFilterEnabled) state: true.

		self assert: (form presenterNamed: #personList) model collection first firstName equals: 'Alexander'.
		self assert: (form presenterNamed: #personList) model collection last firstName equals: 'Yvonne'.
	]
]
