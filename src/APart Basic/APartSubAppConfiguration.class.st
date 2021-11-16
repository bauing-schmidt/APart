"
APartSubAppConfiguration dient zur Konfiguration von SubApplications als Parts unterhalb eines Parent-Parts, der primär als Container betrachtet wird. Zu diesem Zweck integriert sie alle Informationen, die zur Koordination des Parent-Parts mit dem Parent-UI benötigt werden.

Die Klasse bietet ein API für folgende Funktionalität:
- Spezifikation des SubCanvas-Keys, unter dem die UI-Repräsentationen der SubApplications liegen sollen 
- Definition der beteiligten SubApplications per APInitializer
- Anlegen aller SubApplications als SubParts eines übergebenen MainParts
- Reaktion auf Tab-Selektion in einem Ribbon-UI
- Reaktion auf aPart-Announcements zur Aktivierung / Deaktivierung

Siehe Beispiel in APart Examples Ribbon
"
Class {
	#name : #APartSubAppConfiguration,
	#superclass : #Object,
	#instVars : [
		'initializers',
		'subCanvasKey',
		'mainPart',
		'activeSubAppKey'
	],
	#category : #'APart Basic-Core'
}

{ #category : #'instance creation' }
APartSubAppConfiguration class >> create [

	^ self new
]

{ #category : #'instance creation' }
APartSubAppConfiguration class >> on: aMainPart subCanvasKey: aCanvasKey [ 

	^(self create)
		mainPart: aMainPart;
		subCanvasKey: aCanvasKey yourself
]

{ #category : #'instance creation' }
APartSubAppConfiguration class >> subCanvasKey: aCanvasKey [

	^(self create)
		subCanvasKey: aCanvasKey;
		yourself
]

{ #category : #API }
APartSubAppConfiguration >> activeSubAppGuiInParentModel: aPartApplicationModel [

	^[self subAppGUIForKey: activeSubAppKey inParentModel: aPartApplicationModel] on: Error
		do: [:ex | nil]
]

{ #category : #accessing }
APartSubAppConfiguration >> activeSubAppKey [

	^activeSubAppKey
]

{ #category : #accessing }
APartSubAppConfiguration >> activeSubAppKey: anObject [

	activeSubAppKey := anObject
]

{ #category : #API }
APartSubAppConfiguration >> addActiveInitializer: anAPInitializer [

	activeSubAppKey := anAPInitializer partKey.
	self addInitializer: anAPInitializer
]

{ #category : #API }
APartSubAppConfiguration >> addInitializer: anAPInitializer [

	initializers add: anAPInitializer
]

{ #category : #private }
APartSubAppConfiguration >> createSubAppsEachDo: aBlock [

	mainPart isNil
		ifTrue: [self error: 'Missing mainPart for creating subApps'].
	initializers do: [:init | aBlock value: (init createPartOn: mainPart)]
]

{ #category : #API }
APartSubAppConfiguration >> createSubAppsFor: aMainPart [

	self createSubAppsFor: aMainPart eachDo: [:sp | ]
]

{ #category : #API }
APartSubAppConfiguration >> createSubAppsFor: aMainPart eachDo: aBlock [

	mainPart := aMainPart.
	self createSubAppsEachDo: aBlock
]

{ #category : #announcements }
APartSubAppConfiguration >> handleAnnouncedState: anAnnouncedState [

	| partKey |
	partKey := anAnnouncedState key.
	(self isSubAppKey: partKey) ifFalse: [^nil].
	anAnnouncedState isActive
		ifTrue: 
			[activeSubAppKey = partKey ifTrue: [^self].
			activeSubAppKey := partKey]
		ifFalse: 
			[activeSubAppKey isNil ifTrue: [^self].
			activeSubAppKey := nil]
]

{ #category : #'initialize-release' }
APartSubAppConfiguration >> initialize [

	initializers := OrderedCollection new.
]

{ #category : #private }
APartSubAppConfiguration >> isSubAppKey: aKey [

	^initializers
		contains: [:eachInitializer | eachInitializer partKey = aKey]
]

{ #category : #accessing }
APartSubAppConfiguration >> mainPart [

	^mainPart
]

{ #category : #'initialize-release' }
APartSubAppConfiguration >> mainPart: anObject [

	mainPart := anObject
]

{ #category : #API }
APartSubAppConfiguration >> noticeSelectedTab: aRibbonTab [

	self openClientForSubAppKey: aRibbonTab subAppKeyFromId
]

{ #category : #private }
APartSubAppConfiguration >> openClientForSubAppKey: aPartKey [

	mainPart openClientForSubAppKey: aPartKey
]

{ #category : #API }
APartSubAppConfiguration >> openInitialSubApp [

	activeSubAppKey notNil
		ifTrue: [self openClientForSubAppKey: activeSubAppKey]
]

{ #category : #'initialize-release' }
APartSubAppConfiguration >> release [

	initializers := nil.
	mainPart := nil
]

{ #category : #private }
APartSubAppConfiguration >> subAppAt: aKey [

	^mainPart subPartAt: aKey
		ifNone: [self error: 'Invalid subApp key ' , aKey printString]
]

{ #category : #API }
APartSubAppConfiguration >> subAppGUIForKey: aPartKey inParentModel: aPartApplicationModel [

	| subApp guiClientClass |
	subApp := self subAppAt: aPartKey.
	guiClientClass := (mainPart clientRegistry
				findClientClassesWithTypesForPart: subApp) at: #GUI ifAbsent: [^nil].
	^aPartApplicationModel subAppViewAt: aPartKey
		ifAbsentPut: 
			[guiClientClass basicNew
				initOn: (guiClientClass guiClientFor: subApp partInterface)]
]

{ #category : #API }
APartSubAppConfiguration >> subAppPartsDo: aBlock [

	^initializers
		do: [:eachInitializer | aBlock value: (self subAppAt: eachInitializer partKey)]
]

{ #category : #accessing }
APartSubAppConfiguration >> subCanvasKey [

	^subCanvasKey
]

{ #category : #'initialize-release' }
APartSubAppConfiguration >> subCanvasKey: anObject [

	subCanvasKey := anObject
]
