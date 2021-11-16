Class {
	#name : #APxEnumerationComboBoxExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxEnumerationComboBoxExampleTest >> classToBeTested [

	^ APxEnumerationComboBoxExample
]

{ #category : #tests }
APxEnumerationComboBoxExampleTest >> testClear [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverMode1List) selectIndex: 2.
			(form presenterNamed: #clearResolverMode) performAction.
			self
				assert: (form presenterNamed: #resolverMode1List) selectedIndex
				equals: 0.
			self
				assert: (form presenterNamed: #resolverMode1Value) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverMode1Text) text isEmptyOrNil ]
]

{ #category : #tests }
APxEnumerationComboBoxExampleTest >> testDisabled [


	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverModeEnabled) state: false.
			#(resolverModeEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(resolverMode1List resolverMode1Value resolverMode1Text resolverMode2List resolverMode2Value resolverMode2Text clearResolverMode resolve)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ] ]
]

{ #category : #tests }
APxEnumerationComboBoxExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(resolverModeEnabled resolverMode1List resolverMode1Value resolverMode1Text resolverMode2List resolverMode2Value resolverMode2Text clearResolverMode resolve)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			self
				assert: (form presenterNamed: #resolverMode1List) selectedIndex
				equals: 0.
			self
				assert: (form presenterNamed: #resolverMode2List) selectedIndex
				equals: 0.
			self
				assert: (form presenterNamed: #resolverMode1Value) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverMode1Text) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverMode2Value) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverMode2Text) text isEmptyOrNil ]
]

{ #category : #tests }
APxEnumerationComboBoxExampleTest >> testSelectMode1 [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverMode1List) selectIndex: 2.
			self
				assert: (form presenterNamed: #resolverMode1Value) text asString
				equals: #modeResourceResolverExistingRole.
			self
				assert: (form presenterNamed: #resolverMode1Text) text asString
				equals: #lbModeResourceResolverExistingRole.
			self
				assert: (form presenterNamed: #resolverMode2List) selectedIndex
				equals: 0.
			self
				assert: (form presenterNamed: #resolverMode2Value) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverMode2Text) text isEmptyOrNil ]
]
