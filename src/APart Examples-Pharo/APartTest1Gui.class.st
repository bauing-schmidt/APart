"
part := APartTest1Gui createRootPart.
part personName: 'Martinka'.
ui := APartTest1Gui openOnPart:  part.

part personName: 'Richard'.
part changedAllAspectValues.
"
Class {
	#name : #APartTest1Gui,
	#superclass : #APartPresenter,
	#instVars : [
		'personName'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #'interface opening' }
APartTest1Gui class >> createRootPart [

	^self matchingPartClass createWithClientRegistry
]

{ #category : #specs }
APartTest1Gui class >> defaultLayout [
	<spec>
	
	| aLayout |
	
	aLayout := SpBoxLayout newVertical.

	aLayout add: #personName.
		
	^ aLayout
]

{ #category : #'interface opening' }
APartTest1Gui class >> matchingPartClass [
	"Muss in Subklassen definiert werden"

	^APartTest1
]

{ #category : #'interface opening' }
APartTest1Gui class >> open [

	^self openOnPart: self createRootPart
]

{ #category : #'interface opening' }
APartTest1Gui class >> openWithSpec: aSymbol [
	"Convenience to open views with RootState directly from windowSpec method"
	
	^self openOnPart: self createRootPart withSpec: aSymbol
]

{ #category : #initialization }
APartTest1Gui >> associatedPresenters [

	^ OrderedDictionary newFrom: { 
		#personName -> [ self newTextInput ].
	 }
]
