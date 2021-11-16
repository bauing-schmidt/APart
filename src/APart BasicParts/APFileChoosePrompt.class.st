Class {
	#name : #APFileChoosePrompt,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'filterColl',
		'folderColl',
		'suggestedFilename'
	],
	#category : #'APart BasicParts'
}

{ #category : #adding }
APFileChoosePrompt >> addFilter: aGtkFileFilter [

	filterColl ifNil: [filterColl := OrderedCollection new].
	filterColl add: aGtkFileFilter
]

{ #category : #adding }
APFileChoosePrompt >> addFolder: aFolderPath [

	folderColl ifNil: [folderColl := OrderedCollection new].
	folderColl add: aFolderPath 
]

{ #category : #converting }
APFileChoosePrompt >> cancelButtonString [

	^(self pdmTranslateDeferred: 'Cancel') string 
]

{ #category : #accessing }
APFileChoosePrompt >> filterColl [
	^ filterColl
]

{ #category : #accessing }
APFileChoosePrompt >> folderColl [
	^ folderColl
]

{ #category : #testing }
APFileChoosePrompt >> isMultipleSelection [ 

	self subclassResponsibility 
]

{ #category : #accessing }
APFileChoosePrompt >> suggestedFilename [
	^ suggestedFilename
]

{ #category : #accessing }
APFileChoosePrompt >> suggestedFilename: aFilename [
	suggestedFilename := aFilename
]

{ #category : #converting }
APFileChoosePrompt >> titleString [

	^self title string 
]
