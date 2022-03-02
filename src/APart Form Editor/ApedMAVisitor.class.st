"
```
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


 
```
"
Class {
	#name : #ApedMAVisitor,
	#superclass : #MAVisitor,
	#instVars : [
		'editor',
		'grid',
		'lastRowIndex'
	],
	#category : #'APart Form Editor-Magritte'
}

{ #category : #accessing }
ApedMAVisitor >> addLabel: aString element: anElement [

	| label elementNodeLayout labelNodeLayout | 

	label := editor addElementOf: ApedLabelPresenterPart.
	label label: aString.
	label aspect: anElement aspect, 'Label'.
	label presenterId traceCr.
	
	lastRowIndex := lastRowIndex + 1.
	
	labelNodeLayout := editor addPresenterOf: label class to: grid presenter: label.
	labelNodeLayout layoutChild x: 1; y: lastRowIndex.
	
	elementNodeLayout := editor addPresenterOf: anElement class to: grid presenter: anElement.
	elementNodeLayout layoutChild x: 2; y: lastRowIndex; spanX: 4.

]

{ #category : #accessing }
ApedMAVisitor >> editor [

	^ editor
]

{ #category : #accessing }
ApedMAVisitor >> editor: anObject [

	editor := anObject
]

{ #category : #accessing }
ApedMAVisitor >> visitBooleanDescription: anObject [

	| element | 

	element := editor addElementOf: ApedCheckBoxPresenterPart named: anObject aspect aspectName.	
	self addLabel: anObject label element: element.

]

{ #category : #accessing }
ApedMAVisitor >> visitContainer: aContainer [

	grid := self editor form addLayoutOf: ApedGridLayoutPart to: nil.
	grid columnHomogeneous: true.
	lastRowIndex := 0.

	aContainer do: [ :each |
		self visit: each copy ]
]

{ #category : #'visiting-description' }
ApedMAVisitor >> visitDescription: anObject [

	('Unknown description kind: ', anObject class name) traceCr.

	"self error: #unknownDescription"
]

{ #category : #accessing }
ApedMAVisitor >> visitMultipleOptionDescription: anObject [

	| element | 

	element := editor addElementOf: ApedListPresenterPart named: anObject aspect aspectName.
	self addLabel: anObject label element: element.

]

{ #category : #accessing }
ApedMAVisitor >> visitNumberDescription: anObject [

	| element | 

	element := editor addElementOf: ApedNumberInputFieldPresenterPart named: anObject aspect aspectName.	
	self addLabel: anObject label element: element.

]

{ #category : #accessing }
ApedMAVisitor >> visitSingleOptionDescription: anObject [

	| element | 

	element := editor addElementOf: ApedDropListPresenterPart named: anObject aspect aspectName.	
	self addLabel: anObject label element: element.

]

{ #category : #accessing }
ApedMAVisitor >> visitStringDescription: anObject [

	| element | 

	element := editor addElementOf: ApedTextInputFieldPresenterPart named: anObject aspect aspectName.	
	self addLabel: anObject label element: element.
	element placeholder: anObject placeholder.
	element editable: anObject readOnly not.
	element isPassword: anObject password.

]

{ #category : #accessing }
ApedMAVisitor >> visitSymbolDescription: anObject [

	| element | 

	element := editor addElementOf: ApedTextInputFieldPresenterPart named: anObject aspect aspectName.	
	self addLabel: anObject label element: element.

]

{ #category : #accessing }
ApedMAVisitor >> visitToOneRelationDescription: anObject [

	| element | 

	element := editor addElementOf: ApedListPresenterPart named: anObject aspect aspectName.		
	self addLabel: anObject label element: element.

]
