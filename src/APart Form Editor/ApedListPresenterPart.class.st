"
I am a description of a list presenter
"
Class {
	#name : #ApedListPresenterPart,
	#superclass : #ApedListWidgetPart,
	#instVars : [
		'allowToSelect',
		'autoDeselect'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedListPresenterPart class >> iconName [

	^ #tlistbox
]

{ #category : #accessing }
ApedListPresenterPart class >> label [ 

	^ 'List'
]

{ #category : #visiting }
ApedListPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitList: self
]

{ #category : #accessing }
ApedListPresenterPart >> allowToSelect [
	^ allowToSelect
]

{ #category : #accessing }
ApedListPresenterPart >> allowToSelect: anObject [
	allowToSelect := anObject
]

{ #category : #accessing }
ApedListPresenterPart >> autoDeselect [
	^ autoDeselect
]

{ #category : #accessing }
ApedListPresenterPart >> autoDeselect: anObject [
	autoDeselect := anObject
]

{ #category : #accessing }
ApedListPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	allowToSelect := (aJsonObj at: #allowToSelect ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	autoDeselect := (aJsonObj at: #autoDeselect ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedListPresenterPart >> initializeValues [

	super initializeValues.
	
	autoDeselect := true.
	allowToSelect := true.

	self partInterface description createAspectNamed: #allowToSelect.	
	self partInterface description createAspectNamed: #autoDeselect.
	self addDependentToAspects
]

{ #category : #accessing }
ApedListPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#allowToSelect -> self allowToSelect.
		#autoDeselect -> self autoDeselect.
	}.
	
	^ assocs 
]

{ #category : #preview }
ApedListPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newList
]
