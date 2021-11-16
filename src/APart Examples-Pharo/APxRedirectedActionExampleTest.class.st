Class {
	#name : #APxRedirectedActionExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxRedirectedActionExampleTest >> classToBeTested [

	^ APxRedirectedActionExample
]

{ #category : #tests }
APxRedirectedActionExampleTest >> testDisableCountries [
	
	self
		performTest: [ :part :form | 
			(form presenterNamed: #countriesList) selection selectIndex: 2.
			(form presenterNamed: #citiesList) selection selectIndex: 1.
			(form presenterNamed: #countriesListEnabled) state: false.
			#(citiesList removeCity)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(countriesList removeCountry)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ] ]
]

{ #category : #tests }
APxRedirectedActionExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(countriesList citiesList countriesListEnabled citiesListEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(removeCountry removeCity)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			self
				assert: (form presenterNamed: #countriesList) selection selectedIndex
				equals: 0.
			self
				assert: (form presenterNamed: #citiesList) selection selectedIndex
				equals: 0.
			self assert: (form presenterNamed: #lastRemoved) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #lastRemovingKey) text isEmptyOrNil ]
]

{ #category : #tests }
APxRedirectedActionExampleTest >> testRemoveCity [

	self performTest: [ :part :form | 
		(form presenterNamed: #citiesList) selection selectIndex: 3.
		(form presenterNamed: #removeCity) performAction.
		self
			assert: (form presenterNamed: #lastRemoved) text
			equals: 'Munich'.
		self
			assert: (form presenterNamed: #lastRemovingKey) text
			equals: #citiesPart.
		self deny: (form presenterNamed: #removeCity) isEnabled.
	]
]

{ #category : #tests }
APxRedirectedActionExampleTest >> testRemoveCountry [

	self performTest: [ :part :form | 
		(form presenterNamed: #countriesList) selection selectIndex: 2.
		(form presenterNamed: #removeCountry) performAction.
		self
			assert: (form presenterNamed: #lastRemoved) text
			equals: 'France'.
		self
			assert: (form presenterNamed: #lastRemovingKey) text
			equals: #countriesPart.
		self deny: (form presenterNamed: #removeCountry) isEnabled.
	]
]

{ #category : #tests }
APxRedirectedActionExampleTest >> testSelection [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #countriesList) selection selectIndex: 2.
			self assert: (form presenterNamed: #removeCountry) isEnabled.
			self deny: (form presenterNamed: #removeCity) isEnabled.
			(form presenterNamed: #citiesList) selection selectIndex: 3.
			self assert: (form presenterNamed: #removeCountry) isEnabled.
			self assert: (form presenterNamed: #removeCity) isEnabled ]
]
