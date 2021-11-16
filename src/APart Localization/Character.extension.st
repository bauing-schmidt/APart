Extension { #name : #Character }

{ #category : #'*APart Localization' }
Character >> isBetweenazOrAZ [
	^ (self between: $a and: $z) or: [ self between: $A and: $Z ]
]
