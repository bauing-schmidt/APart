"
Description
--------------------

I represent a change that would update a class comment during a Famix generation.

Examples
--------------------

	FmxClassCommentUpdate className: FmxClassCommentUpdate comment: 'This is the new comment of my class.'
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	comment:		<aString>		The new comment of the class.

"
Class {
	#name : #APMaClassCommentUpdate,
	#superclass : #APMaLazyClassChange,
	#instVars : [
		'comment'
	],
	#category : #'APart-Magritte'
}

{ #category : #'instance creation' }
APMaClassCommentUpdate class >> className: aSymbol comment: aString [
	^ self new
		className: aSymbol;
		comment: aString;
		yourself
]

{ #category : #accessing }
APMaClassCommentUpdate >> apply [
	self realClass comment: self comment
]

{ #category : #accessing }
APMaClassCommentUpdate >> comment [
	^ comment
]

{ #category : #accessing }
APMaClassCommentUpdate >> comment: anObject [
	comment := anObject
]
