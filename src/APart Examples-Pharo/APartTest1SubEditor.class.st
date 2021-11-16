"
part := APartTest1SubEditor createRootPart.
ui := APartTest1SubEditor openOnPart:  part.
"
Class {
	#name : #APartTest1SubEditor,
	#superclass : #APartPresenter,
	#instVars : [
		'personName'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #'interface opening' }
APartTest1SubEditor class >> createRootPart [

	^self matchingPartClass createWithClientRegistry
]

{ #category : #specs }
APartTest1SubEditor class >> defaultSpec [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.

	aLayout add: #firstName.
	aLayout add: #lastName.
	aLayout add: #cancelEdit.
	aLayout add: #saveData.
	aLayout add: #clearFirstName.
	aLayout add: #clearLastName.
	
	^ aLayout

]

{ #category : #'interface opening' }
APartTest1SubEditor class >> matchingPartClass [
	"Muss in Subklassen definiert werden"

	^APartTest1SubEditorPart
]

{ #category : #'interface opening' }
APartTest1SubEditor class >> open [

	^self openOnPart: self createRootPart
]

{ #category : #'interface opening' }
APartTest1SubEditor class >> openWithSpec: aSymbol [
	"Convenience to open views with RootState directly from windowSpec method"
	
	^self openOnPart: self createRootPart withSpec: aSymbol
]

{ #category : #initialization }
APartTest1SubEditor >> associatedPresenters [

	^ OrderedDictionary newFrom: { 
		#firstName -> [ self newTextInput ].
		#lastName -> [ self newTextInput ].
		#cancelEdit -> [ self newButton label: 'cancelEdit' ].
		#saveData -> [ self newButton label: 'saveData' ].
		#clearFirstName -> [ self newButton label: 'clearFirstName' ].
		#clearLastName -> [ self newButton label: 'clearLastName' ].
	 }.

]
