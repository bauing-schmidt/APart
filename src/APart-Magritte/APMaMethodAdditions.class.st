"
Description
--------------------

I represent a change that would create add methods to a class during a Famix generation.

Examples
--------------------

	method := RGMethod new
		sourceCode: 'initialize
		<generated>
		super initialize.
		self toto: true;
		protocol: #initialization;
		name: #initialize;
		yourself.

	FmxMethodAdditions className: FmxMethodAddition isClassSide: false rgMethods: {method}
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	rgMethods:		<aCollectionOfRGMethods>		A collection of ring methods to add to a class.

"
Class {
	#name : #APMaMethodAdditions,
	#superclass : #APMaLazyClassChange,
	#instVars : [
		'rgMethods'
	],
	#category : #'APart-Magritte'
}

{ #category : #'instance creation' }
APMaMethodAdditions class >> className: aSymbol isClassSide: aBoolean rgMethods: aCollection [
	^ self new
		className: aSymbol;
		isClassSide: aBoolean;
		rgMethods: aCollection;
		yourself
]

{ #category : #accessing }
APMaMethodAdditions >> apply [
	| class |
	class := self realClass.
	self rgMethods do: [ :method | self compile: method into: class ]
]

{ #category : #compiling }
APMaMethodAdditions >> compile: aRGMethod into: realClass [
	^ realClass compile: aRGMethod sourceCode classified: aRGMethod protocol
]

{ #category : #accessing }
APMaMethodAdditions >> rgMethods [
	^ rgMethods
]

{ #category : #accessing }
APMaMethodAdditions >> rgMethods: anObject [
	rgMethods := anObject
]
