"
This class allows multiple selection in a GtkFileChooserDialog and returns the list of the selected files.
"
Class {
	#name : #APRequestMultipleExistingFilenamesPrompt,
	#superclass : #APRequestExistingFilenamePrompt,
	#category : #'APart BasicParts'
}

{ #category : #testing }
APRequestMultipleExistingFilenamesPrompt >> isMultipleSelection [ 

	^true
]

{ #category : #accessing }
APRequestMultipleExistingFilenamesPrompt >> values [ 

	^self value
]
