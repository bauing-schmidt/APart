"
An abstract presenter with support of memento pattern
"
Class {
	#name : #ApedAbstractEditor,
	#superclass : #APartPresenter,
	#category : #'APart Form Editor-Support'
}

{ #category : #specs }
ApedAbstractEditor class >> aspectPairs [

	^ {
	}

]

{ #category : #specs }
ApedAbstractEditor class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom:
		  { (#reset -> [ aPresenter newButton label: 'Reset';
				   help: (aPresenter aPartTranslate: 'Reset values to the original state') ]) }
]

{ #category : #initialization }
ApedAbstractEditor >> defaultLayout [ 

	^ self class defaultLayout
]

{ #category : #initialization }
ApedAbstractEditor >> initializePresenters [

	super initializePresenters.
	layout := self defaultLayout. 
]
