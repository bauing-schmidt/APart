Class {
	#name : #APBindingsTestPart,
	#superclass : #APart,
	#traits : 'APTRootPart',
	#classTraits : 'APTRootPart classTrait',
	#instVars : [
		'stringAspect'
	],
	#category : #'APart PharoTests-Bindings'
}

{ #category : #accessing }
APBindingsTestPart >> defineAspects [

	partInterface description createAllAspectsNamed: #(stringAspect)
]

{ #category : #accessing }
APBindingsTestPart >> initializeValues [

	 stringAspect := 'stringAspect initial value'
]

{ #category : #accessing }
APBindingsTestPart >> stringAspect [

	^ stringAspect
]

{ #category : #accessing }
APBindingsTestPart >> stringAspect: anObject [

	stringAspect := anObject
]
