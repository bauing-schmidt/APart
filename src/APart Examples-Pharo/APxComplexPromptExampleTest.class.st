Class {
	#name : #APxComplexPromptExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxComplexPromptExampleTest >> classToBeTested [

	^ APxComplexPromptExample
]

{ #category : #tests }
APxComplexPromptExampleTest >> testEditModalInitialState [
	self
		performTest: [ :part :form | 
			| dialog |
			(form presenterNamed: #editModal) click.
			dialog := (form application windows detect: #isDialog) presenter.
			self assert: (dialog presenterNamed: #firstName) isEnabled.
			self assert: (dialog presenterNamed: #lastName) isEnabled.
			self assert: (dialog presenterNamed: #clearFirstName) isEnabled.
			self assert: (dialog presenterNamed: #clearLastName) isEnabled.
			self assert: (dialog presenterNamed: #cancelEdit) isEnabled.
			self deny: (dialog presenterNamed: #saveData) isEnabled.
			self
				assert: (dialog presenterNamed: #firstName) text
				equals: 'first'.
			self assert: (dialog presenterNamed: #lastName) text equals: 'last' ]
]

{ #category : #tests }
APxComplexPromptExampleTest >> testEditNormalInitialState [

	"this cannot be safely tested because the apart clients do not keep information that
	can be used for binding of the new non-modal windows to the current application so this
	test cannot be run in non-interactive mode."
	self skip.

	self
		performTest: [ :part :form | 
			(form presenterNamed: #editNormal) click.]
]

{ #category : #tests }
APxComplexPromptExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			self assert: (form presenterNamed: #editModal) isEnabled.
			self assert: (form presenterNamed: #editNormal) isEnabled.
			self deny: (form presenterNamed: #firstName) isEnabled.
			self deny: (form presenterNamed: #lastName) isEnabled.
			self assert: (form presenterNamed: #firstName) text equals: 'first'.
			self assert: (form presenterNamed: #lastName) text equals: 'last' ]
]
