"
The connector for an in-place editor (see APRsInPlaceAbstractEditor) connects the actual editor widget to a canvas by means of a Gtk overlay. It controls whether the editor widget is visible or not.

Whereas there is only one connector per canvas, this connector can repeatedly connect and disconnect editor instances, however restricted to exactly one editor at a time.
"
Class {
	#name : #APRsInPlaceEditConnector,
	#superclass : #Object,
	#instVars : [
		'overlay',
		'connectedEditor'
	],
	#category : #'APart Roassal Support-In-place Editor'
}

{ #category : #API }
APRsInPlaceEditConnector >> connectEditor: anEditor [

	connectedEditor == anEditor ifTrue: [^nil].
	connectedEditor ifNil: [
		connectedEditor := anEditor. 
		^self
	].
	self pdmError: 'Trying to overwrite connected editor'
]

{ #category : #accessing }
APRsInPlaceEditConnector >> connectedEditor [

	^ connectedEditor
]

{ #category : #API }
APRsInPlaceEditConnector >> disconnectEditor: anEditor [

	connectedEditor == anEditor ifFalse: [
		self pdmError: 'Trying to disconnect inactive editor'
	].
	self hide.
	connectedEditor := nil
]

{ #category : #API }
APRsInPlaceEditConnector >> hide [ 

	overlay content hide
]

{ #category : #API }
APRsInPlaceEditConnector >> leftWithEscape [

	connectedEditor ifNotNil: [connectedEditor leftWithEscape: self text]
]

{ #category : #API }
APRsInPlaceEditConnector >> leftWithReturn [

	connectedEditor ifNotNil: [connectedEditor leftWithReturn: self text]
]

{ #category : #API }
APRsInPlaceEditConnector >> show [ 

	overlay content show; grabFocus. 
]

{ #category : #API }
APRsInPlaceEditConnector >> text [

	^ overlay content text
]

{ #category : #API }
APRsInPlaceEditConnector >> text: aText [

	overlay content text: aText
]

{ #category : #API }
APRsInPlaceEditConnector >> useExtent: extent [

	overlay content setSizeRequestWidth: extent x height: extent y.

]

{ #category : #API }
APRsInPlaceEditConnector >> useOverlay: aGtkOverlay [

	overlay := aGtkOverlay.
	self hide.
]

{ #category : #API }
APRsInPlaceEditConnector >> useRectangle: aRect [
	| topLeft extent |
	
	topLeft := aRect topLeft.
	extent := aRect extent.
	overlay fixed moveChild: overlay content to: topLeft.
	overlay position: topLeft.
	overlay content setSizeRequestWidth: extent x height: extent y.
	self show
]
