Class {
	#name : #APartWithForm,
	#superclass : #APart,
	#instVars : [
		'form'
	],
	#category : #'APart Form Editor-Support'
}

{ #category : #'initialize-release' }
APartWithForm >> defineAspects [ 

	super defineAspects.

	partInterface description 
		createAllAspectsNamed: #(textInputField1 checkBox1)
]

{ #category : #accessing }
APartWithForm >> elementIDsEnumeration [

	^ form elementIDsEnumeration
]

{ #category : #accessing }
APartWithForm >> form: anObject [
	form := anObject
]

{ #category : #'initialize-release' }
APartWithForm >> formPart [ 

	^ form
]

{ #category : #'initialize-release' }
APartWithForm >> initializeActions [

	partInterface description
		createAction: #doSomething
		do: [ self inspect ]
		if: APCondition true
]

{ #category : #'initialize-release' }
APartWithForm >> initializeValues [ 

	form := ApedFormEditorPart onPart: self key: #form.
	
]

{ #category : #'initialize-release' }
APartWithForm >> loadFormFrom: aStream [ 

	| jsonObject |
	jsonObject := APJsonParser parseStream: aStream.
	self removeSubPartForKey: #form.
	form := ApedFormPart onPart: self key: #form.
	form initOnJson: jsonObject.
	
		
	
]
