"
APartRedirectedAction verweist auf eine Action in einem Sub-Part.
Das Ziel der Action wird dabei jedesmal aus dem path ermittelt, um dynamische Strukturen (zB mit ListParts) zu unterstützen.
"
Class {
	#name : #APRedirectedAction,
	#superclass : #APartAbstractAction,
	#instVars : [
		'from',
		'path',
		'actionKey'
	],
	#category : #'APart Basic-Actions'
}

{ #category : #'instance creation' }
APRedirectedAction class >> named: aSourceKey on: aPart path: aPath [

	^ self on: aPart key: aSourceKey path: aPath

]

{ #category : #'instance creation' }
APRedirectedAction class >> on: aPart key: aSourceKey path: aPath [

	^self new initOn: aPart key: aSourceKey path: aPath
]

{ #category : #accessing }
APRedirectedAction >> action [

	^self to description actionAt: actionKey ifAbsent: nil
]

{ #category : #accessing }
APRedirectedAction >> actionBlock [

	^self action actionBlock
]

{ #category : #accessing }
APRedirectedAction >> createArgumentsArrayOn: aPart and: anArgument [

	^ self action createArgumentsArrayOn: aPart and: anArgument
]

{ #category : #accessing }
APRedirectedAction >> executeWith: args [

	^ self action executeWith: args
]

{ #category : #accessing }
APRedirectedAction >> initOn: aFromPart key: aSourceKey path: anArray [
	"Die path-Auflösung wird bei jeder Aktivierung in #to vorgenommen."

	key := aSourceKey.
	from := aFromPart partInterface.
	path := anArray.
	actionKey := anArray last
]

{ #category : #'API inspector' }
APRedirectedAction >> inspectorLabel [

	| s |
	s := WriteStream on: String new.
	s
		nextPutAll: super inspectorLabel;
		nextPutAll: ' redirecting '.
	(path ifNil: [#()]) do: [:ps | s nextPutAll: ps]
		separatedBy: [s nextPut: $/].
	^s contents
]

{ #category : #accessing }
APRedirectedAction >> isActive [

	^self action isActive
]

{ #category : #accessing }
APRedirectedAction >> isChanged [

	^ self action isChanged
]

{ #category : #accessing }
APRedirectedAction >> isExecutable [

	^ self action isExecutable
]

{ #category : #API }
APRedirectedAction >> isRedirected [

	^ true
]

{ #category : #API }
APRedirectedAction >> path [ 
	
	^ path
]

{ #category : #API }
APRedirectedAction >> postExecuteForPart: aPart [

	^ self action postExecuteForPart: aPart
]

{ #category : #accessing }
APRedirectedAction >> reasonForInactivity [

	^ self action reasonForInactivity
]

{ #category : #API }
APRedirectedAction >> statefulCondition [

	^self action statefulCondition
]

{ #category : #'API inspector' }
APRedirectedAction >> targetAction [

	^self action
]

{ #category : #accessing }
APRedirectedAction >> to [
	"The path should be resolved each time."

	| assoc |
	assoc := from part walkPath: path.
	^assoc key partInterface
]

{ #category : #accessing }
APRedirectedAction >> updateCondition [ 

	^ self action updateCondition
]

{ #category : #accessing }
APRedirectedAction >> updateConditionUsingCache: conditionCache [

	^ self action updateConditionUsingCache: conditionCache
]

{ #category : #'API inspector' }
APRedirectedAction >> wantsScopeUpdate [

	^ self action wantsScopeUpdate
]
