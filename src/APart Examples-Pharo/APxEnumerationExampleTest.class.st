Class {
	#name : #APxEnumerationExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxEnumerationExampleTest >> classToBeTested [

	^ APxEnumerationExample
]

{ #category : #tests }
APxEnumerationExampleTest >> performTest: aBlockPartForm [
	| part form |
	SpBindings
		value: SpStubAdapterBindings
		during: [ part := APxEnumerationExample createRootPart.
			form := (APxEnumerationExample openOnPart: part) presenter.
			aBlockPartForm value: part value: form ]
]

{ #category : #tests }
APxEnumerationExampleTest >> testClear [

	self skip. "reset of radio buttons is missing"
	self
		performTest: [ :part :form | 
			(form presenterNamed: #modeResourceResolverCreateRole) state: true.
			(form presenterNamed: #clearResolverMode) performAction.
			#(resolverModeEnabled modeResourceResolverOurPerson modeResourceResolverExistingRole modeResourceResolverCreateRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown resolverMode resolverModeText clearResolverMode selectByList)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(modeResourceResolverOurPerson modeResourceResolverExistingRole modeResourceResolverCreateRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown)
				do: [ :aSymbol | self deny: (form presenterNamed: aSymbol) state ].
			self assert: (form presenterNamed: #resolverMode) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverModeText) text isEmptyOrNil ]
]

{ #category : #tests }
APxEnumerationExampleTest >> testDisable [

	self
		performTest: [ :part :form | 
			(form presenterNamed: #resolverModeEnabled) state: false.
			#(resolverModeEnabled)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(modeResourceResolverOurPerson modeResourceResolverExistingRole modeResourceResolverCreateRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown resolverMode resolverModeText clearResolverMode selectByList)
				do: [ :name | self deny: (form presenterNamed: name) isEnabled ] ]
]

{ #category : #tests }
APxEnumerationExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			#(resolverModeEnabled modeResourceResolverOurPerson modeResourceResolverExistingRole modeResourceResolverCreateRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown resolverMode resolverModeText clearResolverMode)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#( modeResourceResolverExistingRole modeResourceResolverCreateRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown)
				do: [ :aSymbol | self deny: (form presenterNamed: aSymbol) state ].
	]
]

{ #category : #tests }
APxEnumerationExampleTest >> testInitialStateFailing [
	self
		performTest: [ :part :form | 
			#(selectByList)
				do: [ :name | self assert: (form presenterNamed: name) isEnabled ].
			#(modeResourceResolverOurPerson)
				do: [ :aSymbol | self deny: (form presenterNamed: aSymbol) state ].
			self assert: (form presenterNamed: #resolverMode) text isEmptyOrNil.
			self
				assert: (form presenterNamed: #resolverModeText) text isEmptyOrNil ]
]

{ #category : #tests }
APxEnumerationExampleTest >> testSelectOne [

	self skip.
	"this test requires fix of radio buttons without initial selection"
	
	self performTest: [ :part :form |
		(form presenterNamed: #modeResourceResolverCreateRole) state: true.

		#(modeResourceResolverOurPerson modeResourceResolverExistingRole modeResourceResolverExternalPerson modeResourceResolverExistingUnknown modeResourceResolverCreateUnknown) do: [ :aSymbol |
			self deny: (form presenterNamed: aSymbol) state ].		
			
		self assert: (form presenterNamed: #resolverMode) text asString equals: #modeResourceResolverCreateRole.
		self assert: (form presenterNamed: #resolverModeText) text asString equals: #lbModeResourceResolverCreateRole.
			
	].

]
