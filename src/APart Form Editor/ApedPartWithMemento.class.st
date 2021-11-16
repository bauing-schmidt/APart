"
A part with support of memento pattern that allows to restore original value of the part instance varialbes
"
Class {
	#name : #ApedPartWithMemento,
	#superclass : #APart,
	#instVars : [
		'memento'
	],
	#category : #'APart Form Editor-Support'
}

{ #category : #accessing }
ApedPartWithMemento class >> label [ 

	^ self name
]

{ #category : #accessing }
ApedPartWithMemento >> fillFrom: anObject [

	| savedMemento |

	anObject ifNil: [ ^ self ].

	savedMemento := self memento.	
	self class allInstVarNames  do: [ :varName |
		self instVarNamed: varName put: (anObject instVarNamed: varName) ].
	self memento: savedMemento.
	self changedAllAspectValues.
	
]

{ #category : #accessing }
ApedPartWithMemento >> initializeActions [

	super initializeActions.
	
	partInterface description
		createAction: #reset
		do: [ self reset  ]
		if: (APCondition true).
]

{ #category : #accessing }
ApedPartWithMemento >> listLabel [ 

	^ self class label
]

{ #category : #accessing }
ApedPartWithMemento >> memento [
	^ memento
]

{ #category : #accessing }
ApedPartWithMemento >> memento: anObject [
	memento := anObject
]

{ #category : #accessing }
ApedPartWithMemento >> reset [

	self fillFrom: memento.
]
