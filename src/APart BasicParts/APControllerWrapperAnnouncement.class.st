"
APControllerWrapperAnnouncement announcement created by APControllerWrapper to communicate certain desired behavior on an UI widget
"
Class {
	#name : #APControllerWrapperAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'aspectKey',
		'ringBell',
		'flash',
		'backspaceKey'
	],
	#category : #'APart BasicParts'
}

{ #category : #accessing }
APControllerWrapperAnnouncement >> aspectKey [

	^aspectKey
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> aspectKey: anObject [

	aspectKey := anObject
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> backspaceKey [

	^backspaceKey == true
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> backspaceKey: anObject [

	backspaceKey := anObject
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> flash [

	^flash == true
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> flash: anObject [

	flash := anObject
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> ringBell [

	^ringBell == true
]

{ #category : #accessing }
APControllerWrapperAnnouncement >> ringBell: anObject [

	ringBell := anObject
]
