"
I am a description of a label presenter
"
Class {
	#name : #ApedLabelPresenterPart,
	#superclass : #ApedWidgetPresenterPart,
	#instVars : [
		'label'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedLabelPresenterPart class >> iconName [

	^ #tlabel
]

{ #category : #accessing }
ApedLabelPresenterPart class >> label [ 

	^ 'Label'
]

{ #category : #visiting }
ApedLabelPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitLabel: self
]

{ #category : #accessing }
ApedLabelPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	label := (aJsonObj at: #label ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedLabelPresenterPart >> initializeValues [

	super initializeValues.
	
	self partInterface description 
		createAspectNamed: #label.
		
	self addDependentToAspects
]

{ #category : #accessing }
ApedLabelPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#label -> self label.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedLabelPresenterPart >> label [
	^label ifNil:[self presenterId value]
]

{ #category : #accessing }
ApedLabelPresenterPart >> label: anObject [
	label := anObject
]

{ #category : #accessing }
ApedLabelPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newLabel
]

{ #category : #accessing }
ApedLabelPresenterPart >> setupAspectSymbolFor: aPresenter [.	

	"labels do not need have related aspects"
]

{ #category : #accessing }
ApedLabelPresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
	
	aPresenter 
		label: self label
]
