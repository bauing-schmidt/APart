"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).
"
Class {
	#name : #APxSubCanvasCoexistExample,
	#superclass : #APartExampleGUI,
	#instVars : [
		'subViews'
	],
	#category : #'APart Examples-SubCanvasCoexist'
}

{ #category : #API }
APxSubCanvasCoexistExample class >> matchingPartClass [

	^APxSubCanvasCoexistExamplePart
]

{ #category : #announcements }
APxSubCanvasCoexistExample >> announcedStatesSpecialKeys [

	^subViews keys
]

{ #category : #announcements }
APxSubCanvasCoexistExample >> handleSpecialAnnouncedStates: subViewStates [

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
APxSubCanvasCoexistExample >> initialize [

	subViews := Dictionary new.
	subViews
		at: #elementEditPart
			put: (APxSubCanvasElementEdit asSubViewOn: self
					subInterface: (self partInterface
							subInterfaceAtPath: #(#elementEditPart)));
		at: #groupEditPart
			put: (APxSubCanvasGroupEdit asSubViewOn: self
					subInterface: (self partInterface
							subInterfaceAtPath: #(#groupEditPart)))
]

{ #category : #announcements }
APxSubCanvasCoexistExample >> subClients [

	^subViews values
]
