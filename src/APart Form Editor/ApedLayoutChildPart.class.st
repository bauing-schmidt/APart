"
I describe properties of a child of a general layout
"
Class {
	#name : #ApedLayoutChildPart,
	#superclass : #ApedPartWithMemento,
	#category : #'APart Form Editor-Layout Child Parts'
}

{ #category : #'instance creation' }
ApedLayoutChildPart class >> onPart: aPart key: aKey onJson: aJsonObj [ 

	| className aClass | 
	
	className := aJsonObj at: #className ifAbsent: [ self pdmError: #PdmInvalidJsonObject].
	aClass := self withAllSubclasses detect: [ :each | each name = className ] ifNone: [ self pdmError: #PdmInvalidJsonObject ].

	^ (aClass onPart: aPart key: aKey) initOnJson: aJsonObj 
]

{ #category : #adding }
ApedLayoutChildPart >> addDependentToAspects [

		self partInterface description aspects do:[:a| 	
				a subAdaptor dependents ifEmpty:[
					a subAdaptor addDependent: self]]	
]

{ #category : #accessing }
ApedLayoutChildPart >> initOnJson: aJsonObj [
]

{ #category : #accessing }
ApedLayoutChildPart >> keysAndValuesForJson [

	| assocs | 
	
	assocs := { 
		#className -> self className.
	} asOrderedCollection.

	^ assocs 

]

{ #category : #updating }
ApedLayoutChildPart >> update: anObject [

	self partInterface part rootPart updatePreview
]
