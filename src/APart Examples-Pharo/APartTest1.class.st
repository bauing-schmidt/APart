Class {
	#name : #APartTest1,
	#superclass : #APart,
	#instVars : [
		'personName'
	],
	#category : #'APart Examples-Pharo'
}

{ #category : #accessing }
APartTest1 >> personName [
	
	<aPartAspect>

	^personName
]

{ #category : #accessing }
APartTest1 >> personName: anObject [

	personName := anObject.
	
"	Transcript show: anObject."
]

{ #category : #accessing }
APartTest1 >> signal: aPart [

	^ self new
		part: aPart;
		yourself
]
