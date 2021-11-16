"
APEnumerationValuePart holds a GenericEnumeration and optionally a value from it.

enumerationForValue 
		- becuase the enumerations can hold subenumerations, I keep information about the 
		  source enumeration of the value. 
"
Class {
	#name : #APEnumerationValuePart,
	#superclass : #APart,
	#instVars : [
		'enumeration',
		'enumerationForValue',
		'value',
		'enumerationUpdateBlock'
	],
	#category : #'APart BasicParts'
}

{ #category : #'instance creation' }
APEnumerationValuePart class >> onPart: aParentPart key: aKey initialize: enumInitBlock [

	| enum |
	enum := APEnumeration create.
	enumInitBlock value: enum.
	^(self onPart: aParentPart key: aKey)
		enumeration: enum;
		yourself
]

{ #category : #'initialize-release' }
APEnumerationValuePart >> createEnumerationForKeys: aKeyColl [

	enumeration := (APEnumeration create)
				addAllEntriesForKeys: aKeyColl;
				yourself.
	^enumeration
]

{ #category : #'initialize-release' }
APEnumerationValuePart >> defineAspects [

	partInterface description 
		createAllAspectsNamed: #(#value #valueText #entryValueForKey #enumerationTextList #enumerationKeys)
]

{ #category : #API }
APEnumerationValuePart >> entryValueForKey [
	"Can be used as redirectedAspect, but only read."
	"DE:Kann als redirectedAspect genutzt werden, jedoch nur lesend."

	^value ifNotNil: [self enumerationForCurrentValue valueForKey: value]
]

{ #category : #accessing }
APEnumerationValuePart >> enumeration [

	^enumeration
]

{ #category : #accessing }
APEnumerationValuePart >> enumeration: anObject [

	enumeration := anObject
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationActionForKey: k [

	^enumeration actionForKey: k
]

{ #category : #API }
APEnumerationValuePart >> enumerationForCurrentValue [

	^enumerationForValue ifNil: [enumeration]
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationIconForKey: k [

	^enumeration iconForKey: k
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationIsActiveAtKey: k [

	^enumeration isActiveAt: k
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationIsIndicatedOnAtKey: k [

	^enumeration isIndicatedOnAt: k
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationKeyForValue: aValue [

	^enumeration keyForValue: aValue
]

{ #category : #API }
APEnumerationValuePart >> enumerationKeys [

	^enumeration keys
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationTextForKey: k [

	^enumeration textForKey: k
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationTextList [

	^self enumerationKeys collect: [:k | self enumerationTextForKey: k]
]

{ #category : #accessing }
APEnumerationValuePart >> enumerationUpdateBlock [

	^enumerationUpdateBlock
]

{ #category : #accessing }
APEnumerationValuePart >> enumerationUpdateBlock: anObject [

	enumerationUpdateBlock := anObject
]

{ #category : #'API Enumeration' }
APEnumerationValuePart >> enumerationValueForKey: k [

	^enumeration valueForKey: k
]

{ #category : #'initialize-release' }
APEnumerationValuePart >> initializeValue: anObject [

	value := anObject.
	enumerationForValue := enumeration.
]

{ #category : #'initialize-release' }
APEnumerationValuePart >> initializeValues [

	enumeration isNil ifTrue: [enumeration := APEnumeration create]
]

{ #category : #'API inspector' }
APEnumerationValuePart >> inspectorSubObjectList [

	^OrderedCollectionWithDependants with: 'Enumeration' -> enumeration with: 'value' -> value
]

{ #category : #API }
APEnumerationValuePart >> objectsForAnnouncement [

	^Array with: enumeration
]

{ #category : #printing }
APEnumerationValuePart >> printOn: s [

	super printOn: s.
	key notNil
		ifTrue: 
			[s
				nextPut: $(;
				nextPutAll: key printString;
				nextPut: $)]
]

{ #category : #'initialize-release' }
APEnumerationValuePart >> release [

	super release.
	enumeration := value := enumerationUpdateBlock := nil
]

{ #category : #updating }
APEnumerationValuePart >> updateCondition [

	super updateCondition.
	self isActive
		ifTrue: [enumeration updateCondition]
		ifFalse: [enumeration updateOnFinalReason: APart reasonInactive]
]

{ #category : #updating }
APEnumerationValuePart >> updateEnumeration [

	enumerationUpdateBlock notNil
		ifTrue: 
			[self enumeration: enumerationUpdateBlock value.
			self updateCondition]
]

{ #category : #accessing }
APEnumerationValuePart >> value [

	^value
]

{ #category : #accessing }
APEnumerationValuePart >> value: anObject [

	self value: anObject from: enumeration
]

{ #category : #accessing }
APEnumerationValuePart >> value: anObject from: updatingEnumeration [

	value := anObject.
	enumerationForValue := updatingEnumeration.
	(partInterface hasTrigger: #valueChanged)
		ifTrue: [partInterface executeTrigger: #valueChanged].
	self changedAspectValues: #(#valueText #entryValueForKey)
		suppressListeners: true.
	self changedAspectValue: #value.
	self changed: #value
]

{ #category : #accessing }
APEnumerationValuePart >> valueText [

	^value ifNotNil: [self enumerationForCurrentValue textForKey: value]
]

{ #category : #accessing }
APEnumerationValuePart >> valueText: aValueText [

	aValueText isNil ifTrue: [^self value: nil].
	(enumeration keyForText: aValueText) ifNotNil: [ :k |
		self value: k.
	] ifNil: [self error: 'No match for text: ', aValueText printString].
]
