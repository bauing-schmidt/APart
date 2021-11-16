"
APxListComboBoxExamplePart demonstrates how to connect a combobox widget to APartList instance using the APartList key as the combo box id.





"
Class {
	#name : #APxListComboBoxExamplePart,
	#superclass : #APxListExamplePart,
	#category : #'APart Examples-ListComboBox'
}

{ #category : #'initialize-release' }
APxListComboBoxExamplePart >> removeSelection [

	super removeSelection.
	numbersList selectionIndex: 0.
]

{ #category : #'initialize-release' }
APxListComboBoxExamplePart >> requestSelectionChange [

	| answer |
	(APConfirmationYesNo onPart: self)
		title: #RequestSelectionChange;
		message: #ShallChangeSelection, '?';
		trigger: #confirmYes do: [answer := true];
		trigger: #confirmNo do: [answer := false];
		openClientPrompt.
	^answer
]
