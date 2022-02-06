"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxSubCanvasPartSwitchExample,
	#superclass : #APartExampleGUI,
	#instVars : [
		'subViews'
	],
	#category : #'APart Examples-SubCanvasPartSwitch'
}

{ #category : #API }
APxSubCanvasPartSwitchExample class >> matchingPartClass [

	^APxSubCanvasPartSwitchExamplePart
]

{ #category : #announcements }
APxSubCanvasPartSwitchExample >> contextSwitched: anAnnouncement from: aSwitchingInterface [

	| svClass subView |
	anAnnouncement containerId = #demoSwitchingPart ifFalse: [^self].
	svClass := anAnnouncement subId = #treeView
				ifTrue: [APxSubCanvasSubTree]
				ifFalse: [anAnnouncement subId = #listView ifTrue: [APxSubCanvasSubList]].
	subView := svClass
				ifNotNil: 
					[svClass asSubViewOn: self
						subInterface: aSwitchingInterface subInterface].
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #currentView
]

{ #category : #'initialize-release' }
APxSubCanvasPartSwitchExample >> defaultLayout [ 

	^ self class defaultLayout

]

{ #category : #'initialize-release' }
APxSubCanvasPartSwitchExample >> initialize [

	super initialize.

	subViews := Dictionary new.
	subViews at: #groupsTree put: (APxSubCanvasSubTree asSubViewOn: self).
	subViews at: #groupsList put: (APxSubCanvasSubList asSubViewOn: self)
]

{ #category : #announcements }
APxSubCanvasPartSwitchExample >> partSwitched: anAnnouncement from: aSwitchingInterface [

	| svClass subView |
	anAnnouncement containerId = #demoSwitchingPart ifFalse: [^self].
	svClass := anAnnouncement subId = #treeView
				ifTrue: [APxSubCanvasSubTree]
				ifFalse: [anAnnouncement subId = #listView ifTrue: [APxSubCanvasSubList]].
	subView := svClass
				ifNotNil: 
					[svClass asSubViewOn: self
						subInterface: anAnnouncement fromInterface].
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #currentView
]
