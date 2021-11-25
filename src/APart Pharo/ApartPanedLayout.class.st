Class {
	#name : #ApartPanedLayout,
	#superclass : #SpPanedLayout,
	#instVars : [
		'resizeChildImage'
	],
	#category : #'APart Pharo'
}

{ #category : #accessing }
ApartPanedLayout >> resizeChildImage [

	^ resizeChildImage
]

{ #category : #accessing }
ApartPanedLayout >> resizeChildImage: aBoolean [

	resizeChildImage := aBoolean
]
