"
app := APartSpecApplication new.
	app useBackend: #Gtk with: ApartGtkConfiguration new.

	part := ApedColumnsEditorPart createWithClientRegistry.
	part locale: APartLocaleDeDE new.
	presenter := ApedColumnsEditorPresenter openOnPart: part application: app.
"
Class {
	#name : #ApedColumnsEditorPresenter,
	#superclass : #APartPresenter,
	#category : #'APart Form Editor-Columns'
}

{ #category : #API }
ApedColumnsEditorPresenter class >> associatedPresentersFor: aPresenter [

	^ OrderedDictionary newFrom: { 
			(#addStringColumn -> [ aPresenter newButton label: 'String']).
			(#addImageColumn -> [ aPresenter newButton label: 'Image']).
			(#addCompositeColumn -> [ aPresenter newButton label: 'Composite']).
			(#addCheckBoxColumn -> [ aPresenter newButton label: 'Checkbox']).
			(#columnsTree -> [ 
			   | aTree |
			   aTree := aPresenter newTreeTable
				           " dynamicContextMenu: #columnsContextMenu
				            in: aPresenter;"
				            yourself ]).
			(#currentColumn -> [ 
			   | part switchingPart |
				switchingPart := (aPresenter aspectFor: #currentColumnSwitchingPart) value.
			   part := (aPresenter aspectFor: #currentColumn) value.
			   APartPresenter newOnPart: part owner: aPresenter ]).
		}
]

{ #category : #API }
ApedColumnsEditorPresenter class >> defaultSpec [

	<spec>
	^ SpBoxLayout newHorizontal
		beHomogeneous;
		add: (SpBoxLayout newVertical
			add: (SpBoxLayout newHorizontal
				add: #addStringColumn;
				add: #addImageColumn;
				add: #addCompositeColumn;
				add: #addCheckBoxColumn) expand: false;
			add: #columnsTree expand: true);
		add: #currentColumn
]

{ #category : #API }
ApedColumnsEditorPresenter class >> matchingPartClass [

	^ApedColumnsEditorPart
]

{ #category : #API }
ApedColumnsEditorPresenter >> currentColumnSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface [

	| svClass subView newPart |

	newPart := (self aspectFor: #currentColumn) value.
	
	svClass := ApedColumnEditor allSubclasses detect: [ :each | each matchingPartClasses includes:  newPart class ].
		
	subView := svClass ifNotNil: [
		svClass asSubViewOn: self subInterface: aSwitchingInterface subInterface ].
	
	self setSubView: subView spec: #windowSpecGeneric inSubCanvas: #currentColumn
]

{ #category : #API }
ApedColumnsEditorPresenter >> partSwitched: anAnnouncement from: aSwitchingInterface [

	anAnnouncement containerId = #currentColumnSwitchingPart ifTrue: [
		^self currentColumnSwitchingPartSwitched: anAnnouncement from: aSwitchingInterface].

]
