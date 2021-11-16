Extension { #name : #String }

{ #category : #'*APart Form Editor' }
String >> decapitalized [
	"Return a copy with the first letter decapitalized"
	| cap |
	self isEmpty ifTrue: [ ^self copy ].
	cap := self copy.
	cap at: 1 put: (cap at: 1) asLowercase.
	^ cap
]
