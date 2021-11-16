"
APartAbstractAction is the abstract superclass at the lowest level defining the very basic API of all kind of actions. It mainly defines that an action always has to have a least a unique key.
"
Class {
	#name : #APartAbstractAction,
	#superclass : #APartMember,
	#instVars : [
		'key'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #API }
APartAbstractAction >> actionBlock [

	self subclassResponsibility
]

{ #category : #accessing }
APartAbstractAction >> asRedirectedNamed: aName on: aPart path: aPath [

	^ APRedirectedAction named: aName on: aPart path:  (aPath, {self memberName})
]

{ #category : #accessing }
APartAbstractAction >> condition [
	^ nil
]

{ #category : #'API inspector' }
APartAbstractAction >> inspectorLabel [

	^self key printString
]

{ #category : #testing }
APartAbstractAction >> isAction [

	^ true
]

{ #category : #API }
APartAbstractAction >> isFromPath [

	^ false
]

{ #category : #API }
APartAbstractAction >> isRawAction [

	^ false
]

{ #category : #API }
APartAbstractAction >> isRedirected [

	^ false
]

{ #category : #API }
APartAbstractAction >> isTrigger [ 

	^ false
]

{ #category : #API }
APartAbstractAction >> key [

	^key
]

{ #category : #'initialize-release' }
APartAbstractAction >> key: aSymbol [

	key := aSymbol
]

{ #category : #accessing }
APartAbstractAction >> memberName [

	^ self key
]

{ #category : #'API inspector' }
APartAbstractAction >> printDescriptionForInspectorOn: s [

	s
		nextPutAll: self class name;
		nextPutAll: ' key: ';
		nextPutAll: key printString;
		cr
]

{ #category : #API }
APartAbstractAction >> statefulCondition [

	^nil
]

{ #category : #'API inspector' }
APartAbstractAction >> targetAction [

	self subclassResponsibility
]
