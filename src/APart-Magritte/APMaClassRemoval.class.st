"
Description
--------------------

I represent a change that would remove a class during a Famix generation.

Examples
--------------------

	FmxClassRemoval class: FmxClassRemoval
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	class:		<aClass>		The instance of the class to remove from the system.

"
Class {
	#name : #APMaClassRemoval,
	#superclass : #APMaCodeChange,
	#instVars : [
		'class'
	],
	#category : #'APart-Magritte'
}

{ #category : #'instance creation' }
APMaClassRemoval class >> class: aClass [
	^ self new
		classToRemove: aClass;
		yourself
]

{ #category : #accessing }
APMaClassRemoval >> apply [
	self classToRemove removeFromSystem
]

{ #category : #accessing }
APMaClassRemoval >> classToRemove [
	^ class
]

{ #category : #accessing }
APMaClassRemoval >> classToRemove: anObject [
	class := anObject
]
