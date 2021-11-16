"
APxSubCanvasElementEditPart ist eine Subkomponente für das Beispiel APxSubCanvasCoexistExample.
"
Class {
	#name : #APxSubCanvasElementEditPart,
	#superclass : #APartExample,
	#instVars : [
		'selectedElement',
		'name'
	],
	#category : #'APart Examples-SubCanvasCoexist'
}

{ #category : #'initialize-release' }
APxSubCanvasElementEditPart >> defineAspects [

	partInterface description createAspectNamed: #name.
	self at: #isDirty putCondition: APCondition false
]

{ #category : #'initialize-release' }
APxSubCanvasElementEditPart >> initializeActions [

	partInterface description
		createAction: #save
		do: [selectedElement name: name]
		if: (APCondition on: [self isDirty] ifNot: #NoChange)
]

{ #category : #testing }
APxSubCanvasElementEditPart >> isDirty [

	^selectedElement ifNil: [false] ifNotNil: [selectedElement name ~= name]
]

{ #category : #accessing }
APxSubCanvasElementEditPart >> name [

	^name
]

{ #category : #accessing }
APxSubCanvasElementEditPart >> name: anObject [

	name := anObject.
	self changedAspectValue: #name.
]

{ #category : #private }
APxSubCanvasElementEditPart >> reset [

	self name: selectedElement name.
]

{ #category : #accessing }
APxSubCanvasElementEditPart >> selectedElement: anObject [

	selectedElement := anObject.
	self name: anObject name.
]
