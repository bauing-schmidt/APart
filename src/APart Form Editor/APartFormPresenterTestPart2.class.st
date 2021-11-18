"
desc := MAStringDescription new magritteDescription.

editorPart := ApedFormEditorPart createWithClientRegistry.

""elm := editorPart addElementOf: ApedTextInputFieldPresenterPart.
""
visitor := ApedMAVisitor new.
visitor editor: editorPart.
visitor visit: desc.

app := APartSpecApplication new.
app useBackend: #Gtk with: ApartGtkConfiguration new.
editorPart locale: APartLocaleDeDE new.
presenter := ApedFormEditor openOnPart: editorPart application: app.

json := editorPart form printJson.

editorPart form rootLayout.

previewPart := APartFormPresenterTestPart2 createWithClientRegistry.
""previewPart form: editorPart form.""
previewPart loadFormFrom: json readStream.

previewWindow := APartFormPresenter openOnPart: previewPart application: app.
previewWindow presenter layout: editorPart form rootLayout previewLayout.

"
Class {
	#name : #APartFormPresenterTestPart2,
	#superclass : #APartFormPresenterTestPart,
	#category : #'APart Form Editor-Support'
}

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> defineAspects [

	partInterface description createAllAspectsNamed: #(textInputField1 textInputField2  textInputField3 textInputField4 textInputField5 textInputField6)
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> initializeValues [ 

	super initializeValues.
	
	textInputField1 := 'label 1 content'
	
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField1 [ 

	^ ''
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField1: anObject [


]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField2 [

	^ ''
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField2: anObject [


]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField3 [

	^ ''
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField3: anObject [


]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField4 [

	^ ''
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField4: anObject [


]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField5 [

	^ ''
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField5: anObject [


]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField6 [

	^ ''
]

{ #category : #'initialize-release' }
APartFormPresenterTestPart2 >> textInputField6: anObject [


]
