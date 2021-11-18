Extension { #name : #GtkTreeView }

{ #category : #'*APart Pharo' }
GtkTreeView >> connectRowCollapsed: aBlock [

	self 
		connect: 'row-collapsed' 
		signature: #(void (void *treeView, void *iter, void *path, void *userData))
		do: [ :treeView :iterHandle :pathHandle :userData | | iter path |
			iter := (GtkTreeIter fromHandle: iterHandle) copyInMemory.
			path := (GtkTreePath fromHandle: pathHandle) toArray.
			aBlock cull: iter cull: path  ]
]

{ #category : #'*APart Pharo' }
GtkTreeView >> isRowExpanded: path [

	^ self ffiCall: #(gboolean gtk_tree_view_row_expanded  (self, GtkTreePath *path))
]
