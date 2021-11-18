Extension { #name : #GtkAbstractListAdapter }

{ #category : #'*APart Patches' }
GtkAbstractListAdapter >> refreshWidgetSelection [
	| rowIndexes selection |

	self hasWidget ifFalse: [ ^ self ].

	rowIndexes := self presenter selection selectedIndexes.
	selection := self innerWidget selection.
	(selection allSelected collect: #first) asArray = rowIndexes
		ifTrue: [ ^ self ].

	self 
		disconnectSelectionEventsOf: self innerWidget 
		during: [ 		
			rowIndexes 
				ifNotEmpty: [ self innerWidget selection selectPath: rowIndexes ]
				ifEmpty: [ self innerWidget selection unselectAll ] ]
]
