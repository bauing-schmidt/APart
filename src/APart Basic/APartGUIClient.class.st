"
APartGUIClient is a client that interacts with a GUI instance (an object following the pattern of the APartAbstractGUITemplate class). This instance sets up the APartGUIClient and is kept permanently in its instance variable ""owner"" (see #registerView:).

--

APartGUIClient ist ein Client, der mit einer GUI-Instanz zusammenarbeitet (ein Objekt nach dem Muster der Klasse APartAbstractGUITemplate). Diese Instanz baut den APartGUIClient auf und wird in dessen Instanzvariable ""owner"" dauerhaft gehalten (siehe #registerView:).
"
Class {
	#name : #APartGUIClient,
	#superclass : #APartAbstractClient,
	#instVars : [
		'owner',
		'backendToUse',
		'locale',
		'application'
	],
	#category : #'APart Basic-Clients'
}

{ #category : #API }
APartGUIClient class >> clientTypes [

	^#(#GUI)
]

{ #category : #announcements }
APartGUIClient >> announcedStatesSpecialKeys [

	^owner announcedStatesSpecialKeys
]

{ #category : #accessing }
APartGUIClient >> application [
	^ application
]

{ #category : #accessing }
APartGUIClient >> application: anObject [
	application := anObject
]

{ #category : #private }
APartGUIClient >> aspectFor: aKey ifAbsent: absentBlock [

	^partInterface
		ifNotNil: [partInterface description aspectFor: aKey ifAbsent: absentBlock]
]

{ #category : #accessing }
APartGUIClient >> backendToUse [
	^ backendToUse
]

{ #category : #accessing }
APartGUIClient >> backendToUse: anObject [
	backendToUse := anObject
]

{ #category : #'interface closing' }
APartGUIClient >> close [

	self ownerDo: [:o | o closeAndUnschedule]
]

{ #category : #API }
APartGUIClient >> closeActiveSubApp [

	(owner notNil and: [ subAppConfiguration notNil ])
		ifTrue: 
			[subAppConfiguration activeSubAppKey: nil.
			owner setSubView: nil inSubCanvas: subAppConfiguration subCanvasKey]
]

{ #category : #private }
APartGUIClient >> createPromptExecutor [

	^owner createPromptExecutor
]

{ #category : #announcements }
APartGUIClient >> handleDefaultAnnouncedState: anAnnouncedState [

	self ownerDo: [:o | o handleDefaultAnnouncedState: anAnnouncedState]
]

{ #category : #announcements }
APartGUIClient >> handleSpecialAnnouncedStates: specialAnnouncedStatesOrNil [

	self ownerDo: 
			[:o |
			specialAnnouncedStatesOrNil
				ifNotNil: [o handleSpecialAnnouncedStates: specialAnnouncedStatesOrNil]]
]

{ #category : #API }
APartGUIClient >> interfaceChanged: anAnnouncement fromSubInterface: anAnnouncer [

	self
		ownerDo: [:o | o interfaceChanged: anAnnouncement fromSubInterface: anAnnouncement interface]
]

{ #category : #announcements }
APartGUIClient >> interfaceFocusRequest: anAnnouncement [

	self
		ownerDo: [:o | o interfaceFocusRequest: anAnnouncement from: anAnnouncement interface]
]

{ #category : #announcements }
APartGUIClient >> interfaceFocusRequest: anAnnouncement from: anAnnouncer [

	self
		ownerDo: [:o | o interfaceFocusRequest: anAnnouncement from: anAnnouncement interface]
]

{ #category : #API }
APartGUIClient >> isOpen [

	^owner notNil and: [owner isOpen]
]

{ #category : #'interface opening callbacks' }
APartGUIClient >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forListViewKey: aListViewKey [

	^owner
		itemStringRepresentationBlock: isrb
		itemIconRepresentationBlock: iirb
		forListViewKey: aListViewKey
]

{ #category : #'interface opening callbacks' }
APartGUIClient >> itemStringRepresentationBlock: isrb itemIconRepresentationBlock: iirb forTreeViewKey: aTreeViewKey [

	^owner
		itemStringRepresentationBlock: isrb
		itemIconRepresentationBlock: iirb
		forTreeViewKey: aTreeViewKey
]

{ #category : #announcements }
APartGUIClient >> localeChanged: anAnnouncement [

	locale := anAnnouncement locale.
	self
		ownerDo: [:o | o localeChanged: anAnnouncement locale]
]

{ #category : #private }
APartGUIClient >> ownerDo: aBlock [
	"In the case that some GUI clients should be avoided, like objects that are already being destroyed because some notifications arrive yet"

	owner ifNotNil: [:o | ^ aBlock value: o].
	^nil
]

{ #category : #private }
APartGUIClient >> partSwitched: anAnnouncement [

	self
		ownerDo: [:o | o partSwitched: anAnnouncement from: anAnnouncement interface]
]

{ #category : #private }
APartGUIClient >> partSwitched: anAnnouncement from: aSwitchingInterface [

	self
		ownerDo: [:o | o partSwitched: anAnnouncement from: aSwitchingInterface]
]

{ #category : #printing }
APartGUIClient >> printOn: s [

	<ingoreForCoverage>
	
	super printOn: s.
	owner
		ifNil: [s nextPutAll: ' No Owner.']
		ifNotNil: 
			[s
				nextPutAll: ' Owner: ';
				nextPutAll: owner class asString]
]

{ #category : #announcements }
APartGUIClient >> receiverForExtraAnnouncements [

	^owner
]

{ #category : #API }
APartGUIClient >> registerView: aView [

	owner := aView.
	partInterface registerClient: self.
	subAppConfiguration notNil ifTrue: [subAppConfiguration openInitialSubApp].
	partInterface subInterfacesForPostBuildDo: 
			[:key :subInterface |
			subInterface postBuildComponentKey: key in: aView]
]

{ #category : #'initialize-release' }
APartGUIClient >> release [

	super release.
	
	partInterface unregisterClient: self. 
	owner := nil.
	partInterface := nil.
	promptExecutor := nil
]

{ #category : #API }
APartGUIClient >> setActiveSubAppForKey: aSubAppKey [

	(owner notNil and: [ subAppConfiguration notNil ])
		ifTrue: 
			[subAppConfiguration activeSubAppKey: aSubAppKey.
			owner setSubView: (subAppConfiguration subAppGUIForKey: aSubAppKey
						inParentModel: owner)
				inSubCanvas: subAppConfiguration subCanvasKey]
]

{ #category : #API }
APartGUIClient >> unregisterView: aView [

	(owner = aView) ifFalse: [^self error: 'Client and view mismatch!'].
	partInterface unregisterClient: self.
	owner := nil.
]

{ #category : #announcements }
APartGUIClient >> updateAndAnnounceAll [

	partInterface updateAndAnnounceAll
]

{ #category : #'initialize-release' }
APartGUIClient >> updateConfigurationsFromPart [

	super updateConfigurationsFromPart.
	backendToUse := partInterface part backendToUse.
	locale := partInterface locale.
]

{ #category : #API }
APartGUIClient >> utilityAt: aKey [

	^self utilityAt: aKey ifAbsent: []
]

{ #category : #API }
APartGUIClient >> utilityAt: aKey ifAbsent: absentBlock [

	^partInterface utilityAt: aKey ifAbsent: absentBlock
]
