"
APRequestNewFileNamePrompt liefert den Filenamen für eine neue Datei.
"
Class {
	#name : #APRequestNewFilenamePrompt,
	#superclass : #APFileChoosePrompt,
	#instVars : [
		'default',
		'value'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APRequestNewFilenamePrompt >> default [

	^default
]

{ #category : #accessing }
APRequestNewFilenamePrompt >> default: anObject [

	default := anObject
]

{ #category : #'initialize-release' }
APRequestNewFilenamePrompt >> defaultPromptSelector [

	^#requestNewFilename:
]

{ #category : #testing }
APRequestNewFilenamePrompt >> isMultipleSelection [ 

	^false
]

{ #category : #converting }
APRequestNewFilenamePrompt >> okButtonString [

	^(self pdmTranslateDeferred: 'Save') string 
]

{ #category : #accessing }
APRequestNewFilenamePrompt >> value [

	^value
]

{ #category : #accessing }
APRequestNewFilenamePrompt >> value: anObject [

	value := anObject
]
