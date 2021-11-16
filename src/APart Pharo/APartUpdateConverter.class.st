Class {
	#name : #APartUpdateConverter,
	#superclass : #Object,
	#instVars : [
		'adaptor',
		'block'
	],
	#category : #'APart Pharo'
}

{ #category : #'instance creation' }
APartUpdateConverter class >> on: aBlock [

	^ self new 
		block: aBlock;
		yourself
]

{ #category : #'instance creation' }
APartUpdateConverter class >> on: aBlock for: anAdaptor [

	^ self new 
		block: aBlock;
		adaptor: anAdaptor;
		yourself
]

{ #category : #accessing }
APartUpdateConverter >> adaptor: anObject [
	adaptor := anObject
]

{ #category : #accessing }
APartUpdateConverter >> block [
	^ block
]

{ #category : #accessing }
APartUpdateConverter >> block: anObject [
	block := anObject
]

{ #category : #accessing }
APartUpdateConverter >> update: anAspect with: anObject [

	self block cull: anAspect cull: anObject
]
