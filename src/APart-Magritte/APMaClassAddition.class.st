"
Description
--------------------

I represent a change that would create a class during a Famix generation.

Examples
--------------------

	FmxClassAddition definition: 'MooseModel subclass: #FmxStMooseModel
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Famix-Smalltalk-Entities'''
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	definition:		<aString>		The definition of the class to create.

"
Class {
	#name : #APMaClassAddition,
	#superclass : #APMaCodeChange,
	#instVars : [
		'definition'
	],
	#category : #'APart-Magritte'
}

{ #category : #'instance creation' }
APMaClassAddition class >> definition: aString [
	^ self new
		definition: aString;
		yourself
]

{ #category : #accessing }
APMaClassAddition >> apply [
	self class compiler evaluate: self definition
]

{ #category : #accessing }
APMaClassAddition >> definition [
	^ definition
]

{ #category : #accessing }
APMaClassAddition >> definition: anObject [
	definition := anObject
]
