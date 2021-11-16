"
I am a general part describing presenters. I have:
- serialization support
- previews support
"
Class {
	#name : #ApedPresenterPart,
	#superclass : #ApedPartWithMemento,
	#category : #'APart Form Editor-Element Parts'
}

{ #category : #accessing }
ApedPresenterPart class >> aspectPrefix [ 

	^ ((self name withoutPrefix: 'Aped') withoutSuffix: 'PresenterPart') decapitalized
]

{ #category : #'instance creation' }
ApedPresenterPart class >> onPart: aPart key: aKey onJson: aJsonObj [ 

	| className aClass | 
	
	className := aJsonObj at: #className ifAbsent: [ self pdmError: #PdmInvalidJsonObject].
	aClass := self withAllSubclasses detect: [ :each | each name = className ] ifNone: [ self pdmError: #PdmInvalidJsonObject ].

	^ (aClass onPart: aPart key: aKey) initOnJson: aJsonObj 
]

{ #category : #serialization }
ApedPresenterPart >> initOnJson: aJsonObj [
	

]

{ #category : #serialization }
ApedPresenterPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := { 
		#className -> self className.
	} asOrderedCollection.
	
	^ assocs 
]

{ #category : #preview }
ApedPresenterPart >> newPreviewPresenterOn: aPresenter [

	"empty placeholder"
	^ aPresenter newLabel
]

{ #category : #preview }
ApedPresenterPart >> previewPresenterOn: aPartPresenter [ 

	| newPresenter |
	
	newPresenter := self newPreviewPresenterOn: aPartPresenter.
	
	self setupPreviewPresenter: newPresenter.
	
	newPresenter isAPartPresenter ifTrue: [ 
		aPartPresenter setupPresenter2: newPresenter fromSource: self partInterface part owner: aPartPresenter ].
	
	^ newPresenter
]

{ #category : #preview }
ApedPresenterPart >> previewPresenterOn: aPartPresenter previewOnly: previewOnlyBoolean [

	| newPresenter |
	
	newPresenter := self newPreviewPresenterOn: aPartPresenter.
	
	self setupPreviewPresenter: newPresenter.
	
	previewOnlyBoolean ifFalse: [ 
		newPresenter isAPartPresenter ifTrue: [ 
			aPartPresenter setupPresenter2: newPresenter fromSource: self partInterface part owner: aPartPresenter ] ].
	
	^ newPresenter
]

{ #category : #preview }
ApedPresenterPart >> setupPreviewPresenter: aPresenter [
]
