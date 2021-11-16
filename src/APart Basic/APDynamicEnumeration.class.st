Class {
	#name : #APDynamicEnumeration,
	#superclass : #APEnumeration,
	#instVars : [
		'associationsBlock'
	],
	#category : #'APart Basic-Enumeration'
}

{ #category : #accessing }
APDynamicEnumeration >> associationsBlock [
	^ associationsBlock
]

{ #category : #accessing }
APDynamicEnumeration >> associationsBlock: anObject [
	associationsBlock := anObject
]

{ #category : #accessing }
APDynamicEnumeration >> keys [ 

	^ associationsBlock value collect: [ :each | each key ]
]

{ #category : #accessing }
APDynamicEnumeration >> textForKey: k [

	| aText | 
	
	aText := ((Dictionary newFrom: self associationsBlock value) at: k) asString.
	
	^ aText ifNil: 
			[textFromKeyBlock notNil
				ifTrue: [textFromKeyBlock value: k]
				ifFalse: [k asString]]
]

{ #category : #accessing }
APDynamicEnumeration >> values [ 

	^ associationsBlock value collect: [ :each | each value ]
]
