"
APxSubCanvasGroupEditPart ist eine Subkomponente für das Beispiel APxSubCanvasCoexistExample.
"
Class {
	#name : #APxSubCanvasGroupEditPart,
	#superclass : #APartExample,
	#instVars : [
		'selectedGroup',
		'name',
		'childrenList'
	],
	#category : #'APart Examples-SubCanvasCoexist'
}

{ #category : #accessing }
APxSubCanvasGroupEditPart >> childrenList [

	^childrenList
]

{ #category : #'initialize-release' }
APxSubCanvasGroupEditPart >> defineAspects [

	partInterface description
		createAspectNamed: #name;
		createAspectNamed: #childrenList.
	self at: #isDirty putCondition: APCondition false
]

{ #category : #'initialize-release' }
APxSubCanvasGroupEditPart >> initializeActions [

	partInterface description
		createAction: #save
		do: [selectedGroup name: name]
		if: (APCondition on: [self isDirty] ifNot: #NoChange)
]

{ #category : #'initialize-release' }
APxSubCanvasGroupEditPart >> initializeValues [

	super initializeValues.
	childrenList := APartList onPart: self key: #childrenList
]

{ #category : #testing }
APxSubCanvasGroupEditPart >> isDirty [

	selectedGroup isNil ifTrue: [^false].
	^selectedGroup name ~~ name
]

{ #category : #accessing }
APxSubCanvasGroupEditPart >> name [

	^name
]

{ #category : #accessing }
APxSubCanvasGroupEditPart >> name: anObject [

	name := anObject.
	self changedAspectValue: #name.
]

{ #category : #private }
APxSubCanvasGroupEditPart >> reset [

	self name: selectedGroup name.
	childrenList list: selectedGroup children.
]

{ #category : #accessing }
APxSubCanvasGroupEditPart >> selectedGroup: anObject [

	selectedGroup := anObject.
	self name: anObject name.
	childrenList list: anObject children.
]
