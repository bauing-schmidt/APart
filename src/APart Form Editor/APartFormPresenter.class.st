Class {
	#name : #APartFormPresenter,
	#superclass : #ApedFormPreview,
	#instVars : [
		'formPart',
		'formLayout'
	],
	#category : #'APart Form Editor-Support'
}

{ #category : #API }
APartFormPresenter class >> matchingPartClass [ 

	^ APartFormPresenterTestPart
]

{ #category : #'as yet unclassified' }
APartFormPresenter >> buildPresenters [
	
	self partInterface ifNil: [ ^ self ].

	self presenterParts do: [ :each | 
		| aPresenter |
		(self partInterface part description hasAspectNamed: each aspect) 
			ifTrue: [
				aPresenter := each previewPresenterOn: self previewOnly: self previewOnly.
					self additionalSubpresentersMap at: each aspect put: aPresenter ] ].
			
	layout := self defineLayout.
	 
]

{ #category : #'as yet unclassified' }
APartFormPresenter >> defineLayout [

	^ self partInterface part formPart rootLayout previewLayout.
	
]

{ #category : #accessing }
APartFormPresenter >> formLayout [

	^ formLayout
]

{ #category : #accessing }
APartFormPresenter >> formLayout: anObject [

	formLayout := anObject.
	layout := anObject
]

{ #category : #'as yet unclassified' }
APartFormPresenter >> formPart [ 

	 ^ self partInterface part formPart
]

{ #category : #accessing }
APartFormPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: (self aPartTranslate: 'Editor').

	aWindowPresenter initialExtent: 800@600.
]

{ #category : #'as yet unclassified' }
APartFormPresenter >> layout [ 

	^ layout
]

{ #category : #'as yet unclassified' }
APartFormPresenter >> previewOnly [

	^ false
]
