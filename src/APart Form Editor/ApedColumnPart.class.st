Class {
	#name : #ApedColumnPart,
	#superclass : #ApedPartWithMemento,
	#instVars : [
		'title',
		'expandable',
		'width'
	],
	#category : #'APart Form Editor-Columns'
}

{ #category : #accessing }
ApedColumnPart >> children [ 

	^ #()
]

{ #category : #accessing }
ApedColumnPart >> expandable [

	^ expandable
]

{ #category : #accessing }
ApedColumnPart >> expandable: anObject [

	expandable := anObject
]

{ #category : #'initialize-release' }
ApedColumnPart >> initializeValues [

	super initializeValues.

	expandable := true.
	title := ''.	
	width := -1.

	self partInterface description 
		createAspectNamed: #expandable;
		createAspectNamed: #title;
		createAspectNamed: #width.
		

]

{ #category : #accessing }
ApedColumnPart >> labelString [ 

	^ self class label
]

{ #category : #accessing }
ApedColumnPart >> title [

	^ title
]

{ #category : #accessing }
ApedColumnPart >> title: anObject [

	title := anObject
]

{ #category : #accessing }
ApedColumnPart >> width [

	^ width
]

{ #category : #accessing }
ApedColumnPart >> width: anObject [

	width := anObject
]
