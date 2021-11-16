"
APConfirmationEnumValue verarbeitet die Auswahl eines Elements aus einer GenericEnumeration.
"
Class {
	#name : #APConfirmationEnumValue,
	#superclass : #APartSimplePrompt,
	#instVars : [
		'enumerationPart'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APConfirmationEnumValue >> choice [

	^enumerationPart value
]

{ #category : #'initialize-release' }
APConfirmationEnumValue >> defaultPromptSelector [

	^#confirmEnumValue:
]

{ #category : #accessing }
APConfirmationEnumValue >> genericEnumeration [

	^enumerationPart enumeration
]

{ #category : #accessing }
APConfirmationEnumValue >> genericEnumeration: anObject [

	enumerationPart enumeration: anObject
]

{ #category : #'initialize-release' }
APConfirmationEnumValue >> initializeValues [

	enumerationPart := APEnumerationValuePart onPart: self
				key: #enumerationPart
]

{ #category : #accessing }
APConfirmationEnumValue >> resultEntryText [

	^self value 
		ifNotNil: [:entryKey | self genericEnumeration textForKey: entryKey]
]

{ #category : #accessing }
APConfirmationEnumValue >> resultEntryValue [

	^self value
		ifNotNil: [:entryKey | self genericEnumeration valueForKey: entryKey]
]

{ #category : #accessing }
APConfirmationEnumValue >> value [

	^enumerationPart value
]

{ #category : #accessing }
APConfirmationEnumValue >> value: selectedEnumValue [

	enumerationPart value: selectedEnumValue
]
