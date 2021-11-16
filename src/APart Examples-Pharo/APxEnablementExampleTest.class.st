Class {
	#name : #APxEnablementExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxEnablementExampleTest >> classToBeTested [

	^ APxEnablementExample
]

{ #category : #tests }
APxEnablementExampleTest >> testCorrectSaveButtonStateAfterInvalidationOfIntInput [

	self performTest: [ :part :form |

		(form presenterNamed: #stringField) text: 'Joe'.
		(form presenterNamed: #intField) text: '12'.
		(form presenterNamed: #confirmString) state: true.
		(form presenterNamed: #confirmNumber) state: true.

		self assert: ((form presenterNamed: #confirmNumber) state).
		(form presenterNamed: #intField) text: '1'.
		"not very natural behavior, see APxEnablementExamplePart>>#confirmNumber"
		self deny: ((form presenterNamed: #confirmNumber) state).
		(form presenterNamed: #intField) text: '12'.
		self assert: ((form presenterNamed: #confirmNumber) state).
	].

	
]

{ #category : #tests }
APxEnablementExampleTest >> testCorrectStateAfterReenabledInput [

	self
		performTest: [ :part :form | 
			(form presenterNamed: #stringField) text: 'Joe'.
			(form presenterNamed: #intField) text: '12'.
			(form presenterNamed: #confirmString) state: true.
			(form presenterNamed: #confirmNumber) state: true.
			(form presenterNamed: #clearNumber) performAction.
			self deny: (form presenterNamed: #confirmNumber) state.
			self deny: (form presenterNamed: #confirmNumber) isEnabled.
			(form presenterNamed: #intField) text: '12'.
			self deny: (form presenterNamed: #confirmNumber) state.
			self assert: (form presenterNamed: #confirmNumber) isEnabled ]
]

{ #category : #tests }
APxEnablementExampleTest >> testDisabled [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #disableInput) state: true.
			self deny: (form presenterNamed: #stringField) isEnabled.
			self deny: (form presenterNamed: #intField) isEnabled.
			self deny: (form presenterNamed: #confirmString) isEnabled.
			self deny: (form presenterNamed: #confirmNumber) isEnabled.
			self assert: (form presenterNamed: #disableInput) isEnabled.
			self deny: (form presenterNamed: #clearString) isEnabled.
			self deny: (form presenterNamed: #clearNumber) isEnabled.
			self deny: (form presenterNamed: #saveData) isEnabled ]
]

{ #category : #tests }
APxEnablementExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			self assert: (form presenterNamed: #stringField) text isNil.
			self assert: (form presenterNamed: #intField) text isNil.
			self deny: (form presenterNamed: #confirmString) isEnabled.
			self deny: (form presenterNamed: #confirmNumber) isEnabled.
			self assert: (form presenterNamed: #disableInput) isEnabled.
			self deny: (form presenterNamed: #clearString) isEnabled.
			self deny: (form presenterNamed: #clearNumber) isEnabled.
			self deny: (form presenterNamed: #saveData) isEnabled ]
]

{ #category : #tests }
APxEnablementExampleTest >> testValidInvalidString [
	self
		performTest: [ :part :form | 
			(form presenterNamed: #stringField) text: 'a'.
			self assert: (form presenterNamed: #intField) text isNil.
			self deny: (form presenterNamed: #confirmString) isEnabled.
			self deny: (form presenterNamed: #confirmNumber) isEnabled.
			self assert: (form presenterNamed: #disableInput) isEnabled.
			self assert: (form presenterNamed: #clearString) isEnabled.
			self deny: (form presenterNamed: #clearNumber) isEnabled.
			self deny: (form presenterNamed: #saveData) isEnabled ]
]
