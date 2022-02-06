Class {
	#name : #APartTestForm,
	#superclass : #APartPresenter,
	#instVars : [
		'personName'
	],
	#category : #'APart PharoTests-Support'
}

{ #category : #'interface opening' }
APartTestForm class >> createRootPart [

	^self matchingPartClass createWithClientRegistry
]

{ #category : #specs }
APartTestForm class >> defaultLayout [
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
APartTestForm class >> guiClientClass [

	^APartSpecStubGUIClient
]

{ #category : #'interface opening' }
APartTestForm class >> matchingPartClass [

	^APartTestFormPart
]

{ #category : #'interface opening' }
APartTestForm class >> open [

	^self openOnPart: self createRootPart
]

{ #category : #'interface opening' }
APartTestForm class >> openWithSpec: aSymbol [
	"Convenience to open views with RootState directly from windowSpec method"
	
	^self openOnPart: self createRootPart withSpec: aSymbol
]

{ #category : #initialization }
APartTestForm >> associatedPresenters [

	^ OrderedDictionary newFrom: { 
		#firstName -> [ self newTextInput ].
		#lastName -> [ self newTextInput ].
		#cancelEdit -> [ self newButton label: 'cancelEdit' ].
		#saveData -> [ self newButton label: 'saveData' ].
		#clearFirstName -> [ self newButton label: 'clearFirstName' ].
		#clearLastName -> [ self newButton label: 'clearLastName' ].
	 }.

]
