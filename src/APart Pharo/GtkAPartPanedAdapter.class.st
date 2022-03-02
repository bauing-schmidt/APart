Class {
	#name : #GtkAPartPanedAdapter,
	#superclass : #GtkPanedAdapter,
	#category : #'APart Pharo'
}

{ #category : #building }
GtkAPartPanedAdapter >> applyLayout: aLayout [

	widget := aLayout direction newWidgetOn: self.

	self connectToEvents: aLayout.
	
	widget connectRealize: [ 
		widget position: aLayout initialPosition. 
	].	

	aLayout positionOfSlider ifNotNil: [ :pos | 
		pos < 1
			ifTrue: [ self setPositionDeferred: aLayout positionOfSlider to: widget ]
			ifFalse: [ self setPosition: aLayout positionOfSlider to: widget ] ].
	widget wideHandle: true
]

{ #category : #building }
GtkAPartPanedAdapter >> setPositionDeferred: aNumber to: aWidget [

	"do nothing here, the initial position is set explicitly"
]
