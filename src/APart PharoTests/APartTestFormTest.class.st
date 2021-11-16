Class {
	#name : #APartTestFormTest,
	#superclass : #TestCase,
	#category : #'APart PharoTests'
}

{ #category : #tests }
APartTestFormTest >> performTest: aBlockPartForm [
	| part form |
	SpBindings
		value: SpStubAdapterBindings
		during: [ 
			| app | 
			app := SpMockApplication new.
			part := APartTestForm createRootPart.
			form := (APartTestForm openOnPart: part application: app) presenter.
			aBlockPartForm value: part value: form ]
]

{ #category : #tests }
APartTestFormTest >> testChangeFirstName [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #firstName) text: 'NewName'.
			self
				assert: (form presenterNamed: #firstName) text
				equals: 'NewName'.
			self assert: (form presenterNamed: #firstName) isEnabled.
			self assert: (form presenterNamed: #lastName) isEnabled.
			self assert: (form presenterNamed: #cancelEdit) isEnabled.
			self assert: (form presenterNamed: #saveData) isEnabled.
			self assert: (form presenterNamed: #clearFirstName) isEnabled.
			self assert: (form presenterNamed: #clearLastName) isEnabled ]
]

{ #category : #tests }
APartTestFormTest >> testClearFirstName [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #clearFirstName) performAction.
			self assert: (form presenterNamed: #firstName) isEnabled.
			self assert: (form presenterNamed: #lastName) isEnabled.
			self assert: (form presenterNamed: #cancelEdit) isEnabled.
			self deny: (form presenterNamed: #saveData) isEnabled.
			self deny: (form presenterNamed: #clearFirstName) isEnabled.
			self assert: (form presenterNamed: #clearLastName) isEnabled ]
]

{ #category : #tests }
APartTestFormTest >> testClearLastNameName [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #clearLastName) performAction.
			self assert: (form presenterNamed: #firstName) isEnabled.
			self assert: (form presenterNamed: #lastName) isEnabled.
			self assert: (form presenterNamed: #cancelEdit) isEnabled.
			self deny: (form presenterNamed: #saveData) isEnabled.
			self assert: (form presenterNamed: #clearFirstName) isEnabled.
			self deny: (form presenterNamed: #clearLastName) isEnabled ]
]

{ #category : #tests }
APartTestFormTest >> testInitialStates [
	self
		performTest: [ :part :form | 
			self assert: (form presenterNamed: #firstName) isEnabled.
			self assert: (form presenterNamed: #lastName) isEnabled.
			self assert: (form presenterNamed: #cancelEdit) isEnabled.
			self deny: (form presenterNamed: #saveData) isEnabled.
			self assert: (form presenterNamed: #clearFirstName) isEnabled.
			self assert: (form presenterNamed: #clearLastName) isEnabled ]
]

{ #category : #tests }
APartTestFormTest >> testInitialValues [
	self
		performTest: [ :part :form | 
			self
				assert: (form presenterNamed: #firstName) text
				equals: 'InitialFirstName'.
			self
				assert: (form presenterNamed: #lastName) text
				equals: 'InitialLastName' ]
]

{ #category : #tests }
APartTestFormTest >> testRefillFirstName [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #clearFirstName) performAction.
			(form presenterNamed: #firstName) text: 'NewName'.
			self
				assert: (form presenterNamed: #firstName) text
				equals: 'NewName'.
			self assert: (form presenterNamed: #firstName) isEnabled.
			self assert: (form presenterNamed: #lastName) isEnabled.
			self assert: (form presenterNamed: #cancelEdit) isEnabled.
			self assert: (form presenterNamed: #saveData) isEnabled.
			self assert: (form presenterNamed: #clearFirstName) isEnabled.
			self assert: (form presenterNamed: #clearLastName) isEnabled ]
]
