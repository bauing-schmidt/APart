Class {
	#name : #SUTAPxListExampleTest,
	#superclass : #SUTAPGenericSinglePartTC,
	#category : #'APart Examples-Pharo'
}

{ #category : #tests }
SUTAPxListExampleTest >> testAPxListExamplePart [

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
