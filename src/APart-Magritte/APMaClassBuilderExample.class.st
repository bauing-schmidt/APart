Class {
	#name : #APMaClassBuilderExample,
	#superclass : #Object,
	#instVars : [
		'description',
		'editorPart',
		'app'
	],
	#classInstVars : [
		'description'
	],
	#category : #'Apart-Magritte'
}

{ #category : #'class initialization' }
APMaClassBuilderExample >> editClass [

	APMaTest editInGtk
]

{ #category : #'class initialization' }
APMaClassBuilderExample >> editForm [

	| visitor presenter |

	description := APMaTest basicNew magritteDescription.

	editorPart := ApedFormEditorPart createWithClientRegistry.

	visitor := ApedMAVisitor new.
	visitor editor: editorPart.
	visitor visit: description.

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.
	editorPart locale: APartLocaleDeDE new.
	presenter := ApedFormEditor openOnPart: editorPart application: app.
]

{ #category : #'class initialization' }
APMaClassBuilderExample >> useForm [

	| json previewPart |
	json := editorPart form printJson.

	previewPart := APMaTest createWithClientRegistry.
	previewPart loadFormFrom: json readStream.
	APartFormPresenter openOnPart: previewPart application: app.
]
