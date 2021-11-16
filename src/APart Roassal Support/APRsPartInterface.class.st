"
Part interface with a pluggable dispatcher for Roassal events
"
Class {
	#name : #APRsPartInterface,
	#superclass : #APartInterface,
	#instVars : [
		'handledAnnouncements',
		'dispatchers'
	],
	#category : #'APart Roassal Support-Support'
}

{ #category : #'API events' }
APRsPartInterface >> dispatcherForRsEvent: evt [

	^ dispatchers at: evt class name ifPresent: [ :stack | stack last]
]

{ #category : #initialization }
APRsPartInterface >> initialize [

	super initialize.
	handledAnnouncements := IdentitySet new.
	dispatchers := Dictionary new.
	
]

{ #category : #'API events' }
APRsPartInterface >> onRsEvent: evt [

	(self dispatcherForRsEvent: evt)
		ifNotNil: [ :d | d handleRsEvent: evt ]
]

{ #category : #'API events' }
APRsPartInterface >> registerDispatcher: aDispatcher [

	self registerDispatcher: aDispatcher forAllRs: aDispatcher allDispatchedRsNames
]

{ #category : #'API events' }
APRsPartInterface >> registerDispatcher: aDispatcher forAllRs: rsEventNameColl [

	rsEventNameColl do: [ :n | self registerDispatcher: aDispatcher forRsName: n ]
]

{ #category : #'API events' }
APRsPartInterface >> registerDispatcher: aDispatcher forRsName: rsEventName [
	"Dictionary holds LIFO stack"
	| eventClass |
	
	rsEventName isSymbol
		ifFalse: [ self error: 'InvalidRsEventNameClass ', rsEventName].
	"We do that here, also to check that we really got a class name"
	eventClass := self class environment classNamed: rsEventName.
	(dispatchers at: rsEventName ifAbsentPut: [OrderedCollection new]) add: aDispatcher.
	(handledAnnouncements includes: rsEventName)
		ifTrue: [ ^self ].
	handledAnnouncements add: rsEventName.
	"Mind that only canvas is a valid handler for announcements"
	part canvas when: eventClass do: [ :evt | self onRsEvent: evt ]


]

{ #category : #'API events' }
APRsPartInterface >> unregisterDispatcher: aDispatcher forAllRs: rsEventNameColl [

	rsEventNameColl do: [ :n | self unregisterDispatcher: aDispatcher forRsName: n ]
]

{ #category : #'API events' }
APRsPartInterface >> unregisterDispatcher: aDispatcher forRsName: rsEventName [
	"Dictionary holds LIFO stack"
	
	dispatchers at: rsEventName ifPresent: [ :stack | 
		stack last == aDispatcher ifTrue: [ 
			stack removeLast.
			aDispatcher part: nil
		]
	]
]
