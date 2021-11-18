Extension { #name : #Timestamp }

{ #category : #'*APart Json Support-conversion' }
Timestamp class >> readFromPlainIso8601: aString [
	"[self readFromPlainIso8601: '2015-11-23']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937Z']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937+01:00']
	[self readFromPlainIso8601: '2015-11-23T09:10:55.937-04:00']"

	^self fromString: aString
]
