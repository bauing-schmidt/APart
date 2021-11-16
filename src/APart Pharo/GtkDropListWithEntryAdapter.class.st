Class {
	#name : #GtkDropListWithEntryAdapter,
	#superclass : #GtkDropListAdapter,
	#category : #'APart Pharo'
}

{ #category : #building }
GtkDropListWithEntryAdapter >> setModelTo: gtkComboBox [
	| columnIndex |

	columnIndex := 0.
	gtkComboBox clear.
	self presenter hasIcons ifTrue: [ 
		gtkComboBox appendPixbufColumn: columnIndex.
		columnIndex := columnIndex + 1 ].
	gtkComboBox appendTextColumn: columnIndex.
	gtkComboBox entryTextColumn: columnIndex.
	gtkComboBox model: self newTreeStore.
	

]

{ #category : #building }
GtkDropListWithEntryAdapter >> widgetClass [
	
	^ GtkComboBoxWithEntry
]
