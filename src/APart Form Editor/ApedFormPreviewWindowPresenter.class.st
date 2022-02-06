"
A presenter for a form preview in standalone window
"
Class {
	#name : #ApedFormPreviewWindowPresenter,
	#superclass : #APartPresenter,
	#category : #'APart Form Editor-Preview'
}

{ #category : #API }
ApedFormPreviewWindowPresenter class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: {
		(#preview -> [ aPresenter instantiate: ApedFormPreview ]).
	}
]

{ #category : #API }
ApedFormPreviewWindowPresenter class >> defaultLayout [

	<spec>
	^ SpBoxLayout newVertical
		add: #preview
]

{ #category : #API }
ApedFormPreviewWindowPresenter class >> matchingPartClass [

	^ApedFormPreviewWindowPart
]

{ #category : #'interface opening' }
ApedFormPreviewWindowPresenter >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter title: (self aPartTranslate: 'Form preview').

	aWindowPresenter initialExtent: 800@600.
	
	self client onNotification: #changeWindowTitle do: [ :title | aWindowPresenter title: title ].

	aWindowPresenter whenClosedDo: [ self partInterface closePart ].
		
]

{ #category : #'interface opening' }
ApedFormPreviewWindowPresenter >> openWithSpec: aSelector [

	"ignore the selector"

	application isNil ifTrue: [ self application: client specApplication ].
	^ super openWithLayout: (self layout)
]

{ #category : #'interface opening' }
ApedFormPreviewWindowPresenter >> partSwitched: anAnnouncement from: aSwitchingInterface [

	anAnnouncement containerId = #previewSwitchingPart ifTrue: [
		^self previewSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].

]

{ #category : #'interface opening' }
ApedFormPreviewWindowPresenter >> previewSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| subView newPart |

	newPart := (self aspectFor: #preview) value.
				
	subView := ApedFormPreview asSubViewOn: self subInterface: aSwitchingInterface subInterface.
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #preview.
	"for widgets that turn invisible after being wrapped with a GtkEventBox"
	self adapter widget showAll
]
