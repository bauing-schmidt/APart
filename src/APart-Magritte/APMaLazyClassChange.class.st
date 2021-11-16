"
Description
--------------------

I am an abstract class representing changes that will need to impact a class during the generation.
	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	className:		<aSymbol>		Name of the class to impact.
	isClassSide:		<aBoolean>	A boolean to determine if the impact will be on the instance or the class side of the class to update.

"
Class {
	#name : #APMaLazyClassChange,
	#superclass : #APMaCodeChange,
	#instVars : [
		'className',
		'isClassSide'
	],
	#category : #'APart-Magritte'
}

{ #category : #testing }
APMaLazyClassChange class >> isAbstract [
	^ self = APMaLazyClassChange
]

{ #category : #accessing }
APMaLazyClassChange >> className [
	^ className
]

{ #category : #accessing }
APMaLazyClassChange >> className: anObject [
	className := anObject
]

{ #category : #initialization }
APMaLazyClassChange >> initialize [
	super initialize.
	isClassSide := false
]

{ #category : #accessing }
APMaLazyClassChange >> isClassSide [
	^ isClassSide
]

{ #category : #accessing }
APMaLazyClassChange >> isClassSide: anObject [
	isClassSide := anObject
]

{ #category : #accessing }
APMaLazyClassChange >> realClass [
	| class |
	class := self class environment at: self className.
	^ self isClassSide ifTrue: [ class class ] ifFalse: [ class ]
]
