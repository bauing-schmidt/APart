"
Specialized tree node model (for an APTree)
"
Class {
	#name : #ApedLayoutTreeNodeModel,
	#superclass : #APTreeNodeModel,
	#category : #'APart Form Editor-Support'
}

{ #category : #accessing }
ApedLayoutTreeNodeModel >> indexOf: anObject [ 

	| found | 
	found := self indexOf: anObject path: #().
	
	(found endsWith: { nil }) ifTrue: [ ^ nil ].
	
	^ found
]

{ #category : #accessing }
ApedLayoutTreeNodeModel >> indexOf: anObject path: aPath [ 

	| found | 
	found := self ownIndexOf: anObject.
	found ifNotNil: [ 
		^ aPath, { found } ].
	
	self children withIndexDo: [ :child :index |
		found := child indexOf: anObject path: (aPath, { index }).
		(found endsWith: { nil })
			ifFalse: [ ^ found ] ].	

	^  aPath, { nil } 
]

{ #category : #accessing }
ApedLayoutTreeNodeModel >> nodeModelFor: anObject [ 

	self value = anObject ifTrue: [ ^ self ].
	
	self children do: [ :aChild | 
		| found |
		found := aChild nodeModelFor: anObject.
		found ifNotNil: [ ^ found  ] ].
	
	^ nil
]

{ #category : #accessing }
ApedLayoutTreeNodeModel >> ownIndexOf: anObject [ 

	^ (self children collect: #value) indexOf: anObject ifAbsent: [ nil ].

]
