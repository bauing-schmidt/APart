"
SUTAPxGenericTC ist eine generische Testklasse für SingleParts, in der alle per Recording zusammengestellten Tests für APx*ExampleParts hinterlegt sind. Diese Tests dienen zur Validierung der APart-Beispiele und müssen daher bei Änderungen an den Beispielen angepasst werden.
"
Class {
	#name : #SUTAPxGenericTC,
	#superclass : #SUTAPGenericSinglePartTC,
	#category : #'APart Tests'
}

{ #category : #testing }
SUTAPxGenericTC >> testAPxComplexPromptExamplePart [
	<
	name: #testAPxComplexPromptExamplePart
	title: 'testAPxComplexPromptExamplePart'
	parents: #(#SUTAP #SUTAPxGenericTC)
	keyWords: #(#Prompt)
	spec: #(#fast)>

	| shallRunHeadless shallWaitForYesNoPrompt |
	shallRunHeadless := false.
	shallWaitForYesNoPrompt := false. "true: wait for manually answering YesNoPrompt"
	self createPartAndClientFor: APxComplexPromptExamplePart.
	self afterDoing: 	[
		shallRunHeadless
			ifTrue: [self currentPart rootUpdateAll]
			ifFalse: [self currentPart openClient].
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#firstName #lastName)
				expectAllActive: #(#editModal #editNormal)
	].
	self
		afterDoing: [
			self
				execute: #editModal preparing: [
					self
						inPrompt: #editorModal do: [
							self
								afterDoing: [
									self
										setAspect: #firstName value: 'ab'.
								]
								expectStates: [
									APExpectedStates
										expectAllInactive: #()
										expectAllActive: #(#cancelEdit #clearFirstName #clearLastName #firstName #lastName #saveData)
							].
							self
								afterDoing: [
									self
										execute: #clearFirstName.
											"setAspect: #firstName value: nil"
								]
								expectStates: [
									APExpectedStates
										expectAllInactive: #(#clearFirstName #saveData)
										expectAllActive: #(#cancelEdit #clearLastName #firstName #lastName)
							].
							self
								afterDoing: [
									self
										setAspect: #firstName value: 'asdf'.
								]
								expectStates: [
									APExpectedStates
										expectAllInactive: #()
										expectAllActive: #(#cancelEdit #clearFirstName #clearLastName #firstName #lastName #saveData)
							].
							self
								afterDoing: [
									self
										execute: #saveData preparing: [
											shallWaitForYesNoPrompt ifFalse: [ 
												self preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmYes).
											].
										]. 	"End of #saveData"
								]
								expectStates: [
									APExpectedStates
										expectAllInactive: #()
										expectAllActive: #(#saveData #cancelEdit #clearFirstName #clearLastName #firstName #lastName)
							].
						]. 	"Prompt closed"

				]. 	"End of #editModal"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#firstName #lastName)
				expectAllActive: #(#editModal #editNormal)
	].
	self closePartAndClients
]

{ #category : #testing }
SUTAPxGenericTC >> testAPxEnablementExamplePart [
	<
	name: #testAPxEnablementExamplePart
	title: 'testAPxEnablementExamplePart'
	parents: #(#SUTAP #SUTAPxGenericTC)
	keyWords: #(#Prompt)
	spec: #(#fast)>
	
	self skip.

	self createPartAndClientFor: APxEnablementExamplePart.
	self
		afterDoing: [
			self currentPart openClient.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #clearString #confirmNumber #confirmString #saveData)
				expectAllActive: #(#disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #stringField value: 'ab'.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #confirmNumber #saveData)
				expectAllActive: #(#clearString #confirmString #disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #stringField value: 'bc';
				execute: #clearString.
					"setAspect: #stringField value: nil"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #clearString #confirmNumber #confirmString #saveData)
				expectAllActive: #(#disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #stringField value: 'cd'.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #confirmNumber #saveData)
				expectAllActive: #(#clearString #confirmString #disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #confirmString value: true.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #confirmNumber #saveData)
				expectAllActive: #(#clearString #confirmString #disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #intField value: 12.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#saveData)
				expectAllActive: #(#clearNumber #clearString #confirmNumber #confirmString #disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				execute: #clearNumber.
					"setAspect: #intField value: nil"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #confirmNumber #saveData)
				expectAllActive: #(#clearString #confirmString #disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #intField value: 23.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#saveData)
				expectAllActive: #(#clearNumber #clearString #confirmNumber #confirmString #disableInput #intField #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #confirmNumber value: true.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#clearNumber #clearString #confirmNumber #confirmString #disableInput #intField #saveData #stringField)
	].
	self
		afterDoing: [
			self
				setAspect: #disableInput value: true.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #clearString #confirmNumber #confirmString #intField #stringField)
				expectAllActive: #(#disableInput #saveData)
	].
	self
		afterDoing: [
			self
				setAspect: #disableInput value: false.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#clearNumber #clearString #confirmNumber #confirmString #disableInput #intField #saveData #stringField)
	].
	self
		afterDoing: [
			self
				execute: #saveData preparing: [
					self
						preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmNo).

				]. 	"End of action #saveData"
			self
				execute: #saveData preparing: [
					self
						preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmYes).
						"setAspect: #stringField value: nil"
						"setAspect: #intField value: nil"

				]. 	"End of action #saveData"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearNumber #clearString #confirmNumber #confirmString #saveData)
				expectAllActive: #(#disableInput #intField #stringField)
	].
	self closePartAndClients
]

{ #category : #testing }
SUTAPxGenericTC >> testAPxEnumerationExamplePart [
	<
	name: #testAPxEnumerationExamplePart
	title: 'testAPxEnumerationExamplePart'
	parents: #(#SUTAP #SUTAPxGenericTC)
	keyWords: #(#Prompt)
	spec: #(#fast)>

	self createPartAndClientFor: APxEnumerationExamplePart.
	self
		afterDoing: [
			self currentPart openClient.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#clearResolverMode #resolverMode #resolverModeEnabled #resolverModesList #resolverModeText #selectByList)
	].
	self
		afterDoing: [
			self
				setAspect: #resolverModeEnabled value: false.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearResolverMode #resolverMode #resolverModesList #resolverModeText #selectByList)
				expectAllActive: #(#resolverModeEnabled)
	].
	self
		afterDoing: [
			self
				setAspect: #resolverModeEnabled value: true.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#clearResolverMode #resolverMode #resolverModeEnabled #resolverModesList #resolverModeText #selectByList)
	].
	self
		afterDoing: [
			self
				setAspect: #resolverMode value: #modeResourceResolverExistingRole;
				setAspect: #resolverMode value: #modeResourceResolverExternalPerson;
				execute: #clearResolverMode.
					"setAspect: #resolverMode value: nil"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#clearResolverMode #resolverMode #resolverModeEnabled #resolverModesList #resolverModeText #selectByList)
	].
	self
		afterDoing: [
			self
				execute: #selectByList preparing: [
					self
						preparePromptResult: ((APUnitTestPromptResult controllingFor: #resolverModeChoice trigger: #confirmChoice)
									 value: #modeResourceResolverExternalPerson; yourself).
						"setAspect: #resolverMode value: #modeResourceResolverExternalPerson"

				]. 	"End of #selectByList"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#selectByList)
				expectAllActive: #(#clearResolverMode #resolverMode #resolverModeEnabled #resolverModesList #resolverModeText)
	].
	self
		afterDoing: [
			self
				setAspect: #resolverMode value: #modeResourceResolverOurPerson;
				setAspect: #resolverModeEnabled value: false.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#clearResolverMode #resolverMode #resolverModesList #resolverModeText #selectByList)
				expectAllActive: #(#resolverModeEnabled)
	].
	self
		afterDoing: [
			self
				setAspect: #resolverModeEnabled value: true.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#selectByList)
				expectAllActive: #(#clearResolverMode #resolverMode #resolverModeEnabled #resolverModesList #resolverModeText)
	].
	self
		afterDoing: [
			self
				execute: #clearResolverMode.
					"setAspect: #resolverMode value: nil"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#clearResolverMode #resolverMode #resolverModeEnabled #resolverModesList #resolverModeText #selectByList)
	].
	self closePartAndClients
]

{ #category : #testing }
SUTAPxGenericTC >> testAPxListExamplePart [
	<
	name: #testAPxListExamplePart
	title: 'testAPxListExamplePart'
	parents: #(#SUTAP #SUTAPxGenericTC)
	keyWords: #(#Prompt)
	spec: #(#fast)>
	
	self skip.

	self createPartAndClientFor: APxListExamplePart.
	self
		afterDoing: [
			self currentPart openClient.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#removeSelection #renameSelection)
				expectAllActive: #(#addNumberToList #numbersList #numbersListEnabled #numberToAdd #replaceList #selectNext #selectPrevious)
	].
	self
		afterDoing: [
			self
				callOperator: (SUTAPOperatorSelectionChange for: #numbersList index: 2);
				execute: #renameSelection preparing: [
					self
						preparePromptResult: ((APUnitTestPromptResult controllingFor: #APTextPrompt trigger: #continueOk)
									 value: '22'; yourself).

				]. 	"End of #renameSelection"
			self
				forTrigger: #requestSelectionChange prepare: [
					self
						preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmYes).

				]. 	"End of #requestSelectionChange"
			self
				callOperator: (SUTAPOperatorSelectionChange for: #numbersList index: 3);
				execute: #renameSelection preparing: [
					self
						preparePromptResult: ((APUnitTestPromptResult controllingFor: #APTextPrompt trigger: #continueOk)
									 value: '33'; yourself).

				]. 	"End of #renameSelection"
			self
				execute: #selectPrevious preparing: [
					self
						preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmNo).

				]. 	"End of #selectPrevious"
			self
				execute: #addNumberToList.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#addNumberToList)
				expectAllActive: #(#numbersList #numbersListEnabled #numberToAdd #removeSelection #renameSelection #replaceList #selectNext #selectPrevious)
	].
	self
		afterDoing: [
			self
				forTrigger: #requestSelectionChange prepare: [
					self
						preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmYes).

				]. 	"End of #requestSelectionChange"
			self
				callOperator: (SUTAPOperatorSelectionChange for: #numbersList index: 4);
				execute: #removeSelection.
					"callOperator: (SUTAPOperatorSelectionChange for: #numbersList indexes: #())"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#removeSelection #renameSelection)
				expectAllActive: #(#addNumberToList #numbersList #numbersListEnabled #numberToAdd #replaceList #selectNext #selectPrevious)
	].
	self
		afterDoing: [
			self
				execute: #replaceList.
					"setAspect: #'numbersList listHolder' value: List ('331' '332' '333')"

			self
				execute: #selectNext.
					"callOperator: (SUTAPOperatorSelectionChange for: #numbersList index: 1)"
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #()
				expectAllActive: #(#addNumberToList #numbersList #numbersListEnabled #numberToAdd #removeSelection #renameSelection #replaceList #selectNext #selectPrevious)
	].
	self
		afterDoing: [
			self
				setAspect: #numbersListEnabled value: false.
		]
		expectStates: [
			APExpectedStates
				expectAllInactive: #(#addNumberToList #numbersList #numberToAdd #removeSelection #renameSelection #replaceList #selectNext #selectPrevious)
				expectAllActive: #(#numbersListEnabled)
	].
	self closePartAndClients
]

{ #category : #testing }
SUTAPxGenericTC >> testAPxUIValidationExample [

	<
	name: #testAPxUIValidationExample
	title: 'testAPxUIValidationExample'
	parents: #(#SUTAP #SUTAPxGenericTC)
	keyWords: #(#Prompt)
	spec: #(#fast)>
	
	self skip.

	self createPartAndClientFor: APxUIValidationExamplePart.
	self currentPart openClient.
	self
		afterDoing: 
			[self deny: (self execute: #max20
						with: ((APControllerWrapper new)
								hasEditValue: true;
								editValue: '123456789012345678901';
								aspectKey: #stringInput))
				description: 'Error in validation']
		expectStates: [APExpectedStates create]
		expectValues: 
			[self expectExtraAnnouncement: 
					[:announc |
					(announc isKindOf: APControllerWrapperAnnouncement)
						and: [announc aspectKey = #stringInput]]].
	self
		afterDoing: 
			[self assert: (self execute: #validateHours
						with: ((APControllerWrapper new)
								hasEditValue: true;
								editValue: '10:00';
								aspectKey: #hours))
				description: 'Error in validation'.
			self setAspect: #hours value: '10:00']
		expectStates: [APExpectedStates create]
		expectValues: [].
	self
		afterDoing: 
			[self deny: (self execute: #validateHours
						with: ((APControllerWrapper new)
								hasEditValue: true;
								editValue: '25:00';
								aspectKey: #hours))
				description: 'Error in validation']
		expectStates: [APExpectedStates create]
		expectValues: 
			[].
	self closePartAndClients
]
