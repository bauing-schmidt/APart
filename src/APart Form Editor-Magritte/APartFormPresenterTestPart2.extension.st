Extension { #name : #APartFormPresenterTestPart2 }

{ #category : #'*APart Form Editor-Magritte' }
APartFormPresenterTestPart2 class >> test [ 

	<script>	

	| desc editorPart visitor app presenter json previewPart |

	desc := MAStringDescription new magritteDescription.

	editorPart := ApedFormEditorPart createWithClientRegistry.

	visitor := ApedMAVisitor new.
	visitor editor: editorPart.
	visitor visit: desc.

	app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.
	editorPart locale: APartLocaleDeDE new.
	presenter := ApedFormEditor openOnPart: editorPart application: app.

	json := editorPart form printJson.

	previewPart := APartFormPresenterTestPart2 createWithClientRegistry.
	previewPart loadFormFrom: json readStream.
	APartFormPresenter openOnPart: previewPart application: app.

]
