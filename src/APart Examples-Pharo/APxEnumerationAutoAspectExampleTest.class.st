Class {
	#name : #APxEnumerationAutoAspectExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxEnumerationAutoAspectExampleTest >> classToBeTested [

	^ APxEnumerationAutoAspectExample
]

{ #category : #tests }
APxEnumerationAutoAspectExampleTest >> testClear [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverModeList) selectIndex: 2.
			(form presenterNamed: #clearResolverMode) performAction.
			self
				assert: (form presenterNamed: #resolverModeValue) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverModeText) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverModeList) selectedIndex
				equals: 0 ]
]

{ #category : #tests }
APxEnumerationAutoAspectExampleTest >> testDisable [

"	self skip.
"
	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverModeEnabled) state: false.
			#(resolverModeEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(resolverModeList resolverModeValue resolverModeText clearResolverMode resolve)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ].
			self
				assert: (form presenterNamed: #resolverModeList) selectedIndex
				equals: 0 ]
]

{ #category : #tests }
APxEnumerationAutoAspectExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(resolverModeEnabled resolverModeList resolverModeValue resolverModeText clearResolverMode resolve)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			self
				assert: (form presenterNamed: #resolverModeValue) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverModeText) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverModeList) selectedIndex
				equals: 0 ]
]

{ #category : #tests }
APxEnumerationAutoAspectExampleTest >> testSelect [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverModeList) selectIndex: 2.
			self
				assert: (form presenterNamed: #resolverModeValue) text asString
				equals: 'modeResourceResolverExistingRole'.
			self
				assert: (form presenterNamed: #resolverModeText) text asString
				equals: 'lbModeResourceResolverExistingRole' ]
]
