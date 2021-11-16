Class {
	#name : #APxCCPromptExampleTest,
	#superclass : #APxSpecTest,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
APxCCPromptExampleTest >> classToBeTested [

	^ APxCCPromptExample
]

{ #category : #tests }
APxCCPromptExampleTest >> testInitialState [
	self
		performTest: [ :part :form | 
			self assert: (form presenterNamed: #promptYesNo) isEnabled.
			self assert: (form presenterNamed: #promptMulti) isEnabled.
			self assert: (form presenterNamed: #promptSingle) isEnabled.
			self assert: (form presenterNamed: #promptButtons) isEnabled.
			self assert: (form presenterNamed: #promptReport) isEnabled.
			self assert: (form presenterNamed: #promptColor) isEnabled.
			self assert: (form presenterNamed: #promptFile) isEnabled.
			self assert: (form presenterNamed: #promptText) isEnabled.
			self assert: (form presenterNamed: #promptWarning) isEnabled.
			 ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptButtonsNew [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				(specDialog presenterNamed: #button2) click].
			(form presenterNamed: #promptButtons) click.
			self assert: part finalResult equals: #new ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptMulti [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				specDialog contentArea selection selectIndexes: #(1 3). 
				(specDialog presenterNamed: #ok) click].
			(form presenterNamed: #promptMulti) click.
			self assertCollection: part finalResult hasSameElements: #(10 12) ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptMultiCancel [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				specDialog contentArea selection selectIndexes: #(1 3). 
				(specDialog presenterNamed: #cancel) click].
			(form presenterNamed: #promptMulti) click.
			self assert: part finalResult isNil ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptMultiEmpty [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				(specDialog presenterNamed: #ok) click].
			(form presenterNamed: #promptMulti) click.
			self assert: part finalResult isEmpty ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptReport [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				(specDialog presenterNamed: #button1) click].
			(form presenterNamed: #promptReport) click.
			self assert: part finalResult equals: #confirmYes ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptSingle [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				specDialog contentArea selection selectIndex: 3. 
				(specDialog presenterNamed: #ok) click].
			(form presenterNamed: #promptSingle) click.
			self assert: part finalResult equals: 12 ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptSingleCancel [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				specDialog contentArea selection selectIndex: 3. 
				(specDialog presenterNamed: #cancel) click].
			(form presenterNamed: #promptSingle) click.
			self assert: part finalResult isNil ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptText [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				specDialog contentArea text: 'some text'.
				(specDialog presenterNamed: #ok) click].
			(form presenterNamed: #promptText) click.
			self assert: part finalResult equals: 'some text' ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptTextEmpty [
	self
		performTest: [ :part :form | 
			form client promptExecutor postOpenAction: [ :specDialog |
				(specDialog presenterNamed: #ok) click].
			(form presenterNamed: #promptText) click.
			self assert: part finalResult equals: 'initial text' ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptWarning [
	self skip.
	
	self
		performTest: [ :part :form | 
			| dialog |
			(form presenterNamed: #promptWarning) click.
			self assert: form application windows size equals: 2.
			dialog := form application windows detect: #isDialog.
			(dialog presenter presenterNamed: #ok) click.
			self assert: form application windows size equals: 1. 			 ]
]

{ #category : #tests }
APxCCPromptExampleTest >> testPromptYesNo [
	self
		performTest: [ :part :form | 
			| dialog |
			(form presenterNamed: #promptYesNo) click.
			self assert: form application windows size equals: 2.
			dialog := form application windows detect: #isDialog.
			self assert: (dialog presenter presenterNamed: #yes) label asString equals: 'Yes'
			 ]
]
