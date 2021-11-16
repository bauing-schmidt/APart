Class {
	#name : #APTestChildWithfocus,
	#superclass : #APart,
	#traits : 'APTPartWithFocus',
	#classTraits : 'APTPartWithFocus classTrait',
	#category : #'APart PharoTests-Focus'
}

{ #category : #accessing }
APTestChildWithfocus >> canAcceptFocus [

	^ true
]

{ #category : #accessing }
APTestChildWithfocus >> canLoseFocus [

	^ true
]

{ #category : #accessing }
APTestChildWithfocus >> focusChanged [

	self reexpose.
	self scopeUpdate.

]
