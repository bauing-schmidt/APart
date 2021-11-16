"
a condition has a nil reason
"
Class {
	#name : #APNilReasonError,
	#superclass : #Error,
	#category : #'APart Basic-Errors'
}

{ #category : #accessing }
APNilReasonError >> messageText [

	^ 'aReason must not be nil'
]
