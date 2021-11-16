Class {
	#name : #APartTestFormWithSubAppConfiguration,
	#superclass : #APartTestFormPart,
	#instVars : [
		'subAppConfiguration'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #initialization }
APartTestFormWithSubAppConfiguration >> createSubAppConfiguration [

	^ subAppConfiguration := APartSubAppConfiguration subCanvasKey: #aConfigurationKey.
]

{ #category : #accessing }
APartTestFormWithSubAppConfiguration >> initializeValues [

	self createSubAppConfiguration.
]

{ #category : #accessing }
APartTestFormWithSubAppConfiguration >> subAppConfiguration [

	^subAppConfiguration
]
