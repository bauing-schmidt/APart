"
APartRedirectedAspect represents an aspect redirected to another part 
"
Class {
	#name : #APRedirectedAspect,
	#superclass : #APAspect,
	#instVars : [
		'from',
		'toPart',
		'path',
		'remainingPath'
	],
	#category : #'APart Basic-Aspects'
}

{ #category : #'instance creation' }
APRedirectedAspect class >> named: aName on: aPart path: aPath [

	^self new 
		name: aName;
		initOn: aPart path: aPath
]

{ #category : #'instance creation' }
APRedirectedAspect class >> on: aPart path: aPath [

	^self new initOn: aPart path: aPath
]

{ #category : #accessing }
APRedirectedAspect >> addAnnouncedStatesTo: aCollection in: partInterface name: k collectAll: collectAll [

	| targetPart targetAspect |
	targetPart := self toPart.
	targetPart isReleased ifTrue: [ ^ self ].
	targetAspect := self remainingPath first.
	partInterface computeAnnouncedStatesTo: aCollection for: k part: targetPart aspect: targetAspect collectAll: collectAll. 
]

{ #category : #accessing }
APRedirectedAspect >> aspectFor: aKey ifAbsent: absentBlock [

	^(subAdaptor isNil  and: [ self to notNil ])
		ifTrue: [self to description aspectFor: aKey ifAbsent: absentBlock]
		ifFalse: [ APAspect named: aKey for: subAdaptor]
]

{ #category : #accessing }
APRedirectedAspect >> aspectKey [
	"Nicht nil, wenn es eine Redirection auf einen direkten Aspect eines Subcontexts ist."

	^remainingPath size = 1 ifTrue: [remainingPath first]
]

{ #category : #private }
APRedirectedAspect >> createSubAdaptor [

	^(APAspectAdaptor forAspect: remainingPath last
		path: (remainingPath copyFrom: 1 to: remainingPath size - 1))
		subject: toPart;
		yourself
]

{ #category : #accessing }
APRedirectedAspect >> from [

	^from
]

{ #category : #accessing }
APRedirectedAspect >> initOn: aFromPart path: anArray [

	| assoc |
	from := aFromPart partInterface.
	path := anArray.
	assoc := aFromPart walkPath: path.
	toPart := assoc key.
	remainingPath := assoc value.
	remainingPath isEmpty
		ifTrue: [self error: 'Invalid redirection target: ' , path printString].
	(toPart partInterface description definesAspect: remainingPath first)
		ifFalse: 
			[self error: 'Expecting target aspect ' , remainingPath first printString].
	remainingPath size = 1 ifTrue: [^self].
	subAdaptor := self createSubAdaptor.

]

{ #category : #testing }
APRedirectedAspect >> isRedirected [

	^ true
]

{ #category : #accessing }
APRedirectedAspect >> path [

	^path
]

{ #category : #printing }
APRedirectedAspect >> printOn: aStream [

	super printOn: aStream.
	path isNil ifTrue: [^self].
	aStream
		space;
		nextPutAll: path printString;
		space
]

{ #category : #accessing }
APRedirectedAspect >> remainingPath [

	^remainingPath
]

{ #category : #accessing }
APRedirectedAspect >> subAdaptor [

	^ subAdaptor ifNil: [ subAdaptor := self createSubAdaptor ]
]

{ #category : #accessing }
APRedirectedAspect >> targetAspectIfAbsent: absentBlock [

	^ self aspectFor: self aspectKey ifAbsent: absentBlock
]

{ #category : #accessing }
APRedirectedAspect >> to [

	^toPart partInterface
]

{ #category : #accessing }
APRedirectedAspect >> toPart [

	^toPart
]
