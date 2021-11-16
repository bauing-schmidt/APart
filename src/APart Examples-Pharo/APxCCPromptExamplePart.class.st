Class {
	#name : #APxCCPromptExamplePart,
	#superclass : #APartExample,
	#instVars : [
		'finalResult',
		'labels',
		'values'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> finalResult [

	^ finalResult
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> initialize [ 

	super initialize.

	labels := #(a b c d e f).
	values := #(10 11 12 13 14 15).
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> initializeActions [


	self promptYesNo.		
	self promptMulti.
	self promptSingle.
	self promptButtons.
	self promptReport.
	self promptColor.
	self promptFile.
	self promptText.
	self promptMultilineText.
	self promptWarning.

]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptButtons [
		
	partInterface description createAction: #promptButtons
		do: [| prompt |
			prompt :=(APSingleChoiceButtonsPrompt onPart: self key: #selectButtons)
				message: 'Choose one';
				labels: #('Override' 'New' 'Cancel');
				values: #(override new cancel).
			prompt openClientPrompt.
			finalResult := prompt selectedValues.
			Transcript show: prompt selectedValues; cr.
			].

]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptColor [

	partInterface description createAction: #promptColor
		do: 
			[
				| result |
				result := nil.
				(APRequestColorValuePrompt onPart: self)
				value: Color red;
				trigger: #colorSelected
					withPartDo: [:promptPart | result := promptPart value];
				openClientPrompt.
				finalResult := result.
				Transcript show: result].
			

]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptFile [

	partInterface description createAction: #promptFile
		do: 
			[| prompt |
			prompt :=(APRequestNewFilenamePrompt onPart: self)
				title: 'Choose new file name'.
			prompt openClientPrompt.
			Transcript show: prompt value; cr.].
	
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptMulti [

	"here the test we call directly #openClientPrompt and do not preserve the reference to the prompt part. 
	In this case is REQUIRED to specify triggers!"
	partInterface description createAction: #promptMulti
		do: [| result |
			result := nil.
				(APMultiChoicePrompt onPart: self key: #selectMulti)
				message: 'Choose some';
				title: 'Question';
				labels: labels;
				values: values;
				trigger: #continueOk withPartDo: [ :promptPart | result := promptPart selectedValues ];
				openClientPrompt.
			finalResult := result. 
			Transcript show: result; cr.
			].

]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptMultilineText [
		
	partInterface description  createAction: #promptMultilineText
		do: 
			[| prompt |
			prompt :=(APMultilineTextPrompt onPart: self)
				title: #Umbenennen;
				message: #EnterNewName;
				value: 'initial text'.
			prompt openClientPrompt.
			finalResult := prompt value.
			Transcript show: prompt value; cr.].
	
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptReport [
		
	partInterface description createAction: #promptReport
		do: [| prompt |
			prompt :=(APReportConfirmationYesNo onPart: self key: #selectSingle)
				report: 'line one\line two\line three' withCRs;
				message: 'Choose one'.

			prompt openClientPrompt.
			finalResult := prompt value.
			Transcript show: prompt value; cr.
			].
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptSingle [

	"here we preserve the reference to the prompt part so we can ask the anwered value. It is nil in case of canceling"
	partInterface description  createAction: #promptSingle
		do: [| prompt |
			prompt :=(APSingleChoicePrompt onPart: self key: #selectSingle)
				message: 'Choose one';
				title: 'Question';
				labels: labels;
				values: values.
			prompt openClientPrompt.
			finalResult := prompt selectedValues. 
			Transcript show: prompt selectedValues; cr.
			].
	
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptText [
		
	partInterface description  createAction: #promptText
		do: 
			[| prompt |
			prompt :=(APTextPrompt onPart: self)
				title: #Umbenennen;
				message: #EnterNewName;
				value: 'initial text'.
			prompt openClientPrompt.
			finalResult := prompt value.
			Transcript show: prompt value; cr.].
	
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptWarning [

	partInterface description createAction: #promptWarning
		do: 
			[(APWarningPrompt onPart: self)
				title: #WarningTitle;
				message: #WarningText;
				openClientPrompt. ]
]

{ #category : #'initialize-release' }
APxCCPromptExamplePart >> promptYesNo [

	partInterface description createAction: #promptYesNo
		do: 
			[(APConfirmationYesNo onPart: self)
			trigger: #confirmYes do: [ 
					finalResult := #yes. 
					Transcript show: 'yes'; cr.];
				trigger: #confirmNo do: [ 
					finalResult := #yes. 
					Transcript show: 'no'; cr.];
				title: 'Data storing';
				message: 'Save?';
				openClientPrompt].
		
]
