Class {
	#name : #APartFormPresenterTestPart,
	#superclass : #APart,
	#instVars : [
		'form',
		'textInputField1',
		'checkBox1'
	],
	#category : #'APart Form Editor-Support'
}

{ #category : #accessing }
APartFormPresenterTestPart >> checkBox1 [
	^ checkBox1
]

{ #category : #accessing }
APartFormPresenterTestPart >> checkBox1: anObject [
	checkBox1 := anObject
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart >> defineAspects [ 

	super defineAspects.

	partInterface description 
		createAllAspectsNamed: #(textInputField1 checkBox1)
]

{ #category : #accessing }
APartFormPresenterTestPart >> elementIDsEnumeration [

	^ form elementIDsEnumeration
]

{ #category : #accessing }
APartFormPresenterTestPart >> form: anObject [
	form := anObject
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart >> formPart [ 

	^ form
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart >> initializeActions [

	partInterface description
		createAction: #doSomething
		do: [ self inspect ]
		if: APCondition true
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart >> initializeValues [ 

	form := ApedFormEditorPart onPart: self key: #form.
	
	('3.json' asFileReference) readStreamDo: [ :aStream |
		self loadFormFrom: aStream ].
	
	textInputField1 := 'textInputField1 init value'.
	checkBox1 := false.
	
	
	
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart >> loadFormFrom: aStream [ 

	| jsonObject |
	jsonObject := APJsonParser parseStream: aStream.
	self removeSubPartForKey: #form.
	form := ApedFormPart onPart: self key: #form.
	form initOnJson: jsonObject.
	
		
	
]

{ #category : #accessing }
APartFormPresenterTestPart >> textInputField1 [
	^ textInputField1
]

{ #category : #accessing }
APartFormPresenterTestPart >> textInputField1: anObject [
	textInputField1 := anObject
]
