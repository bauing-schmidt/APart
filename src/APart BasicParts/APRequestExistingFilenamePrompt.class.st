"
APRequestExistingFilenamePrompt liefert den Filenamen für eine existierende Datei.
"
Class {
	#name : #APRequestExistingFilenamePrompt,
	#superclass : #APFileChoosePrompt,
	#instVars : [
		'default',
		'value'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APRequestExistingFilenamePrompt >> default [

	^default
]

{ #category : #accessing }
APRequestExistingFilenamePrompt >> default: anObject [

	default := anObject
]

{ #category : #'initialize-release' }
APRequestExistingFilenamePrompt >> defaultPromptSelector [

	^#requestExistingFilename:
]

{ #category : #testing }
APRequestExistingFilenamePrompt >> isMultipleSelection [ 

	^false
]

{ #category : #accessing }
APRequestExistingFilenamePrompt >> okButtonString [ 
	
	^(self pdmTranslateDeferred: 'Open') string 
]

{ #category : #accessing }
APRequestExistingFilenamePrompt >> value [

	^value
]

{ #category : #accessing }
APRequestExistingFilenamePrompt >> value: anObject [

	value := anObject
]
