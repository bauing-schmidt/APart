"
APartOnTheFly dient zum Aufbau eines Parts, ohne eine eigene Klasse zu definieren. Alle Sub-Parts bzw. Aspekte werden in einem Dictionary angelegt.
"
Class {
	#name : #APartOnTheFly,
	#superclass : #APart,
	#instVars : [
		'properties'
	],
	#category : #'APart BasicParts'
}

{ #category : #'message handling' }
APartOnTheFly >> aPartPerform: aKey [

	^properties at: aKey
		ifAbsent: [self error: 'Invalid getter call ' , aKey printString]
]

{ #category : #'message handling' }
APartOnTheFly >> aPartPerform: aKey with: aValue [

	^properties at: aKey put: aValue
]

{ #category : #'initialize-release' }
APartOnTheFly >> basicInitialize [

	super basicInitialize.
	properties := Dictionary new
]

{ #category : #'initialize-release' }
APartOnTheFly >> defineEnumPart: aKey enumKeys: enumKeys [

	| evp |
	evp := APEnumerationValuePart onPart: self key: aKey.
	evp createEnumerationForKeys: enumKeys.
	properties at: aKey put: evp.
	partInterface description createAspectNamed: aKey.
	^evp
]

{ #category : #'initialize-release' }
APartOnTheFly >> defineProperty: aKey value: aValue [

	properties at: aKey put: aValue.
	partInterface description createAspectNamed: aKey
]

{ #category : #API }
APartOnTheFly >> propertyAt: aKey [

	^properties at: aKey
]

{ #category : #API }
APartOnTheFly >> propertyAt: aKey put: aValue [

	^properties at: aKey put: aValue
]
