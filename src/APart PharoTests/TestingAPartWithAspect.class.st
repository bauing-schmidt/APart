Class {
	#name : #TestingAPartWithAspect,
	#superclass : #APart,
	#instVars : [
		'someAspect'
	],
	#category : #'APart PharoTests'
}

{ #category : #accessing }
TestingAPartWithAspect >> someAspect [
	^ someAspect
]

{ #category : #accessing }
TestingAPartWithAspect >> someAspect: anObject [
	someAspect := anObject
]
