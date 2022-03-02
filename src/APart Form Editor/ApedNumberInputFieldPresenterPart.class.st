"
I am a description of a number input filed presenter
"
Class {
	#name : #ApedNumberInputFieldPresenterPart,
	#superclass : #ApedTextInputFieldPresenterPart,
	#instVars : [
		'minimum',
		'maximum',
		'climbRate',
		'digits'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedNumberInputFieldPresenterPart class >> iconName [

	^ #tnumberedit
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart class >> label [ 

	^ 'Number input filed'
]

{ #category : #visiting }
ApedNumberInputFieldPresenterPart >> accept: anApedVisitor [

	anApedVisitor visitNumberInput: self
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> climbRate [
	^ climbRate
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> climbRate: anObject [
	climbRate := anObject
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> digits [
	^ digits
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> digits: anObject [
	digits := anObject
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	minimum := (aJsonObj at: #minimum ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	maximum := (aJsonObj at: #maximum ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	climbRate := (aJsonObj at: #climbRate ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	digits := (aJsonObj at: #digits ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> initializeValues [

	super initializeValues.
	
	minimum := 0.
	maximum := 100. 
	digits := SpNumberInputFieldPresenter defaultDigits.
	climbRate := SpNumberInputFieldPresenter defaultClimbRate.
	
	self partInterface description createAspectNamed: #minimum.	
	self partInterface description createAspectNamed: #maximum.	
	self partInterface description createAspectNamed: #climbRate.
	self partInterface description createAspectNamed: #digits.
	
	self addDependentToAspects
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#minimum -> self minimum.
		#maximum -> self maximum.
		#climbRate -> self climbRate.
		#digits -> self digits.
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> maximum [
	^ maximum
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> maximum: anObject [
	maximum := anObject
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> minimum [
	^ minimum
]

{ #category : #accessing }
ApedNumberInputFieldPresenterPart >> minimum: anObject [
	minimum := anObject
]

{ #category : #preview }
ApedNumberInputFieldPresenterPart >> newPreviewPresenterOn: aPresenter [

	^ aPresenter newNumberInput
]

{ #category : #preview }
ApedNumberInputFieldPresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
	
	aPresenter 
		minimum: self minimum asNumber;
		maximum: self maximum asNumber;
		climbRate: self climbRate asNumber;
		digits: self digits asNumber.
]
