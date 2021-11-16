"
Beispiel für einen TestCase, der mit berechneten Bedingungen arbeitet.
"
Class {
	#name : #SUTAPExampleTC,
	#superclass : #SUTAPAbstractTestCase,
	#category : #'APart Tests'
}

{ #category : #'Test steps' }
SUTAPExampleTC >> stepDisableEnableInput [

	self
		afterDoing: [self currentPart disableInput: true]
		expectStates: 
			[APExpectedStates
				expectAllInactive: #(#stringField #intField #clearString #clearNumber #confirmString #confirmNumber)
				expectAllActive: #(#disableInput #saveData)]
		log: 'Step disable input'.
	self
		afterDoing: [self currentPart disableInput: false]
		expectStates: 
			[APExpectedStates expectAllInactive: #()
				expectAllActive: #(#stringField #intField #clearString #clearNumber #confirmString #confirmNumber #disableInput #saveData)]
		log: 'Step enable input'
]

{ #category : #'Test steps' }
SUTAPExampleTC >> stepInput: inputField value: inputValue [

	self afterDoing: [self setAspect: inputField value: inputValue]
		expectStates: 
			[| p eStates |
			p := self currentPart.
			eStates := APExpectedStates create.
			eStates expect: #clearString isActiveWhen: [p stringField size > 0].
			eStates expect: #confirmString isActiveWhen: [p stringField size > 2].
			eStates expect: #clearNumber isActiveWhen: [p intField notNil].
			eStates expect: #confirmNumber
				isActiveWhen: [p intField notNil and: [p intField > 9]].
			eStates expect: #saveData
				isActiveWhen: 
					[p stringField size >= 2 and: 
							[p intField notNil
								and: [p intField > 9 and: [p confirmString and: [p confirmNumber]]]]]]
]

{ #category : #running }
SUTAPExampleTC >> tearDown [
	"utClient bleibt erhalten, falls er noch im Zustand 'Recording' ist. So kann das Recording über das Ende des Test hinaus fortgesetzt werden, muss aber manuell beendet werden.
	Schließen des GUI-Fensters beendet auch das Recording eines zusätzlich vorhandenen utClients"

	super tearDown.
	"testSelector := nil." "This line is commented because it unsurprisingly breaks Dr Test"
	self currentUTClient isRecording ifFalse: [utClientStack := nil].
	partStack := nil
]

{ #category : #testing }
SUTAPExampleTC >> testComputedExpectations [
	"UI-Aktion erforderlich, keine automatische Steuerung des Prompts"
	<
	name: #testComputedExpectations
	title: 'testComputedExpectations: UI-Aktion erforderlich, keine automatische Steuerung des Prompts'
	parents: #(#SUTAP #SUTAPExampleTC)
	keyWords: #(#Expectations)
	spec: #(#work)>
	
	self initPartStackWith: APxEnablementExamplePart createWithClientRegistry.
	self initUTClientStackWith: self createGenericClientOnCurrentPart.

	self skip.

	self
		afterDoing: [self currentPart openClient]
		expectStates: 
			[APExpectedStates
				expectAllInactive: #(#clearString #clearNumber #confirmString #confirmNumber #saveData)
				expectAllActive: #(#stringField #intField #disableInput)]
		log: 'Opening clients'.
	self
		stepInput: #stringField value: 'abc';
		execute: #clearString;
		stepInput: #stringField value: 'def';
		stepInput: #intField value: 9;
		execute: #clearNumber;
		stepInput: #intField value: 10;
		stepInput: #confirmString value: true;
		stepInput: #confirmNumber value: true;
		stepDisableEnableInput;		
		execute: #saveData preparing: [ 
			self preparePromptResult: (APUnitTestPromptResult controllingFor: #APConfirmationYesNo trigger: #confirmYes). ].
	self currentUTClient isRecording: false.
	self closePartAndClients
]
