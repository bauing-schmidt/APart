Extension { #name : #Point }

{ #category : #'*APart Basic' }
Point >> downBy: aNumber [

	^x @ (y + aNumber)
]

{ #category : #'*APart Basic' }
Point >> half [
	^x half @ y half
]

{ #category : #'*APart Basic' }
Point >> leftBy: aNumber [

	^(x - aNumber) @ y
]

{ #category : #'*APart Basic' }
Point >> rightBy: aNumber [

	^(x + aNumber) @ y
]

{ #category : #'*APart Basic' }
Point >> upBy: aNumber [

	^x @ (y - aNumber)
]

{ #category : #'*APart Basic' }
Point >> x: xValue [ 
	
	x := xValue
]

{ #category : #'*APart Basic' }
Point >> y: yValue [ 
	
	y := yValue
]

{ #category : #'*APart Basic' }
Point class >> zero [ 
	^ 0@0
]
