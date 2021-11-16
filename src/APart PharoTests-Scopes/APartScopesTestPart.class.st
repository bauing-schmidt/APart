Class {
	#name : #APartScopesTestPart,
	#superclass : #APart,
	#instVars : [
		'performedActions',
		'aspectInRoot'
	],
	#category : #'APart PharoTests-Scopes'
}

{ #category : #testing }
APartScopesTestPart class >> canStartStandalone [
	^false
]

{ #category : #accessing }
APartScopesTestPart >> aspectInRoot [
	^ aspectInRoot
]

{ #category : #accessing }
APartScopesTestPart >> aspectInRoot: anObject [
	aspectInRoot := anObject
]

{ #category : #'initialize-release' }
APartScopesTestPart >> autoAspectDefinition [

	^ true
]

{ #category : #'initialize-release' }
APartScopesTestPart >> initializeValues [

	super initializeValues.

	performedActions := OrderedCollection new.
	
	aspectInRoot := #aspectInRoot.
	self partInterface description createAspectNamed: #aspectInRoot.

	
	
	
]

{ #category : #'initialize-release' }
APartScopesTestPart >> logAction: aSymbol [
	aSymbol traceCr.
	performedActions add: aSymbol
]
