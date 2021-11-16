"
common superclass for actions and aspects
"
Class {
	#name : #APartMember,
	#superclass : #Object,
	#instVars : [
		'memberGroup'
	],
	#category : #'APart Basic-Core'
}

{ #category : #accessing }
APartMember >> asRedirectedNamed: aName on: aPart path: aPath [

	self subclassResponsibility 
]

{ #category : #accessing }
APartMember >> disabledByFocus [ 

	memberGroup ifNil: [ ^ false ].
	^ memberGroup disabledByFocus.
]

{ #category : #testing }
APartMember >> isAction [

	^ false
]

{ #category : #testing }
APartMember >> isAspect [

	^ false
]

{ #category : #accessing }
APartMember >> memberGroup [ 

	^ memberGroup
]

{ #category : #accessing }
APartMember >> memberGroup: aMemberGroup [

	memberGroup := aMemberGroup
]

{ #category : #accessing }
APartMember >> memberName [

	self subclassResponsibility 
]
