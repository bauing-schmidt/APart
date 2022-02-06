"
A presenter for an embedded form preview
"
Class {
	#name : #ApedFormPreview,
	#superclass : #APartPresenter,
	#instVars : [
		'isCtrlPressed'
	],
	#category : #'APart Form Editor-Preview'
}

{ #category : #specs }
ApedFormPreview class >> defaultLayout [ 

	
]

{ #category : #API }
ApedFormPreview class >> matchingPartClass [

	^ApedFormPreviewPart
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> buildPresenters [

	self partInterface ifNil: [ ^ self ].

	self owner eventHandler whenKeyDownDo: [ :event | 
		event keyValue = self ctrlKeyValue ifTrue: [ isCtrlPressed := true ] ].
	self owner eventHandler whenKeyUpDo: [ :event | 
		event keyValue = self ctrlKeyValue ifTrue: [ isCtrlPressed := false ] ].

	self presenterParts do: [ :each | 
		| aPresenter |
		aPresenter := each
			              previewPresenterOn: self
			              previewOnly: self previewOnly.
		aPresenter eventHandler whenMouseDownDo: [ :event | 
			event isDoubleClick not ifTrue: [ 
				isCtrlPressed ifTrue: [ 
					self formPart layoutTree refresh.
					self formPart layoutTree selection: (self formPart
							 collectLayoutsForDeletedPresenters: { each }
							 from: self layouts) first ] ] ].

		self additionalSubpresentersMap at: each aspect put: aPresenter ]
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> buildWithSelector: aSelector [

	"ignore aSelector"

	^ self buildWithLayout: (self layout)
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> createPresenters [ 

	"not yet"
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> ctrlKeyValue [

	^ 65507
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> formPart [ 

	^ self partInterface part parentPart formPart
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> initOn: aClient [

	super initOn: aClient.
	isCtrlPressed := false.
	self buildPresenters.
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> layout [
	| mainLayout |
	mainLayout := SpBoxLayout newVertical.

	self partInterface ifNotNil: [ 
		
		self layouts size > 0 ifTrue: [ 
			mainLayout := self layouts first previewLayout  ]
		
	"self layouts root children first value    inspect."
		"self presenterParts do: [ :each |
			mainLayout add: each aspect asString asSymbol]" ].
	
	^ mainLayout
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> layouts [

	^ self formPart layoutTree treeModel root children collect: #value
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> notifyPartAboutMyself [

	self hasPartInterface ifTrue: [ 
		self partInterface part presenterBuilt: self ]
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> presenterParts [ 

	^ self formPart elementsList list 
]

{ #category : #'as yet unclassified' }
ApedFormPreview >> previewOnly [

	"Am I a form preview or a real form connected to a real part?"

	^ true
]
