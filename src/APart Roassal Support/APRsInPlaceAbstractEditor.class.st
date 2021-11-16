"
An in-place editor is a simple text widget that can be placed directly on to a canvas for editing a single line of text. Its connection to the canvas (APRsCanvas) is maintained by a APRsInPlaceEditConnector.
The abstract base class performs all operations for editor setup and shutdown, and defines subclass responsibilities for catching the exits of the editing action (either confirming by key Return or cancelling by key Esc).
"
Class {
	#name : #APRsInPlaceAbstractEditor,
	#superclass : #Object,
	#instVars : [
		'connector',
		'owner'
	],
	#category : #'APart Roassal Support-In-place Editor'
}

{ #category : #'instance creation' }
APRsInPlaceAbstractEditor class >> onConnector: anEditConnector owner: anOwner [
	^self new initOn: anEditConnector owner: anOwner
]

{ #category : #API }
APRsInPlaceAbstractEditor >> disconnect [

	connector ifNil: [^false].
	connector disconnectEditor: self.
	connector := nil.
	^true
]

{ #category : #'initialize-release' }
APRsInPlaceAbstractEditor >> initOn: anEditConnector owner: anOwner [

	connector := anEditConnector.
	owner := anOwner
]

{ #category : #API }
APRsInPlaceAbstractEditor >> leftWithEscape [

	self disconnect
		ifTrue: [	self privateLeftWithEscape].

]

{ #category : #API }
APRsInPlaceAbstractEditor >> leftWithEscape: aText [
	"Text may be not interesting, but is passed anyway. Subclasses may override only the argumentless private call."
	
	self leftWithEscape
]

{ #category : #API }
APRsInPlaceAbstractEditor >> leftWithReturn: aText [
	
	connector ifNil: [^self].
	self privateLeftWithReturn: aText.

]

{ #category : #API }
APRsInPlaceAbstractEditor >> openBacklinkFromConnector [
	"We do not yet backlink at creation time of the editor, but not until owner is ready for receiving events from connector.
	For ease of usage, this call to the connector may be repeated for the same editor without changing something."
	
	connector connectEditor: self
]

{ #category : #accessing }
APRsInPlaceAbstractEditor >> owner [

	^ owner
]

{ #category : #private }
APRsInPlaceAbstractEditor >> privateLeftWithEscape [
	self subclassResponsibility
]

{ #category : #private }
APRsInPlaceAbstractEditor >> privateLeftWithReturn: aText [
	self subclassResponsibility
]

{ #category : #API }
APRsInPlaceAbstractEditor >> show [
	connector show
]

{ #category : #API }
APRsInPlaceAbstractEditor >> text: aText [

	connector ifNotNil: [connector text: aText]
]

{ #category : #API }
APRsInPlaceAbstractEditor >> useExtent: extent [

	connector ifNotNil: [	connector useExtent: extent]
]

{ #category : #API }
APRsInPlaceAbstractEditor >> useRectangle: rect [

	connector ifNotNil: [	connector useRectangle: rect]
]
