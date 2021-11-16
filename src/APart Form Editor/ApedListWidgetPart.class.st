Class {
	#name : #ApedListWidgetPart,
	#superclass : #ApedWidgetPresenterPart,
	#instVars : [
		'ownExampleContent'
	],
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #'as yet unclassified' }
ApedListWidgetPart >> initOnJson: aJsonObj [

	super initOnJson: aJsonObj.
	
	ownExampleContent := (aJsonObj at: #ownExampleContent ifAbsent: [ self pdmError: #PdmInvalidJsonObject ]).

]

{ #category : #accessing }
ApedListWidgetPart >> initializeValues [

	super initializeValues.
	self partInterface description createAspectNamed: #ownExampleContent.	
	
	self addDependentToAspects
]

{ #category : #accessing }
ApedListWidgetPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := super keysAndValuesForJson, { 
		#ownExampleContent -> self ownExampleContent.			
	}.
	
	^ assocs 
]

{ #category : #accessing }
ApedListWidgetPart >> ownExampleContent [

	^ ownExampleContent
]

{ #category : #accessing }
ApedListWidgetPart >> ownExampleContent: anObject [

	ownExampleContent := anObject
]

{ #category : #accessing }
ApedListWidgetPart >> setupPreviewPresenter: aPresenter [

	super setupPreviewPresenter: aPresenter.
		
		self exampleContent ifTrue: [ 		
			self ownExampleContent 
				ifNil:[
					aPresenter items: ((1 to: 32) collect: [ :i | 'item ', i threeDigitName] )]
				ifNotNil: [ aPresenter items: ( (self ownExampleContent substrings: ';') collect:[:row| row trimmed])				
					]]
	
]
