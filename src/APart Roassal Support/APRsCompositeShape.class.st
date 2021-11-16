"
APRsCompositeShape changes superclass behavior by avoiding unnecessary repeated computation of the #encompassingRectangle.
"
Class {
	#name : #APRsCompositeShape,
	#superclass : #RSComposite,
	#category : #'APart Roassal Support-Shapes'
}

{ #category : #'VisualWorks metadata' }
APRsCompositeShape class >> visualWorksMetadata [

	^ #(
		'superclassNamespace' 'Roassal2'
	)

]

{ #category : #accessing }
APRsCompositeShape >> encompassingRectangle [

	encompassingRectangle ifNil: [
		encompassingRectangle := Rectangle
						merging: (self shapes collect: #encompassingRectangle)
	].
	^encompassingRectangle
]

{ #category : #accessing }
APRsCompositeShape >> encompassingRectangle: anObject [

	encompassingRectangle := anObject
]
