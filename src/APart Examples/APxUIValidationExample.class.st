"
Beispiel-Views werden selbst nicht kommentiert, sondern nur ihre jeweils zugehörige Part-Klasse (zu finden in #matchingPartClass).

"
Class {
	#name : #APxUIValidationExample,
	#superclass : #APartExampleGUI,
	#category : #'APart Examples-UIValidation'
}

{ #category : #API }
APxUIValidationExample class >> matchingPartClass [

	^APxUIValidationExamplePart
]

{ #category : #accessing }
APxUIValidationExample >> controllerWrapperAnnouncement: wrapperAnnouncement announcer: anInterface [

	wrapperAnnouncement ringBell ifTrue: [ self window beep].
	wrapperAnnouncement flash
		ifTrue: 
			[(self widgetAt: wrapperAnnouncement aspectKey) ifNotNil: [:v | v flash]].
	wrapperAnnouncement backspaceKey
		ifTrue: 
			[(self widgetAt: wrapperAnnouncement aspectKey)
				ifNotNil: [:v | v controller backspaceKey: nil]]
]

{ #category : #accessing }
APxUIValidationExample >> max20: aController [

	^client partInterface
		execute: #max20
		with: (APControllerWrapper on: aController)
		ifDisabled: [false]
]

{ #category : #accessing }
APxUIValidationExample >> validateHours: aController [

	^client partInterface
		execute: #validateHours
		with: (APControllerWrapper on: aController)
		ifDisabled: [false]
]
