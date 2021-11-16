Class {
	#name : #APFocusTests,
	#superclass : #TestCase,
	#instVars : [
		'root',
		'leftChild',
		'rightChild',
		'rightLeaf'
	],
	#category : #'APart PharoTests-Focus'
}

{ #category : #running }
APFocusTests >> setUp [ 

	super setUp.
	
	root := APart createWithClientRegistry.
	leftChild := APTestChildWithfocus onPart: root key: #leftChild. 		
	rightChild := APTestChildWithfocus onPart: root key: #rightChild. 	
	rightLeaf := APTestChildWithfocus onPart: rightChild key: #child. 	
]

{ #category : #running }
APFocusTests >> testCanAcceptFocus [

	self deny: root canAcceptFocus.
	self assert: leftChild canAcceptFocus.
	self assert: rightChild canAcceptFocus.
	self assert: rightLeaf canAcceptFocus.
	
]

{ #category : #running }
APFocusTests >> testInitialHasFocus [

	self deny: root hasFocus.
	self deny: leftChild hasFocus.
	self deny: rightChild hasFocus.
	self deny: rightLeaf hasFocus.
	
]

{ #category : #running }
APFocusTests >> testInitialIsInFocusChain [

	self deny: root isInFocusChain.
	self deny: leftChild isInFocusChain.
	self deny: rightChild isInFocusChain.
	self deny: rightLeaf isInFocusChain.
	
]

{ #category : #running }
APFocusTests >> testLeftFocus [

	leftChild takeFocus.

	self deny: root hasFocus.
	self assert: leftChild hasFocus.
	self deny: rightChild hasFocus.
	self deny: rightLeaf hasFocus.
	
]

{ #category : #running }
APFocusTests >> testLeftIsInFocusChain [

	leftChild takeFocus.

	self assert: root isInFocusChain.
	self assert: leftChild isInFocusChain.
	self deny: rightChild isInFocusChain.
	self deny: rightLeaf isInFocusChain.
	
]

{ #category : #running }
APFocusTests >> testPartWithFocus [

	self assert: root partWithFocus isNil.
	self assert: leftChild partWithFocus isNil.
	self assert: rightChild partWithFocus isNil.
	self assert: rightLeaf partWithFocus isNil.
	
]

{ #category : #running }
APFocusTests >> testPartWithFocusLeft [

	leftChild takeFocus.

	self assert: root partWithFocus equals: leftChild.
	self assert: leftChild partWithFocus equals: leftChild.
	self assert: rightChild partWithFocus equals: leftChild.
	self assert: rightLeaf partWithFocus equals: leftChild.
	
]

{ #category : #running }
APFocusTests >> testPartWithFocusRightLeaf [

	rightLeaf takeFocus.

	self assert: root partWithFocus equals: rightLeaf.
	self assert: leftChild partWithFocus equals: rightLeaf.
	self assert: rightChild partWithFocus equals: rightLeaf.
	self assert: rightLeaf partWithFocus equals: rightLeaf.
	
]

{ #category : #running }
APFocusTests >> testRightFocus [

	rightChild takeFocus.

	self deny: root hasFocus.
	self deny: leftChild hasFocus.
	self assert: rightChild hasFocus.
	self deny: rightLeaf hasFocus.
	
]

{ #category : #running }
APFocusTests >> testRightIsInFocusChain [

	rightChild takeFocus.

	self assert: root isInFocusChain.
	self deny: leftChild isInFocusChain.
	self assert: rightChild isInFocusChain.
	self assert: rightLeaf isInFocusChain.
	
]

{ #category : #running }
APFocusTests >> testRightLeafFocus [

	rightLeaf takeFocus.

	self deny: root hasFocus.
	self deny: leftChild hasFocus.
	self deny: rightChild hasFocus.
	self assert: rightLeaf hasFocus.
	
]

{ #category : #running }
APFocusTests >> testRightLeafInFocusChain [

	rightLeaf takeFocus.

	self assert: root isInFocusChain.
	self deny: leftChild isInFocusChain.
	self assert: rightChild isInFocusChain.
	self assert: rightLeaf isInFocusChain.
	
]
