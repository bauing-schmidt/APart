Class {
	#name : #ApedScrollLayoutPart,
	#superclass : #ApedLayoutPart,
	#category : #'APart Form Editor-Layout Parts'
}

{ #category : #accessing }
ApedScrollLayoutPart class >> iconName [

	^#greenArrowUpAndDown
]

{ #category : #accessing }
ApedScrollLayoutPart class >> layoutName [ 

	^'ScrollLayout'
]

{ #category : #'initialize-release' }
ApedScrollLayoutPart >> childClass [ 

	^ ApedScrollLayoutChildPart 
]

{ #category : #accessing }
ApedScrollLayoutPart >> maximalChildrenCount [

	^ 1
]

{ #category : #'initialize-release' }
ApedScrollLayoutPart >> previewLayout [ 

	| aLayout |
	aLayout := SpScrollableLayout new.
	
self children do: [ :aChild |
		| aChildLayout |
		aChildLayout := aChild previewLayout.
		aChildLayout ifNotNil: [  
			aLayout child: aChildLayout ] ].

	^ aLayout
]
