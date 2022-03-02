"
I am a description of a drop list presenter
"
Class {
	#name : #ApedDropListPresenterPart,
	#superclass : #ApedListWidgetPart,
	#instVars : [
		'hasEntry'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedDropListPresenterPart class >> iconName [

	^ #tcombobox
]

{ #category : #accessing }
ApedDropListPresenterPart class >> label [ 

	^ 'Drop-down list'
]

{ #category : #visiting }
ApedDropListPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitDropList: self
]

{ #category : #accessing }
ApedDropListPresenterPart >> hasEntry [
	^ hasEntry
]

{ #category : #accessing }
ApedDropListPresenterPart >> hasEntry: aBoolean [
	hasEntry := aBoolean
]

{ #category : #'as yet unclassified' }
ApedDropListPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	hasEntry  := (aJsonObj at: #hasEntry ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedDropListPresenterPart >> initializeValues [

	super initializeValues.

	hasEntry := false.
	self partInterface description createAspectNamed: #hasEntry.	
	self addDependentToAspects
]

{ #category : #preview }
ApedDropListPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#hasEntry -> self hasEntry.	
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedDropListPresenterPart >> newPreviewPresenterOn: aPresenter [

	^self hasEntry 
	ifTrue: [aPresenter newDropListWithEntry]
	ifFalse: [aPresenter newDropList]
]
