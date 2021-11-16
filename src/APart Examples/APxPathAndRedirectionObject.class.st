"
a helper object used with APxPathAndRedirectionPart
"
Class {
	#name : #APxPathAndRedirectionObject,
	#superclass : #Object,
	#instVars : [
		'name',
		'value'
	],
	#category : #'APart Examples-PathAndRedirection'
}

{ #category : #accessing }
APxPathAndRedirectionObject >> name [

	^name
]

{ #category : #accessing }
APxPathAndRedirectionObject >> name: anObject [

	name := anObject
]

{ #category : #accessing }
APxPathAndRedirectionObject >> value1 [

	^value
]

{ #category : #accessing }
APxPathAndRedirectionObject >> value: anObject [

	value := anObject
]
