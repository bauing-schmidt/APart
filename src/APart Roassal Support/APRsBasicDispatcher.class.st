"
Implements default dispatcher behavior for handling Roassal events
"
Class {
	#name : #APRsBasicDispatcher,
	#superclass : #Object,
	#instVars : [
		'part',
		'target',
		'primaryIsLeft',
		'selectorsByEventName',
		'namedEventMappings',
		'leftClickTogglingModifier'
	],
	#category : #'APart Roassal Support-Support'
}

{ #category : #'instance creation' }
APRsBasicDispatcher class >> onPart: aPart [
	"Creators may set a target different from the default (the part) on the returned instance"
	
	^self new
		part: aPart;
		yourself
]

{ #category : #API }
APRsBasicDispatcher >> addNamedMappings: mappingsColl [

	mappingsColl do: [ :m |
		(namedEventMappings at: m keyName ifAbsentPut: [ Set new ]) add: m.
		m receiver ifNil: [ m receiver: self]. 
	]
]

{ #category : #'API events' }
APRsBasicDispatcher >> allDispatchedRsNames [

	^selectorsByEventName keys
]

{ #category : #private }
APRsBasicDispatcher >> applicationItemAt: pos [

	^part rootItem applicationItemAt: pos
]

{ #category : #private }
APRsBasicDispatcher >> eventSelectorForName: aRsEventName [

	^ selectorsByEventName at: aRsEventName ifAbsent: [ ]
]

{ #category : #'API events' }
APRsBasicDispatcher >> handleRsEvent: evt [
	"First, we dispatch the incoming event to our own implementation. If this one does not return nil,
	we expect a further MessageSend with a receiver that is normally the part."
	
	| sel msgSend |
	sel := self eventSelectorForName: evt class name.
	sel = #onKeyUp: ifTrue: [self notNil].
	msgSend := MessageSend receiver: self selector: sel argument: evt.
	msgSend value ifNotNil: [ :dispatchedSend | dispatchedSend value]
	
]

{ #category : #initialization }
APRsBasicDispatcher >> initialize [

	super initialize.
	selectorsByEventName := self setupSelectorsByEventName.
	namedEventMappings := Dictionary new.
	primaryIsLeft := true.
	leftClickTogglingModifier := #optionKeyPressed.
]

{ #category : #private }
APRsBasicDispatcher >> isLeftClickTogglingModifierInEvent: evt [

	^ leftClickTogglingModifier
		ifNotNil: [ :lctm | lctm cull: evt ]
		ifNil: 	[ false ]
]

{ #category : #accessing }
APRsBasicDispatcher >> leftClickTogglingModifier [

	^ leftClickTogglingModifier
]

{ #category : #accessing }
APRsBasicDispatcher >> leftClickTogglingModifier: anObject [

	leftClickTogglingModifier := anObject
]

{ #category : #private }
APRsBasicDispatcher >> mappingForNamedEvent: evt [

	^ namedEventMappings at: evt keyName ifPresent: [ :set |
		set detect: [ :km | km matchesModifiersIn: evt] ifNone: [ ]
	]
		
]

{ #category : #'API events' }
APRsBasicDispatcher >> onKeyDown: evt [

	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onKeyUp: evt [

	evt keyName traceCrAs: evt keyValue asString.
	(self mappingForNamedEvent: evt) ifNotNil: [ :evtMapping |
		evtMapping value
	].
	^ nil

]

{ #category : #private }
APRsBasicDispatcher >> onMouseClick: evt isPrimary: isPrimaryClick [
	| appItem targetAspect pos |
	
	self takeFocus
		ifFalse: [ ^nil].
	pos := evt position.
	appItem := self applicationItemAt: pos.
	targetAspect := appItem ifNotNil: [ 
		(appItem shapeAt: pos) ifNotNil: [:targetShape | targetShape aspect]
	].
	^ isPrimaryClick 
		ifTrue: [ self primaryPointTo: appItem at: pos targetAspect: targetAspect ]
		ifFalse: [ self secondaryPointTo: appItem at: pos targetAspect: targetAspect ]
]

{ #category : #private }
APRsBasicDispatcher >> onMouseDoubleClick: evt isPrimary: isPrimary [
	| appItem targetAspect pos |
	
	self takeFocus
		ifFalse: [ ^nil].
	pos := evt position.
	appItem := self applicationItemAt: pos.
	targetAspect := appItem ifNotNil: [ 
		(appItem shapeAt: pos) ifNotNil: [:targetShape | targetShape aspect]
	].
	^ isPrimary
		ifTrue: [ self primaryActivateItem: appItem at: pos aspect: targetAspect ]
		ifFalse: [ self secondaryActivateItem: appItem at: pos aspect: targetAspect ]
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseDoubleLeftClick: evt [

	^ self onMouseDoubleClick: evt isPrimary: (self shallConvertLeftToRightClickForEvent: evt) not 
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseDoubleRightClick: evt [

	^ self onMouseDoubleClick: evt isPrimary: self primaryIsLeft not
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseDragging: evt [

	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseEnter: evt [

	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseLeave: evt [
	self notNil.
	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseLeftClick: evt [

	^ self onMouseClick: evt isPrimary: (self shallConvertLeftToRightClickForEvent: evt) not
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseLeftDragStart: evt [

	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseMove: evt [

	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseRightClick: evt [

	^ self onMouseClick: evt isPrimary: self primaryIsLeft not
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseRightDragStart: evt [

	^ nil
]

{ #category : #'API events' }
APRsBasicDispatcher >> onMouseWheelEvent: evt [
	| isDirectionUp |
	
	self takeFocus
		ifFalse: [ ^self].

	isDirectionUp := evt direction = GdkScrollDirection GDK_SCROLL_UP.
	evt controlKeyPressed ifFalse: [ 
		isDirectionUp ifTrue: [ self scrollUp ] ifFalse: [ self scrollDown ] 
	] ifTrue: [ 
		isDirectionUp ifTrue: [ self zoomIn ] ifFalse: [ self zoomOut ] 
	]

]

{ #category : #accessing }
APRsBasicDispatcher >> part [

	^ part
]

{ #category : #accessing }
APRsBasicDispatcher >> part: anObject [

	part := anObject.
	self target: anObject.
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> primaryActivateItem [

	self primaryActivateItem: nil at: nil aspect: nil
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> primaryActivateItem: appItem at: position aspect: targetAspect [
	"Extracted here on basic dispatcher, as this call might be reused by several events, or redefined in subclass"
	
	| itemToUse |
	itemToUse := (appItem isNil and: [position isNil]) ifTrue: [
		"Means: activation is called by keyboard event. Thus we need something like a selection"
		self target focusApplicationItem
	] ifFalse: [
		appItem ifNil: [ ^ nil].
	].
	self target primaryActivateItem: itemToUse at: position aspect: targetAspect.
	^ nil
]

{ #category : #accessing }
APRsBasicDispatcher >> primaryIsLeft [

	^ primaryIsLeft
]

{ #category : #accessing }
APRsBasicDispatcher >> primaryIsLeft: anObject [

	primaryIsLeft := anObject
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> primaryPointTo: appItem at: pos targetAspect: targetAspect [
	"Extracted here on basic dispatcher, as this call might be reused by several events, or redefined in subclass.
	Mind that, on this level, the call has to either answer a MessageSend (for further activity to be dispatched) or nil"
	
	self target primaryPointTo: appItem at: pos targetAspect: targetAspect.
	^ nil
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> scrollDown [

	self target scrollDown
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> scrollUp [

	self target scrollUp
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> secondaryActivateItem [

	self secondaryActivateItem: nil at: nil aspect: nil
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> secondaryActivateItem: appItem at: position aspect: targetAspect [

	^ part secondaryActivateItem: appItem at: position aspect: targetAspect
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> secondaryPointTo: appItem at: pos targetAspect: targetAspect [
	"Extracted here on basic dispatcher, as this call might be reused by several events, or redefined in subclass
	Mind that the call has to either answer a MessageSend or nil"
	
	self target secondaryPointTo: appItem at: pos targetAspect: targetAspect.
	^ nil
]

{ #category : #initialization }
APRsBasicDispatcher >> setupSelectorsByEventName [
	"We do not deal with symbols as keys but rather use names retrieved from classes in order to detect missing or misspelled classes"
	| assocs dict |
	
	assocs := {
		RSKeyDown name -> #onKeyDown: .
		RSKeyUp name -> #onKeyUp: .
		RSMouseLeftClick name -> #onMouseLeftClick: .
		RSMouseRightClick name -> #onMouseRightClick:.
		RSMouseDoubleLeftClick name -> #onMouseDoubleLeftClick:.
		RSMouseDoubleRightClick name -> #onMouseDoubleRightClick: .
		RSMouseWheelEvent name -> #onMouseWheelEvent: .
		RSMouseMove name -> #onMouseMove: .
		RSMouseEnter name -> #onMouseEnter: .
		RSMouseLeave name -> #onMouseLeave: .
		RSMouseLeftDragStart name -> #onMouseLeftDragStart: .
		RSMouseRightDragStart name -> #onMouseRightDragStart: .
		RSMouseDragging name -> #onMouseDragging: .
	} .
	dict := Dictionary new: assocs size.
	assocs do: [ :a | dict at: a key put: a value ].
	^dict
]

{ #category : #private }
APRsBasicDispatcher >> shallConvertLeftToRightClickForEvent: evt [
	"May be overridden in subclass.
	Default is inversion of primaryIsLeft, which will keep left click as left click as long as primaryIsLeft is true and no general modifier toggle is defined."
	
	^ self primaryIsLeft not or: [ self isLeftClickTogglingModifierInEvent: evt ]
]

{ #category : #private }
APRsBasicDispatcher >> takeFocus [

	self target finishTemporaryUserTasks.
	^self target takeFocus
]

{ #category : #accessing }
APRsBasicDispatcher >> target [

	^ target
]

{ #category : #accessing }
APRsBasicDispatcher >> target: anObject [

	target := anObject
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> zoomIn [

	self target zoomIn
]

{ #category : #'API dispatched' }
APRsBasicDispatcher >> zoomOut [

	self target zoomOut
]
