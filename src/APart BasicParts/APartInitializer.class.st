"
APartInitializer hält alle Daten, um einen Part bei Bedarf zu erzeugen.
"
Class {
	#name : #APartInitializer,
	#superclass : #Object,
	#instVars : [
		'partClass',
		'partKey',
		'preInitBlock',
		'postInitBlock'
	],
	#category : #'APart BasicParts'
}

{ #category : #'instance creation' }
APartInitializer class >> on: aPartClass [

	^self new initOn: aPartClass
]

{ #category : #'instance creation' }
APartInitializer class >> on: aPartClass key: aPartKey [

	^(self new initOn: aPartClass)
		partKey: aPartKey;
		yourself
]

{ #category : #API }
APartInitializer >> createPartOn: aParentPart [

	^partClass
		onPart: aParentPart
		key: partKey
		preInit: preInitBlock
		postInit: postInitBlock
]

{ #category : #'initialize-release' }
APartInitializer >> initOn: aPartClass [

	partClass := aPartClass
]

{ #category : #API }
APartInitializer >> partClass [

	^partClass
]

{ #category : #accessing }
APartInitializer >> partKey [

	^partKey
]

{ #category : #accessing }
APartInitializer >> partKey: anObject [

	partKey := anObject
]

{ #category : #API }
APartInitializer >> postInitBlock [

	^postInitBlock
]

{ #category : #'initialize-release' }
APartInitializer >> postInitBlock: anObject [

	postInitBlock := anObject
]

{ #category : #API }
APartInitializer >> preInitBlock [

	^preInitBlock
]

{ #category : #'initialize-release' }
APartInitializer >> preInitBlock: anObject [

	preInitBlock := anObject
]

{ #category : #printing }
APartInitializer >> printOn: s [

	super printOn: s.
	s
		nextPut: $(;
		nextPutAll: partKey printString;
		nextPut: $)
]
