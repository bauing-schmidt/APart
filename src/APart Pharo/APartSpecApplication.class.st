Class {
	#name : #APartSpecApplication,
	#superclass : #SpApplication,
	#instVars : [
		'aPartGuiClient'
	],
	#category : #'APart Pharo'
}

{ #category : #accessing }
APartSpecApplication >> aPartGuiClient [
	^ aPartGuiClient
]

{ #category : #accessing }
APartSpecApplication >> aPartGuiClient: anObject [
	aPartGuiClient := anObject
]

{ #category : #accessing }
APartSpecApplication >> locale [ 

	^ aPartGuiClient locale
]

{ #category : #'ui dialogs' }
APartSpecApplication >> selectExistingFileFrom: aPromptPart [

	^ self backend selectExistingFileFrom: aPromptPart
]

{ #category : #'ui dialogs' }
APartSpecApplication >> selectNewFileFrom: aPromptPart [

	^ self backend selectNewFileFrom: aPromptPart
]

{ #category : #accessing }
APartSpecApplication >> windowClosed: aWindowPresenter [
	
	aWindowPresenter windowIsClosing.
	^ super windowClosed: aWindowPresenter.

]
