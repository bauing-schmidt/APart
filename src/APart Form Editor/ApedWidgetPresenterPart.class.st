"
I am a description of a general presenter
"
Class {
	#name : #ApedWidgetPresenterPart,
	#superclass : #ApedPresenterPart,
	#instVars : [
		'aspect',
		'visible',
		'borderWidth',
		'borderColor',
		'color',
		'help',
		'enabled',
		'exampleContent',
		'notes',
		'sameIdAsAspect',
		'presenterId'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedWidgetPresenterPart >> addDependentToAspects [

		self partInterface description aspects do:[:a| 	
				a subAdaptor dependents ifEmpty:[
					a subAdaptor addDependent: self]]	
]

{ #category : #accessing }
ApedWidgetPresenterPart >> aspect [
	^ aspect
]

{ #category : #accessing }
ApedWidgetPresenterPart >> aspect: anObject [

	aspect = anObject ifTrue: [ ^ self ].
	self renameNodeFor: anObject.
	aspect := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> borderColor [
	^ borderColor
]

{ #category : #accessing }
ApedWidgetPresenterPart >> borderColor: anObject [
	borderColor := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> borderWidth [
	^ borderWidth
]

{ #category : #accessing }
ApedWidgetPresenterPart >> borderWidth: anObject [
	borderWidth := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> color [
	^ color
]

{ #category : #accessing }
ApedWidgetPresenterPart >> color: anObject [
	color := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> enabled [
	^ enabled
]

{ #category : #accessing }
ApedWidgetPresenterPart >> enabled: anObject [
	enabled := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> exampleContent [
	^ exampleContent
]

{ #category : #accessing }
ApedWidgetPresenterPart >> exampleContent: anObject [
	exampleContent := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> help [
	^ help
]

{ #category : #accessing }
ApedWidgetPresenterPart >> help: anObject [
	help := anObject
]

{ #category : #'as yet unclassified' }
ApedWidgetPresenterPart >> initOnJson: aJsonObj [

	aspect := (aJsonObj at: #aspect ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	presenterId := (aJsonObj at: #presenterId ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	sameIdAsAspect := (aJsonObj at: #sameIdAsAspect ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	visible := (aJsonObj at: #visible ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	borderWidth := (aJsonObj at: #borderWidth ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	borderColor := (aJsonObj at: #borderColor ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	color := (aJsonObj at: #color ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	help := (aJsonObj at: #help ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	enabled := (aJsonObj at: #enabled ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	exampleContent := (aJsonObj at: #exampleContent ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).
	notes := (aJsonObj at: #notes ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedWidgetPresenterPart >> initializeValues [

	super initializeValues.

	visible := true.
	enabled := true.	
	exampleContent := true.

	self partInterface description 
		createAspectNamed: #visible;
		createAspectNamed: #aspect;
		createAspectNamed: #sameIdAsAspect;
		createAspectNamed: #presenterId;
		createAspectNamed: #borderColor;
		createAspectNamed: #borderWidth;
		createAspectNamed: #color;
		createAspectNamed: #enabled;
		createAspectNamed: #help;
		createAspectNamed: #exampleContent;
		createAspectNamed: #notes.
		
	self at: #borderColor putCondition: APCondition false.
	self at: #borderWidth putCondition: APCondition false.
	self at: #color putCondition: APCondition false.
	
	self at: #presenterId putCondition: (APCondition on: [ self sameIdAsAspect not ] ifNot: #sameIdAsAspectSelected).

	sameIdAsAspect := self sameIdAsAspectDefaultValue.
	
	self addDependentToAspects
		

]

{ #category : #'as yet unclassified' }
ApedWidgetPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#aspect -> self aspect.
		#presenterId -> presenterId.
		#sameIdAsAspect -> self sameIdAsAspect.
		#visible -> self visible.
		#borderWidth -> self borderWidth.
		#borderColor -> self borderColor.
		#color -> self color.
		#help -> self help.
		#enabled -> self enabled.
		#exampleContent -> self exampleContent.
		#notes -> self notes.
	}.
	
	^ assocs 
]

{ #category : #'as yet unclassified' }
ApedWidgetPresenterPart >> layoutRepresentation [ 

	"how this presenter shoud be defined in the layout" 
	^ self presenterId asSymbol
]

{ #category : #accessing }
ApedWidgetPresenterPart >> listLabel [ 

	^ self class label, ' (', self aspect asString, ')'
]

{ #category : #accessing }
ApedWidgetPresenterPart >> notes [
	^ notes
]

{ #category : #accessing }
ApedWidgetPresenterPart >> notes: anObject [
	notes := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> presenterId [ 

	self sameIdAsAspect ifTrue: [ 
		^ self aspect ].
		
	^ presenterId
]

{ #category : #accessing }
ApedWidgetPresenterPart >> presenterId: aString [

	presenterId := aString
]

{ #category : #accessing }
ApedWidgetPresenterPart >> renameNodeFor: anObject [

	self parentPart ifNotNil: [ 
		self rootPart form rootLayout ifNotNil: [ 
			self rootPart
				renameChildNodes: self rootPart form rootLayout children
				whereKey: self key
				to: anObject.
			self rootPart form layoutTree refresh ] ]
]

{ #category : #accessing }
ApedWidgetPresenterPart >> sameIdAsAspect [
	^ sameIdAsAspect
]

{ #category : #accessing }
ApedWidgetPresenterPart >> sameIdAsAspect: anObject [
	sameIdAsAspect := anObject
]

{ #category : #accessing }
ApedWidgetPresenterPart >> sameIdAsAspectDefaultValue [ 

	^ true
]

{ #category : #preview }
ApedWidgetPresenterPart >> setupAspectSymbolFor: aPresenter [

	aPresenter aspectSymbol: self aspect.

]

{ #category : #preview }
ApedWidgetPresenterPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
	
	self setupAspectSymbolFor: aPresenter.	

	aPresenter 
		borderColor: self borderColor;
		color: self color;
		enabled: self enabled;
		help: self help.
]

{ #category : #accessing }
ApedWidgetPresenterPart >> update: anObject [

	self partInterface part rootPart updatePreview
]

{ #category : #accessing }
ApedWidgetPresenterPart >> visible [
	^ visible
]

{ #category : #accessing }
ApedWidgetPresenterPart >> visible: anObject [
	visible := anObject
]
