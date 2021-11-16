"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxSubCanvasCoexistSwitchExample,
	#superclass : #APartExampleGUI,
	#instVars : [
		'subViews'
	],
	#category : #'APart Examples-SubCanvasCoexistSwitch'
}

{ #category : #API }
APxSubCanvasCoexistSwitchExample class >> matchingPartClass [

	^APxSubCanvasCoexistSwitchExamplePart
]

{ #category : #announcements }
APxSubCanvasCoexistSwitchExample >> handleSpecialAnnouncedStates: subViewStates [

	| hasOneActive |
	subViewStates isEmpty ifTrue: [^self].
	hasOneActive := false.
	subViewStates keysAndValuesDo: 
			[:k :subViewState |
			subViewState isActive
				ifTrue: 
					[hasOneActive := true.
					self setSubView: (subViews at: k) inSubCanvas: #editView]].
	hasOneActive ifFalse: [self setSubView: nil inSubCanvas: #editView]
]

{ #category : #'initialize-release' }
APxSubCanvasCoexistSwitchExample >> initialize [

	subViews := Dictionary new.
	subViews
		at: #elementEditPart
			put: (APxSubCanvasElementEdit asSubViewOn: self
					subInterface: (self partInterface
							subInterfaceAtPath: #(#switchingPart #elementEditPart)));
		at: #groupEditPart
			put: (APxSubCanvasGroupEdit asSubViewOn: self
					subInterface: (self partInterface
							subInterfaceAtPath: #(#switchingPart  #groupEditPart)))
]

{ #category : #announcements }
APxSubCanvasCoexistSwitchExample >> partSwitched: anAnnouncement from: aSwitchingInterface [

	anAnnouncement containerId = #switchingPart ifFalse: [^self].
	anAnnouncement subId
		ifNil: [self setSubView: nil inSubCanvas: #editView]
		ifNotNil: [:k | self setSubView: (subViews at: k) inSubCanvas: #editView]
]

{ #category : #announcements }
APxSubCanvasCoexistSwitchExample >> subClients [

	^subViews values
]
